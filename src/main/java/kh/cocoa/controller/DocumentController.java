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
		System.out.println("template = " + template);
		
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
		if (template == null || template.contentEquals("0")) {
			template = "0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
		if (template == null || template.contentEquals("0")) {
			template = "0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
		if (template == null || template.contentEquals("0")) {
			template = "0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
		if (template == null || template.contentEquals("0")) {
			template = "0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
		if (template == null || template.contentEquals("0")) {
			template = "0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
		
		DocumentDTO dto = dservice.getDocument(seq);
		List<FilesDTO> fileList = fservice.getFilesListByDocSeq(seq);
		List<ConfirmDTO> confirmList = cservice.getConfirmList(seq);
		
		String confirmStatus = cservice.isConfirmed(seq);
		
		model.addAttribute("empCode", empCode);
		model.addAttribute("dto", dto);
		model.addAttribute("fileList",fileList);
		model.addAttribute("confirmList", confirmList);
		model.addAttribute("confirmStatus", confirmStatus);
		
		if(dto.getTemp_code()==4) {
			return "/document/d_readReport";
		}else if(dto.getTemp_code()==5) {
			List<OrderDTO> orderList = oservice.getOrderListBySeq(seq);
			model.addAttribute("orderList", orderList);
			return "/document/d_readOrder";
		}else if(dto.getTemp_code()==6){
			return "/document/d_readLeave";
		}else {
			return "/document/d_readReport";
		}
	}

	//파일 다운로드
	@RequestMapping("fileDownload.document")
	public void download(FilesDTO dto, String docSeq, HttpServletResponse resp) throws Exception {
		//파일경로받기
		String filePath = session.getServletContext().getRealPath("files");
		File targetFile = new File(filePath + "-" + dto.getSavedname());

		//타겟파일이 없는 경우 처리
		if (targetFile.exists() && targetFile.isFile()) { //isFile = (폴더가 아니라) 파일인가
			System.out.println("파일이 없음");

			//리퀘스트: 헤드-바디 구조. 헤드에 보낼 데이터의 타입, 길이, 처리정보 등이 담겨있음
			resp.setContentType("application/octet-stream; charset=utf8");
			// => 디폴트 text/html로 인식하고 html로 랜더링하려함
			resp.setContentLength((int) targetFile.length());
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + dto.getOriname() + "\"");

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
	@GetMapping("allConfirmDoc.document")
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
		if(template==null || template.contentEquals("0")) {
			template="0";
			templateList.add("4");
			templateList.add("5");
			templateList.add("6");
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
		List<TemplatesDTO> tempList = tservice.getTemplateList();
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
	@GetMapping("allDocument.document")
	public String toWritOrder(Model model){
		//0. 사번
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		
		List<DocumentDTO> docList = dservice.getAllDraftDocument(empCode);
		
		for(int i=0; i<docList.size(); i++) {
			if(docList.get(i).getStatus().contentEquals("RAISE")) {
				docList.get(i).setStatus("결재중");
			}else if(docList.get(i).getStatus().contentEquals("REJECT")) {
				docList.get(i).setStatus("반려됨");
			}else if(docList.get(i).getStatus().contentEquals("CONFIRM")) {
				docList.get(i).setStatus("결재완료");
			}
		}
		
		model.addAttribute("docList", docList);
		
		return "document/allDocument";
	}
	//용국
	@GetMapping("toTemplateList.document")
	public String toTemplateList(Model model) {
		List<TemplatesDTO> list = tservice.getTemplateList2();
		List<TemplatesDTO> subList = tservice.getSubTemplateList();
		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("sublist", subList);
		model.addAttribute("subsize", subList.size());
		return "/document/c_templateList";
	}

	@GetMapping("toWriteDocument")
	public String toWrtieDocument(TemplatesDTO dto, Model model) {

		String deptName = deptservice.getDeptName();
		List<DepartmentsDTO> deptList = new ArrayList<>();
		EmployeeDTO getEmpinfo = new EmployeeDTO();
		getEmpinfo = eservice.getEmpInfo(1000);
		deptList = deptservice.getDeptList();
		model.addAttribute("temp_code", dto.getCode());
		model.addAttribute("empInfo", getEmpinfo);
		model.addAttribute("size", deptList.size());
		model.addAttribute("deptName", deptName);
		model.addAttribute("name", "권용국");
		model.addAttribute("dto", dto);
		model.addAttribute("deptList", deptList);
		if (dto.getCode() == 4) {
			return "document/c_writeDocument";
		} else if (dto.getCode() == 5) {
			return "document/c_writeOrderDocument";
		} else if (dto.getCode() == 6) {
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
		return "redirect:toTemplateList.document";
	}


	@RequestMapping("toBDocument.document")
	public String toBDocument(Model model,int cpage) {
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(1006,cpage,"BD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getBeforeConfirmList(1006,startRowNum,endRowNum);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", 1006);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		model.addAttribute("cpage",cpage);
		return "document/c_readBDocument";
	}

	@RequestMapping("toNFDocument.document")
	public String toNFDocument(Model model,int cpage) {
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(1006,cpage,"NFD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getNFConfirmList(1006,startRowNum,endRowNum);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", 1006);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		model.addAttribute("cpage",cpage);
		return "document/c_readNFDocument";
	}

	@RequestMapping("toFDocument.document")
	public String toFDocument(Model model,int cpage) {
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(1006,cpage,"FD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getFConfirmList(1006,startRowNum,endRowNum);
		model.addAttribute("cpage",cpage);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", 1006);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		return "document/c_readFDocument";
	}

	@RequestMapping("toRDocument.document")
	public String toRDocument(Model model,int cpage) {
		List<DocumentDTO> list = new ArrayList<>();
		List<TemplatesDTO> getTemplatesList = new ArrayList<>();
		getTemplatesList = tservice.getTemplateList2();
		String getNavi = dservice.getNavi(1006,cpage,"RD");
		int startRowNum = ((cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
		int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;
		list = dservice.getRConfirmList(1006,startRowNum,endRowNum);
		model.addAttribute("cpage",cpage);
		model.addAttribute("navi",getNavi);
		model.addAttribute("user", 1006);
		model.addAttribute("tempList", getTemplatesList);
		model.addAttribute("list", list);
		return "document/c_readRDocument";
	}

	//재상신, 수정 페이지 이동
	@RequestMapping("reWrite.document")
	public String toReWrite(String seq, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int empCode = (Integer)loginDTO.getCode();
		List<DepartmentsDTO> deptList = deptservice.getDeptList();

		DocumentDTO getModDocument= dservice.getModDocument(Integer.parseInt(seq));

		List<ConfirmDTO> getConfirmList =cservice.getConfirmList(seq);
		System.out.println(getConfirmList);

		model.addAttribute("ddto",getModDocument);
		model.addAttribute("clist",getConfirmList);
		model.addAttribute("user",empCode);
		model.addAttribute("dlist",deptList);

		if(getModDocument.getTemp_code()==4) {
			return "/document/c_modSaveD";
		}
		return "redirect:/";
	}

}


