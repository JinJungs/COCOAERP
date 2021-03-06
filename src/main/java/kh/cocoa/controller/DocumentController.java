package kh.cocoa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
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

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;


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
	
	@Autowired
	private LeaveService lservice;
	
	@Autowired
	private Leave_Taken_UsedService ltuService;

	@Autowired
	private TemplateFormService templateFormService;
	
	//임시저장된 문서메인 이동
	@RequestMapping("d_searchTemporary.document")
	public String searchTemporaryList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, String status, Model model) {
		
		//0. 사번
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//1. 검색	-날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 검색-문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if (template == null || template.contentEquals("0")) {
			template = "0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		} else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if (searchOption == null) {
			searchOption = "title";
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getSearchNavi(empCode, startDate, endDate, templateList, searchText, Integer.parseInt(cpage), "TEMP");
		List<DocumentDTO> list = dservice.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
		//6. 결재선 받아오기
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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if (template == null || template.contentEquals("0")) {
			template = "0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		} else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if (searchOption == null) {
			searchOption = "title";
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if (template == null || template.contentEquals("0")) {
			template = "0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		} else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if (searchOption == null) {
			searchOption = "title";
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if (template == null || template.contentEquals("0")) {
			template = "0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		} else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if (searchOption == null) {
			searchOption = "title";
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
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
	//회수한 문서메인 이동
	@RequestMapping("d_searchReturn.document")
	public String searchReturnList(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model) {
		//0. 사번
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if (template == null || template.contentEquals("0")) {
			template = "0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		} else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		if (searchOption == null) {
			searchOption = "title";
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if (cpage == null) {
			cpage = "1";
		}
		int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

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
		//0. 사번 입력
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();

		//결재전 서류 권한 확인
		int getAuth = dservice.getAuthBD(Integer.parseInt(seq),empCode);

		DocumentDTO dto = dservice.getDocument(seq);
		List<FilesDTO> fileList = fservice.getFilesListByDocSeq(seq);
		List<ConfirmDTO> confirmList = cservice.getConfirmList(seq);

		String confirmStatus = cservice.isConfirmed(seq);
		model.addAttribute("auth",getAuth);
		model.addAttribute("empCode", empCode);
		model.addAttribute("dto", dto);
		model.addAttribute("fileList",fileList);
		model.addAttribute("confirmList", confirmList);
		model.addAttribute("confirmStatus", confirmStatus);
		
		int tempCode = tservice.getTempCode(dto.getTemp_code());
		if(tempCode==4) {
			return "/document/d_readReport";
		}else if(tempCode==5) {
			List<OrderDTO> orderList = oservice.getOrderListBySeq(seq);
			model.addAttribute("orderList", orderList);
			return "/document/d_readOrder";
		}else if(tempCode==6){
			return "/document/d_readLeave";
		}else {
			return "/document/d_readReport";
		}
	}

	//파일 다운로드
	@RequestMapping("fileDownload.document")
	public void download(FilesDTO dto, HttpServletResponse resp) throws Exception {
		String filePath = Configurator.boardFileRootC;
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

	
	//회수하기
	@RequestMapping("returnDocument.document")
	public String returnDocument(String seq) {
		dservice.ReturnDoc(seq);
		return "redirect:/document/d_searchReturn.document";
	}
	

	//재상신 동작
	@RequestMapping("submitToRewrite.document")
	public String reWrite(String seq, DocumentDTO dto, String submitType, Model model) {
		String status =  dservice.getStatusBySeq(seq);
		String temp_code = dservice.getTemp_codeBySeq(seq);
		
		if(status.contentEquals("TEMP")) {
			if(submitType.contentEquals("temp")) { //임시저장 -> 임시저장
				dservice.tempToUpdate(dto, temp_code, submitType);
			}else if(submitType.contentEquals("raise")) { //임시저장 -> 재상신
				dservice.tempToUpdate(dto, temp_code, submitType);
			}
		}else if(status.contentEquals("RETURN") || status.contentEquals("REJECT")) {
			
		}
		//dto 다시 받아오기
		dto = dservice.getDocument(seq);
		model.addAttribute("dto",dto);
		
		if(dto.getTemp_code()==4) {
			return "/document/d_readReport";
		}else if(dto.getTemp_code()==5) {
			return "/document/d_readOrder";
		}else {
			return "/document/d_readLeave";
		}
	}

	//문서대장
	@RequestMapping("allConfirmDoc.document")
	public String allConfirmDoc(Date startDate, Date endDate, String template, String searchOption, String searchText, String cpage, Model model){
		//1. 날짜
		//날짜정보(startDate,endDate)가 null일 경우 - startDate는 static 변수를, endDate는 오늘 날짜를 입력
		if(endDate==null) {endDate = new Date(System.currentTimeMillis());}
		if(startDate==null) {startDate = dservice.minusOneMonth(endDate);}
		//start날짜가 end날짜보다 후인경우 두 값을 바꿔주는 작업
		List<Date> dataList = dservice.reInputDates(startDate, endDate);
		startDate = dataList.get(0);
		endDate = dataList.get(1);
		//2. 문서 양식 
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		if(template==null || template.contentEquals("0")) {
			template="0";
			for(int i=3; i<tempList.size(); i++) {
				templateList.add(Integer.toString(tempList.get(i).getCode()));
			}
		}else {
			templateList.add(template);
		}
		//3.검색-옵션 설정, 날짜설정, 양식리스트
		List<String> searchOptionList = new ArrayList<>(); 
		if(searchOption==null) {
			searchOption = "title";
			searchOptionList.add("title");
			searchOptionList.add("dept_code");
			searchOptionList.add("writer_code");
		}else {
			searchOptionList.add(searchOption);
		}
		if(searchText==null) {
			searchText="";
		}
		Date today = new Date(System.currentTimeMillis());
		//4. cpage 보안
		if(cpage==null) {
			cpage="1";
		}
		int startRowNum = (Integer.parseInt(cpage)-1)*DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage -1;
		
		//5. 페이지네이션, 리스트 불러오기
		String navi = dservice.getAllDocNavi(startDate, endDate, templateList, searchOption, searchText, Integer.parseInt(cpage));
		List<DocumentDTO> docList = dservice.getAllConfirmDoc(startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);

		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("today", today);
		model.addAttribute("template", template);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchText", searchText);
		model.addAttribute("cpage", cpage);
		model.addAttribute("tempList", tempList);
		model.addAttribute("navi", navi);
		model.addAttribute("docList", docList);
		
		return "/document/allConfirmDoc";
	}
	//문서 전체보기
	@RequestMapping("allDocument.document")
	public String toWritOrder(Model model){
		//0. 사번
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		List<DocumentDTO> getBList =dservice.getAllBeforeConfirmList(empCode); //결재전
		List<DocumentDTO> getNFList =dservice.getAllNFConfirmList(empCode);
		List<DocumentDTO> getFList =dservice.getAllNFConfirmList(empCode);
		List<DocumentDTO> getRList =dservice.getAllRConfirmList(empCode);
		List<HashMap> hmlist = new ArrayList<>();
		for(int i=0;i<getBList.size();i++){
			HashMap<String,Object> map = new HashMap();
			map.put("seq",getBList.get(i).getSeq());
			map.put("dept_name",getBList.get(i).getDept_name());
			map.put("emp_name",getBList.get(i).getEmp_name());
			map.put("write_date",getBList.get(i).getWrite_date());
			map.put("title",getBList.get(i).getTitle());
			map.put("status","결재전");
			hmlist.add(map);
		}

		for(int i=0;i<getNFList.size();i++){
			HashMap<String,Object> map = new HashMap();
			map.put("seq",getNFList.get(i).getSeq());
			map.put("title",getNFList.get(i).getTitle());
			map.put("dept_name",getNFList.get(i).getDept_name());
			map.put("emp_name",getNFList.get(i).getEmp_name());
			map.put("write_date",getNFList.get(i).getWrite_date());
			map.put("status","진행중");
			hmlist.add(map);
		}

		for(int i=0;i<getFList.size();i++){
			HashMap<String,Object> map = new HashMap();
			map.put("seq",getFList.get(i).getSeq());
			map.put("dept_name",getFList.get(i).getDept_name());
			map.put("emp_name",getFList.get(i).getEmp_name());
			map.put("write_date",getFList.get(i).getWrite_date());
			map.put("title",getFList.get(i).getTitle());
			map.put("status","결재 완료");
			hmlist.add(map);
		}

		for(int i=0;i<getRList.size();i++){
			HashMap<String,Object> map = new HashMap();
			map.put("seq",getRList.get(i).getSeq());
			map.put("dept_name",getRList.get(i).getDept_name());
			map.put("emp_name",getRList.get(i).getEmp_name());
			map.put("write_date",getRList.get(i).getWrite_date());
			map.put("title",getRList.get(i).getTitle());
			map.put("status","반려함");
			hmlist.add(map);
		}
		
		//필요양식만 검색
		List<String> templateList = new ArrayList<>();
		List<TemplatesDTO> tempList = tservice.getTemplateList();
		for(int i=3; i<tempList.size(); i++) {
			templateList.add(Integer.toString(tempList.get(i).getCode()));
		}
		
		List<DocumentDTO> docList = dservice.getAllDraftDocument(empCode, templateList); //tempList
		for(int i=0; i<docList.size(); i++) {
			if(docList.get(i).getStatus().contentEquals("RAISE")) {
				docList.get(i).setStatus("결재중");
			}else if(docList.get(i).getStatus().contentEquals("REJECT")) {
				docList.get(i).setStatus("반려됨");
			}else if(docList.get(i).getStatus().contentEquals("CONFIRM")) {
				docList.get(i).setStatus("결재완료");
			}
		}

		model.addAttribute("clist",hmlist);
		model.addAttribute("docList", docList);
		
		return "document/allDocument";
	}
	
	//휴가신청시 잔여휴가 체크 후 신청가능여부
	@RequestMapping("canGetLeave.document")
	@ResponseBody
	public int canGetLeave() {
		//1. 사번
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		//2. 오늘 날짜(년도)
		Date today =  new Date(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String year = format.format(today);
		
		
		Leave_Taken_UsedDTO dto = ltuService.getLeaveStatus(empCode, year);
		int leaveCount = dto.getLeave_got() - dto.getLeave_used();
		return leaveCount;
	}
	
	//용국
	@GetMapping("toTemplateList.document")
	public String toTemplateList(Model model) {
		List<TemplateFormDTO> formList = templateFormService.getTempleateFormList();
		List<HashMap> hashMapList= new ArrayList<>();
		for(int i=0;i<formList.size();i++) {
			HashMap<String,Object> map = new HashMap<>();
			int count = tservice.getTemplateCount(formList.get(i).getCode());
			if(count!=0){
				map.put("count",count);
				map.put("title",formList.get(i).getTitle());
				map.put("contents",formList.get(i).getContents());
				map.put("code",formList.get(i).getCode());
				hashMapList.add(map);
			}

		}
		model.addAttribute("formList",hashMapList);
		return "/document/c_templateList";
	}

	@GetMapping("toWriteDocument.document")
	public String toWrtieDocument(TemplatesDTO dto, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		String deptName = deptservice.getDeptName();
		TemplatesDTO tempInfo = tservice.getTemplateInfo(dto.getCode());
		List<DepartmentsDTO> deptList = deptservice.getDeptList();
		EmployeeDTO getEmpinfo = eservice.getEmpInfo(empCode);
		model.addAttribute("dto",tempInfo);
		model.addAttribute("empInfo", getEmpinfo);
		model.addAttribute("size", deptList.size());
		model.addAttribute("deptName", deptName);
		model.addAttribute("deptList", deptList);
		model.addAttribute("temp_code",tempInfo.getCode());
		if (dto.getForm_code() == 4) {
			return "document/c_writeDocument";
		} else if (dto.getForm_code() == 5) {
			return "document/c_writeOrderDocument";
		} else if (dto.getForm_code() == 6) {
			return "document/c_writeLeaveDocument";
		} else {
			return "document/c_writeDocument";
		}
	}



	@RequestMapping("addconfirm.document")
	public String addconfirm(DocumentDTO ddto, @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code, @RequestParam("file") List<MultipartFile> file) throws Exception{
		int result = dservice.addDocument(ddto);
		int getDoc_code = dservice.getDocCode(ddto.getWriter_code());

		for (int i = 0; i < code.size(); i++) {
			int addConfirm = cservice.addConfirm(code.get(i), i + 1, getDoc_code);
		}

		if (!file.get(0).getOriginalFilename().contentEquals("")) {
			String fileRoot = Configurator.boardFileRootC;
			File filesPath = new File(fileRoot);
			if (!filesPath.exists()) {
				filesPath.mkdir();
			}
			for (MultipartFile mf : file) {
				if (!mf.getOriginalFilename().contentEquals("")) {
					String oriName = mf.getOriginalFilename();
					String uid = UUID.randomUUID().toString().replaceAll("_", "");
					String savedName = uid + "_" + oriName;
					int insertFile = fservice.documentInsertFile(oriName, savedName, getDoc_code);
					if (insertFile > 0) {
						File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
						FileCopyUtils.copy(mf.getBytes(), targetLoc);
					}
				}
			}
		}
		return "redirect:/document/d_searchRaise.document";
	}


	@RequestMapping("toBDocument.document")
	public String toBDocument(Model model,int cpage) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(empCode,cpage,"BD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getBeforeConfirmList(empCode,startRowNum,endRowNum);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", empCode);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		model.addAttribute("cpage",cpage);
		return "document/c_readBDocument";
	}

	@RequestMapping("toNFDocument.document")
	public String toNFDocument(Model model,int cpage) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(empCode,cpage,"NFD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getNFConfirmList(empCode,startRowNum,endRowNum);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", empCode);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		model.addAttribute("cpage",cpage);
		return "document/c_readNFDocument";
	}

	@RequestMapping("toFDocument.document")
	public String toFDocument(Model model,int cpage) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(empCode,cpage,"FD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getFConfirmList(empCode,startRowNum,endRowNum);
		model.addAttribute("cpage",cpage);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", empCode);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		return "document/c_readFDocument";
	}

	@RequestMapping("toRDocument.document")
	public String toRDocument(Model model,int cpage) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(empCode,cpage,"RD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getRConfirmList(empCode,startRowNum,endRowNum);
		model.addAttribute("cpage",cpage);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", empCode);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		return "document/c_readRDocument";
	}

	//재상신, 수정 페이지 이동
	@RequestMapping("reWrite.document")
	public String toReWrite(String seq, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		List<DepartmentsDTO> deptList = deptservice.getDeptList();
		DocumentDTO getModDocument= dservice.getModDocument(Integer.parseInt(seq));
		List<ConfirmDTO> getConfirmList =cservice.getConfirmList(seq);
		int getTempCode = tservice.getTempCode(getModDocument.getTemp_code());
		model.addAttribute("ddto",getModDocument);
		model.addAttribute("clist",getConfirmList);
		model.addAttribute("user",empCode);
		model.addAttribute("dlist",deptList);
		model.addAttribute("ori_temp_code",getTempCode);

		if(getTempCode==4) {
			return "/document/c_modSaveD";
		}else if(getTempCode==5){
			return "/document/c_modSaveO";
		}else if(getTempCode==6){
            return "/document/c_modSaveL";
        }
		return "redirect:/";
	}

	@RequestMapping("confirm.document")
	public String confirm(int seq,String comments){
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		int getIsLast =dservice.getIsLast(seq);
		
		if(getIsLast==1){
			dservice.confirm(seq,empCode);
			dservice.addIsConfirm(seq,empCode,comments);
			
			//휴가신청서의 경우 휴가 사용처리(조퇴 제외 처리가능)
			DocumentDTO dto = dservice.getDocument(Integer.toString(seq));
			if(dto.getTemp_code() == 06) {
				//0. process컬럼에 N넣어주기
				dservice.setProcessN(seq);
				//1. 사용처리
				LeaveDTO ldto = new LeaveDTO();
				ldto.setType(dto.getLeave_type());
				ldto.setStart_date(dto.getLeave_start());
				ldto.setEnd_date(dto.getLeave_end());
				if(dto.getLeave_type().contentEquals("반차")) {
					ldto.setTime(4);
				}
				ldto.setEmp_code(dto.getWriter_code());
				if(!ldto.getType().contentEquals("조퇴") || !ldto.getType().contentEquals("기타")) {
					lservice.insert(ldto);
					//process컬럼에 N넣어주기
					dservice.setProcessN(seq);
				}
				//2. 잔여 휴가일 계산해서 빼기
				//2-1. 기간 받아오기
				Date today =  new Date(System.currentTimeMillis());
				SimpleDateFormat format = new SimpleDateFormat("yyyy");
				String year = format.format(today);
				String yearStart = year + "-01-01";
				String yearEnd = year + "-12-31";
				int durationSum = lservice.getDuration(dto.getWriter_code(), yearStart, yearEnd); //기간 합
				//2-2. 시간 받아오기
				int timeSum = lservice.getTimeSum(dto.getWriter_code(), yearStart, yearEnd);
				durationSum = durationSum + (timeSum / 8);
				//3. 사용날짜 다시 입력해주기
				ltuService.updateUsed(durationSum, year, dto.getWriter_code());
				
			}
		}else{
			dservice.addIsConfirm(seq,empCode,comments);
		}

		return "redirect:/document/toBDocument.document?cpage=1";
	}

	@RequestMapping("return.document")
	public String returnD(int seq,String comments){
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		if(loginDTO==null){
			return "redirect:/";
		}
		dservice.returnD(seq,empCode);
		dservice.addRIsConfirm(seq,empCode,comments);
		return "redirect:/document/toRDocument.document?cpage=1";
	}

}