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
	@RequestMapping("toTempMain.document")
	public String toTempMain(Model model) {
		List<DocumentDTO> list = dservice.getTemporaryList();
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
	}
	@RequestMapping("d_searchTemporary.document")
	public String searchTemporaryList(Date startDate, Date endDate, String template, Model model) {
		
		
		
		System.out.println("startDate : " + startDate);
		System.out.println("endDate : " + endDate);
		System.out.println("template : " + template);
		
		List<DocumentDTO> list = dservice.getSearchTemporaryList(startDate, endDate, template);
		
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
	}

	//상신한 문서메인 이동
	@RequestMapping("toRaiseMain.document")
	public String toRaiseMain(Model model) {
		List<DocumentDTO> list = dservice.getRaiseList();
		model.addAttribute("list", list);
		return "/document/d_raiseMain";
	}

	//승인된 문서메인 이동
	@RequestMapping("toApprovalMain.document")
	public String toApprovalMain(Model model) {
		List<DocumentDTO> list = dservice.getApprovalList();
		model.addAttribute("list", list);
		return "/document/d_approvalMain";
	}

	//반려된 문서메인 이동
	@RequestMapping("toRejectMain.document")
	public String toRejectMain(Model model) {
		List<DocumentDTO> list = dservice.getRejectList();
		model.addAttribute("list", list);
		return "/document/d_rejectMain";
	}

	//회수한 문서메인 이동
	@RequestMapping("toReturnMain.document")
	public String toReturnMain(Model model) {
		List<DocumentDTO> list = dservice.getReturnList();
		model.addAttribute("list", list);
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


