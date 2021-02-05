package kh.cocoa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.cocoa.dto.EmailDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.EmailService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;
import kh.cocoa.statics.DocumentConfigurator;

//import kh.cocoa.service.EmailServices;

@Controller
@RequestMapping("/email")
public class EmailController {

	@Autowired
	private JavaMailSender mailSender; 

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpSession session;
	
	@Autowired
	private EmailService eservice;
	
	@Autowired
	private FilesService fservice;
	
	@Autowired
	private EmployeeService employeeService;
	
	@RequestMapping("emailSend.email")
	public String emailSend(String receiver_email) throws Exception{

		String setfrom = request.getParameter("sender_email"); //보내는 사람 (Employee에서 Email&B_Email)
		String tomail = request.getParameter("receiver_email"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
		String contents = request.getParameter("contents");

		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

		messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
		messageHelper.setTo(tomail); // 받는사람 이메일
		messageHelper.setSubject(title); // 메일제목은 
		messageHelper.setText(contents); // 메일 내용

		mailSender.send(message);

		return "bugReport/bugReportView"; //추우 메인 홈페이지로 변경해야함      
	}
	
	//메일작성페이지
	@RequestMapping("sendPage.email")
	public String toSendPage() {
		return "email/sendPage";
	}
	
	//메일쓰기
	@RequestMapping("sendEmail.email")
	public String sendPage(EmailDTO dto, @RequestParam("file") List<MultipartFile> file) throws Exception{
		//사번으로 이메일 셋팅
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();*/
		dto.setSender("yhk@cocoa.com");//dto.setEmp_code(empCode);
		
		//제목없을 때 (제목없음) 입력
		if(dto.getTitle().contentEquals("")) {
			dto.setTitle("(제목 없음)");
		}
		
		//내용 없을 때
		if(dto.getContents().contentEquals("")) {
			dto.setContents(" ");
		}
		
		//receiverEmail로 받는사람 사번구하기
		int isEmailExist = employeeService.isEmailExist(dto.getReceiver());
		
		//seq받아와서 세팅
		int seq = eservice.getSeq();
		dto.setSeq(seq);
		
		 //수신자 있을 때
		if(isEmailExist >0) {
			eservice.sendEmail(dto);
		} //이메일 잘못 쓸 경우 처리
		else {
			eservice.sendEmail(dto); //일단 메일 전송
			//1. 메일 제목
			String title = dto.getTitle();
			title = "[발송실패 안내] " + dto.getReceiver() + "으로 메일이 전송되지 못했습니다.";
			dto.setTitle(title);
			//2. 수신자 메일 글쓴이로
			String sender = dto.getReceiver();
			dto.setReceiver(dto.getSender());
			//3. 작성자 메일 관리자로
			dto.setSender("admin@cocoa.com"); //admin계정을 만들거나 null 허용 필요 - 일단 0으로 넣음
			//4. 메일 내용
			EmailDTO originEmail = eservice.getEmail(Integer.toString(seq));
			Date date = originEmail.getWrite_date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String stringDate = format.format(date);
			
			String contents = dto.getContents();
			contents = "받는 사람의 메일 주소가 정확한지 확인하고 다시 전송해주세요.\n"
						+ "받는 사람 : " + sender + "\n"
						+ "작성 시간 : " + stringDate + "\n"
						+ "\n내용 : " + contents; 
			dto.setContents(contents);
			dto.setSeq(eservice.getSeq());
			eservice.sendEmail(dto);
		}
		
		//파일저장
		if(file.isEmpty() == false) {
			String realPath = Configurator.emailFileRoot;
			File filesPath = new File(realPath);
			//폴더 없으면 만들기
			if(!filesPath.exists()) {filesPath.mkdir();}

			List<MultipartFile> filelist = new ArrayList<MultipartFile>();
			//빈 파일 넘어오면 거르기
			for(int i=0; i<file.size(); i++) {
				if(!file.get(i).getOriginalFilename().isEmpty()) {
					filelist.add(file.get(i));
				}
			}

			for(MultipartFile mf : filelist) {
				String oriName = mf.getOriginalFilename();
				String uid = UUID.randomUUID().toString().replaceAll("-", "");

				String savedName = uid + "_" + oriName;
				System.out.println("파일 명 : " + oriName);
				FilesDTO fdto = new FilesDTO(oriName, savedName, seq);
				int insert = fservice.insertFile(fdto);
				if(insert>0) {
					File targetLoc = new File(filesPath.getAbsoluteFile()+ "/" +savedName);
					FileCopyUtils.copy(mf.getBytes(), targetLoc);
				}
			}
		}

		return "redirect:/email/sendList.email?cpage=1";
	}
	//받은메일 리스트 
	@RequestMapping("receiveList.email")
	public String receiveList(String cpage, Model model) {
		//이메일 받아오기
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String email = loginDTO.getEmail();*/
		String email = "yhk@cocoa.com";
		
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		
		List<EmailDTO> emailList = eservice.receiveList(email, startRowNum, endRowNum);
		String navi = eservice.getNavi(email, "receive", Integer.parseInt(cpage));
		
		model.addAttribute("emailList", emailList);
		model.addAttribute("cpage", cpage);
		model.addAttribute("navi", navi);
		
		return "email/listReceive";
	}
	//내가 쓴 리스트 
	@RequestMapping("sendList.email")
	public String sendList(String cpage, Model model) {
		//이메일 받아오기
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String email = loginDTO.getEmail();*/
		String email = "yhk@cocoa.com";

		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

		List<EmailDTO> emailList = eservice.sendList(email, startRowNum, endRowNum);
		String navi = eservice.getNavi(email, "send", Integer.parseInt(cpage));
		
		model.addAttribute("emailList", emailList);
		model.addAttribute("cpage", cpage);
		model.addAttribute("navi", navi);
		
		return "email/listSend";
	}
	//휴지통 리스트 
	@RequestMapping("deleteList.email")
	public String deleteList(String cpage, Model model) {
		//이메일 받아오기
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String email = loginDTO.getEmail();*/
		String email = "yhk@cocoa.com";
		
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

		
		List<EmailDTO> emailList = eservice.deleteList(email, startRowNum, endRowNum);
		String navi = eservice.getNavi(email, "delete", Integer.parseInt(cpage));
		
		model.addAttribute("emailList", emailList);
		model.addAttribute("cpage", cpage);
		model.addAttribute("navi", navi);
		
		return "email/listDelete";
	}
	@RequestMapping("readPage.email")
	public String toReadPage(String seq,  Model model) throws Exception {
		//이메일 받아오기
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String email = loginDTO.getEmail();*/
		String email = "yhk@cocoa.com";
				
		EmailDTO dto = eservice.getEmail(seq);
		List<FilesDTO> fileList = fservice.getEmailFiles(seq);
		
		Date date = dto.getWrite_date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String stringDate = format.format(date);
		dto.setWrite_dateString(stringDate);
		
		model.addAttribute("dto", dto);
		model.addAttribute("email", email);
		model.addAttribute("fileList", fileList);
		
		return "email/readPage";
	}
	
	//파일 다운로드
	@RequestMapping("fileDownload.email")
	public void download(FilesDTO dto, HttpServletResponse resp) throws Exception {
		String filePath = Configurator.emailFileRoot;
		File targetFile = new File(filePath + "/" + dto.getSavedname());
		// 다음 위치에 있는 파일을 파일 객체로 만든다 -> 정보를 뽑아낼 수 있게 하기 위해서
		String oriName = dto.getOriname();
		oriName = new String(oriName.getBytes("UTF-8"), "ISO-8859-1");
		if (targetFile.exists() && targetFile.isFile()) {
			resp.setContentType("application/octet-stream; charset=utf8");
			// 마치 우리가 html문서라고 명시하고 text문서를 웹브라우저에 전송하게 되면 알아서 해주는 것처럼
			// 지금 text 보내는게 아니라 파일의 내용이니까 utf-8으로 렌더링하라고 전달
			resp.setContentLength((int) targetFile.length());
			resp.setHeader("Content-Disposition", "attachment; filename=\"" +oriName+ "\"");
			// 다운로드 받을 때 컴퓨터에 저장될 이름을 설정
			FileInputStream fis = new FileInputStream(targetFile);
			ServletOutputStream sos = resp.getOutputStream();
			FileCopyUtils.copy(fis, sos);
			fis.close();
			sos.flush();
			sos.close();
		}
	}
	
	
	@RequestMapping("deleteChecked.email")
	public String deleteChecked(String checkedList, String status){
		String[] delArr = checkedList.split(",");
		
		for(int i=0; i<delArr.length; i++) {
			eservice.deleteEmail(delArr[i]);
		}
		if(status.contentEquals("receive")) {
			return "redirect:/email/receiveList.email";
		}else {
			return "redirect:/email/sendList.email";
		}
	}
	@RequestMapping("deleteNChecked.email")
	public String deleteNChecked(String checkedList){
		String[] delArr = checkedList.split(",");
		
		for(int i=0; i<delArr.length; i++) {
			eservice.deleteNEmail(delArr[i]);
		}
		
		return "redirect:/email/deleteList.email";
	}
	@RequestMapping("deleteEmail.email")
	public String deleteEmail(String seq, String status) {
		//이메일 받아오기
		/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String email = loginDTO.getEmail();*/
		String email = "yhk@cocoa.com";
		
		EmailDTO dto = eservice.getEmail(seq);
		eservice.deleteEmail(seq);
		
		if(dto.getReceiver().contentEquals(email)) {
			return "redirect:/email/receiveList.email?cpage=1";
		}else {
			return "redirect:/email/sendList.email?cpage=1";
		}
	}
	@RequestMapping("deleteNEmail.email")
	public String deleteNEmail(String seq) {
		eservice.deleteNEmail(seq);
		
		return "redirect:/email/deleteList.email?cpage=1";
	}
	@RequestMapping("replyEmail.email")
	public String replyEmail(String seq, Model model) {
		
		EmailDTO dto = eservice.getEmail(seq);

		Date date = dto.getWrite_date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String stringDate = format.format(date);
		
		String contents =  "\n\n\n----------------------------------------------------------------------------\n";
		contents = contents + " 보내는 사람 : " + dto.getSender() + "\n";
		contents = contents + " 받는 사람 : " + dto.getReceiver() + "\n";
		contents = contents + " 작성 시간 : " + stringDate + "\n\n";
		contents = contents + dto.getContents();
		
		String title = "re: " + dto.getTitle(); 
		
		dto.setTitle(title);
		dto.setContents(contents);
		
		model.addAttribute("dto", dto);
		return "email/sendPage";
	}
	/*-----------------------예외처리-----------------------*/
	@ExceptionHandler
	public String exceptionhandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
