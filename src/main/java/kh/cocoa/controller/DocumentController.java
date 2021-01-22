package kh.cocoa.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TemplatesService;
import kh.cocoa.statics.DocumentConfigurator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.service.DocumentService;


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

	//임시저장된 문서메인 이동
	@RequestMapping("d_searchTemporary.document")
	public String searchTemporaryList(Date startDate, Date endDate, String template, String searchOption, String searchText, Model model) {
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
			templateList.add("1");
			templateList.add("2");
			templateList.add("3");
		}else {
			templateList.add(template);
		}
		
		//3.검색어 + 옵션
		if(searchOption == null) {
			searchOption = "title";
		}
		//4. 페이지네이션
		/*String navi = bservice.getSearchNavi(searchText);
		*/
		List<DocumentDTO> list = dservice.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		
		return "/document/d_temporaryMain";
	}

	//상신한 문서메인 이동
	@RequestMapping("d_searchRaise.document")
	public String searchRaiseList(Date startDate, Date endDate, String template, String searchOption, String searchText, Model model) {
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
			templateList.add("1");
			templateList.add("2");
			templateList.add("3");
		}else {
			templateList.add(template);
		}
		
		//3.검색어 + 옵션
		if(searchOption == null) {
			searchOption = "title";
		}
		List<DocumentDTO> list = dservice.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		
		return "/document/d_raiseMain";
	}
	//승인된 문서메인 이동
	@RequestMapping("d_searchApproval.document")
	public String searchApprovalList(Date startDate, Date endDate, String template, String searchOption, String searchText, Model model) {
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
			templateList.add("1");
			templateList.add("2");
			templateList.add("3");
		}else {
			templateList.add(template);
		}
		
		//3.검색어 + 옵션
		if(searchOption == null) {
			searchOption = "title";
		}
		List<DocumentDTO> list = dservice.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		
		return "/document/d_approvalMain";
	}
	//반려된 문서메인 이동
	@RequestMapping("d_searchReject.document")
	public String searchRejectList(Date startDate, Date endDate, String template, String searchOption, String searchText, Model model) {
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
			templateList.add("1");
			templateList.add("2");
			templateList.add("3");
		}else {
			templateList.add(template);
		}
		
		//3.검색어 + 옵션
		if(searchOption == null) {
			searchOption = "title";
		}
		List<DocumentDTO> list = dservice.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		
		return "/document/d_rejectMain";
	}
	@RequestMapping("d_searchReturn.document")
	public String searchReturnList(Date startDate, Date endDate, String template, String searchOption, String searchText, Model model) {
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
			templateList.add("1");
			templateList.add("2");
			templateList.add("3");
		}else {
			templateList.add(template);
		}
		
		//3.검색어 + 옵션
		if(searchOption == null) {
			searchOption = "title";
		}
		List<DocumentDTO> list = dservice.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		
		return "/document/d_returnMain";
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
		deptList=deptservice.getDeptList();
		model.addAttribute("size",deptList.size());
		model.addAttribute("deptName",deptName);
		model.addAttribute("name","권용국");
		model.addAttribute("dto",dto);
		model.addAttribute("deptList",deptList);
		return "document/c_writeDocument";
	}
}


