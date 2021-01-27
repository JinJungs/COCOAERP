package kh.cocoa.controller;

import java.io.File;
import java.sql.Date;
import java.util.*;

import javafx.util.Builder;
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
	private ConfirmService cservice;

	@Autowired
	private FilesService fservice;

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
		
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "TEMP");
		System.out.println("nave : " + navi);
		List<DocumentDTO> list = dservice.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		
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
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "RAISE");
		List<DocumentDTO> list = dservice.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		
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
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "CONFIRM");
		List<DocumentDTO> list = dservice.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
				
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		
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
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "REJECT");
		System.out.println("nave : " + navi);
		List<DocumentDTO> list = dservice.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
				
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		
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
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "RETURN");
		System.out.println("nave : " + navi);
		List<DocumentDTO> list = dservice.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
				
		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("list", list);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		
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
		if(dto.getCode()==4) {
            return "document/c_writeDocument";
        }else{
		    return "document/c_writeOrderDocument";
        }
	}

	@PostMapping("addconfirm.document")
	public String addConfirm(@RequestParam("file") List<MultipartFile> file, DocumentDTO docdto, @RequestParam(value = "approver_code",required = true)List<Integer> code,
							 OrderDTO odto) throws Exception{

		int result = dservice.addDocument(docdto);
		int getDoc_code = dservice.getDocCode(docdto.getWriter_code());

		/*if(result >0){

			for(int i=0;i<code.size();i++){
				int addConfirm = cservice.addConfirm(code.get(i),i+1,getDoc_code);
			}
			if(!file.get(0).getOriginalFilename().contentEquals("")) {
				String fileRoot = Configurator.boardFileRootC;
				File filesPath = new File(fileRoot);
				if(!filesPath.exists()){filesPath.mkdir();}
				for(MultipartFile mf : file){
					String oriName = mf.getOriginalFilename();
					String uid = UUID.randomUUID().toString().replaceAll("_","");
					String savedName = uid+"_"+ oriName;
					int insertFile = fservice.documentInsertFile(oriName,savedName,getDoc_code);
					if(insertFile>0){
						File targetLoc = new File(filesPath.getAbsoluteFile()+"/"+savedName);
						FileCopyUtils.copy(mf.getBytes(),targetLoc);
					}
				}
			}
		}*/
		return "redirect:toTemplateList.document";
	}
}


