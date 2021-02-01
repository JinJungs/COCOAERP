package kh.cocoa.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.EmailDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmailService;
import kh.cocoa.service.EmployeeService;

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
	private EmployeeService employeeService;
	
	@RequestMapping("emailSend.email")
	public String emailSend(String receiver_email) throws Exception{
		
		String setfrom = request.getParameter("email"); //보내는 사람 (Employee에서 Email&B_Email)
		String tomail = request.getParameter("receiver_email"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
		String contents = request.getParameter("contents");


	
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(contents); // 메일 내용

			mailSender.send(message);
		
		return "bugReport/bugReportView"; //추우 메인 홈페이지로 변경해야함      
	}
	
	//메일페이지
	@RequestMapping("sendPage.email")
	public String toSendPage() {
		return "email/sendPage";
	}
	
	//메일쓰기
		@RequestMapping("sendEmail.email")
		public String sendPage(EmailDTO dto) {
			//사번으로 이메일 셋팅
			/*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
			int empCode = (Integer)loginDTO.getCode();*/
			dto.setSender("yhk@cocoa.com");//dto.setEmp_code(empCode);
			
			
			//제목없을 때 (제목없음) 입력
			if(dto.getTitle().contentEquals("")) {
				dto.setTitle("(제목 없음)");
			}
			
			//receiverEmail로 받는사람 사번구하기
			int isEmailExist = employeeService.isEmailExist(dto.getReceiver());
			
			 //수신자 있을 때
			if(isEmailExist >0) {
				eservice.sendEmail(dto);
			} //이메일 잘못 쓸 경우 처리
			else {
				eservice.sendEmail(dto); //일단 메일 전송
				//1. 수신자 메일 글쓴이로
				dto.setReceiver(dto.getSender());
				//2. 작성자 메일 관리자로
				dto.setSender("admin@cocoa.com"); //admin계정을 만들거나 null 허용 필요 - 일단 0으로 넣음
				//3. 메일 제목
				String title = dto.getTitle();
				title = "[발송실패 안내] " + dto.getReceiver() + "으로  메일이 전송되지 못했습니다.";
				dto.setTitle(title);
				
				//4. 메일 내용
				String contents = dto.getContents();
				contents = "받는 사람의 메일 주소가 정확한지 확인하고 다시 전송해주세요.\n"
							+ "내용 : " + contents; 
				dto.setContents(contents);
				
				eservice.sendEmail(dto);
			}
			return "email/sendPage";
		}
		//메일리스트 
		@RequestMapping("receiveList.email")
		public String receiveList() {
			return "email/listReceive";
		}
		
	
		
		
	/*-----------------------예외처리-----------------------*/
	@ExceptionHandler
	public String exceptionhandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
