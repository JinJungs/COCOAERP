package kh.cocoa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Date;
import java.util.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.Doc_confirmDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.TemplatesService;

import kh.cocoa.dto.*;
import kh.cocoa.service.*;
import kh.cocoa.statics.Configurator;

import kh.cocoa.statics.DocumentConfigurator;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/document")
public class DocumentController {
	@Autowired
	private DocumentService dservice;

	@Autowired
	private TemplatesService tservice;

	@Autowired
	private DepartmentsService deptservice;

	@Autowired
	private EmployeeService eservice;

	@Autowired
	private FilesService fservice;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ConfirmService cservice;

	@Autowired
	private OrderService oservice;

	//임시저장된 문서메인 이동
	@RequestMapping("d_searchTemporary.document")
	public String searchTemporaryList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, String status, Model model) {
		//0. 사번
		String empCode = "1004";
		//1. 검색	-날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(startDate==null) {startDate = DocumentConfigurator.startDate;}
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 검색-문서 양식 
		List<String> templateList = new ArrayList<>();
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if(searchOption == null) {
			searchOption = "title";
		}
		Date today = new Date(System.currentTimeMillis());
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "TEMP");
		List<DocumentDTO> list = dservice.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);

		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		
		return "/document/d_temporaryMain";
	}

	//상신한 문서메인 이동
	@RequestMapping("d_searchRaise.document")
	public String searchRaiseList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model) {
		//0. 사번
		String empCode = "1004";
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(startDate==null) {startDate = DocumentConfigurator.startDate;}
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if(searchOption == null) {
			searchOption = "title";
		}
		Date today = new Date(System.currentTimeMillis());
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "RAISE");
		List<DocumentDTO> list = dservice.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		
		return "/document/d_raiseMain";
	}
	//승인된 문서메인 이동
	@RequestMapping("d_searchApproval.document")
	public String searchApprovalList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model) {
		//0. 사번
		String empCode = "1004";
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(startDate==null) {startDate = DocumentConfigurator.startDate;}
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if(searchOption == null) {
			searchOption = "title";
		}
		Date today = new Date(System.currentTimeMillis());
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "CONFIRM");
		List<DocumentDTO> list = dservice.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		
		return "/document/d_approvalMain";
	}
	//반려된 문서메인 이동
	@RequestMapping("d_searchReject.document")
	public String searchRejectList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model) {
		//0. 사번
		String empCode = "1004";
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(startDate==null) {startDate = DocumentConfigurator.startDate;}
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if(searchOption == null) {
			searchOption = "title";
		}
		Date today = new Date(System.currentTimeMillis());
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "REJECT");
		List<DocumentDTO> list = dservice.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		
		return "/document/d_rejectMain";
	}
	@RequestMapping("d_searchReturn.document")
	public String searchReturnList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model) {
		//0. 사번
		String empCode = "1004";
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(startDate==null) {startDate = DocumentConfigurator.startDate;}
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if(searchOption == null) {
			searchOption = "title";
		}
		Date today = new Date(System.currentTimeMillis());
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "RETURN");
		List<DocumentDTO> list = dservice.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		
		return "/document/d_returnMain";
	}
	//페이지 읽기
	@RequestMapping("toReadPage.document")
	public String toReadPage(String seq, Model model) {
		DocumentDTO dto = dservice.getDocument(seq);
		List<FilesDTO> fileList = fservice.getFilesListByDocSeq(seq);
		List<ConfirmDTO> confirmList = cservice.getConfirmList(seq);
		
		model.addAttribute("dto", dto);
		model.addAttribute("fileList",fileList);
		model.addAttribute("confirmList", confirmList);
		
		if(dto.getTemp_code()==4) {
			return "/document/d_readReport";
		}else if(dto.getTemp_code()==5) {
			return "/document/d_readOrder";
		}else {
			return "/document/d_readLeave";
		}
	}
	//파일 다운로드
	@RequestMapping("fileDownload.document")
	public void download(FilesDTO dto, String docSeq, HttpServletResponse resp) throws Exception {
		//파일경로받기
		String filePath = session.getServletContext().getRealPath("files");
		File targetFile = new File(filePath + "-" + dto.getSavedname());

		//타겟파일이 없는 경우 처리
		if(targetFile.exists() && targetFile.isFile()) { //isFile = (폴더가 아니라) 파일인가
			System.out.println("파일이 없음");
			
			//리퀘스트: 헤드-바디 구조. 헤드에 보낼 데이터의 타입, 길이, 처리정보 등이 담겨있음
			resp.setContentType("application/octet-stream; charset=utf8"); 
			// => 디폴트 text/html로 인식하고 html로 랜더링하려함
			resp.setContentLength((int)targetFile.length());
			resp.setHeader("Content-Disposition", "attachment; filename=\""+dto.getOriname() +"\"");

			//소켓통신시 사용했던 명령어(서버의 ssd에 통로를 열라는? 명령어)
			FileInputStream fis = new FileInputStream(targetFile); 
			ServletOutputStream sos = resp.getOutputStream();
			FileCopyUtils.copy(fis, sos);//(A,B) A에서 B로 보내라는 뜻_B가 원래 클라이언트의 ssd여야함
			fis.close();

			sos.flush();
			sos.close();
			//직접 Response를 다뤘기때문에 디스패처는 얘를 처리할 수 없음}
		}
		//return "redirect:/document/toReadPage.document?seq="+docSeq;
	}
	
	//용국
	@GetMapping("toTemplateList.document")
	public String toTemplateList(Model model) {
		List<TemplatesDTO> list = tservice.getTemplateList();
		List<TemplatesDTO> subList = tservice.getSubTemplateList();
		model.addAttribute("list",list);
		model.addAttribute("size",list.size());
		model.addAttribute("sublist",subList);
		model.addAttribute("subsize",subList.size());
		return "/document/c_templateList";
	}

	@GetMapping("toWriteDocument")
	public String toWrtieDocument(TemplatesDTO dto,Model model){
		String deptName = deptservice.getDeptName();
		List<DepartmentsDTO> deptList = new ArrayList<>();
		EmployeeDTO getEmpinfo = new EmployeeDTO();
		getEmpinfo=eservice.getEmpInfo(1000);
		deptList=deptservice.getDeptList();
		model.addAttribute("temp_code",dto.getCode());
		model.addAttribute("empInfo",getEmpinfo);
		model.addAttribute("size",deptList.size());
		model.addAttribute("deptName",deptName);
		model.addAttribute("name","권용국");
		model.addAttribute("dto",dto);
		model.addAttribute("deptList",deptList);
		dto.setCode(4);
		if(dto.getCode()==4) {
            return "document/c_writeDocument";
        }else if(dto.getCode()==5){
		    return "document/c_writeOrderDocument";
        }else if(dto.getCode()==6){
			return "document/c_writeLeaveDocument";
		}else{
            return "document/c_writeDocument";
        }
	}

}


