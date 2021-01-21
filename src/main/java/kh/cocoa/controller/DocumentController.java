package kh.cocoa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TemplateService;
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
	private TemplateService tservice;

	@Autowired
	private DepartmentsService deptservice;

	@Autowired
	private EmployeeService eservice;

	//임시저장된 문서메인 이동
	@RequestMapping("toTempMain.document")
	public String toTempMain(Model model) {
		List<DocumentDTO> list = dservice.getTempList();
		System.out.println("리스트 크기" + list.size());
		for (int i = 0; i < list.size(); i++) {
			System.out.println(i + "  " + list.get(i).getStatus());
		}
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
	}

	//상신한 문서메인 이동
	@RequestMapping("toRaiseMain.document")
	public String toRaiseMain(Model model) {
		List<DocumentDTO> list = dservice.getTempList();
		model.addAttribute("list", list);
		return "/document/d_raiseMain";
	}

	//승인된 문서메인 이동
	@RequestMapping("toApprovalMain.document")
	public String toApprovalMain(Model model) {
		List<DocumentDTO> list = dservice.getTempList();
		model.addAttribute("list", list);
		return "/document/d_confirmMain";
	}

	//반려된 문서메인 이동
	@RequestMapping("toRejectMain.document")
	public String toRejectMain(Model model) {
		List<DocumentDTO> list = dservice.getTempList();
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
	}

	//회수한 문서메인 이동
	@RequestMapping("toReturnMain.document")
	public String toReturnMain(Model model) {
		List<DocumentDTO> list = dservice.getTempList();
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
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
		List<EmployeeDTO> getOrganChart = new ArrayList<>();
		getOrganChart= eservice.getOrganChart();
		model.addAttribute("deptName",deptName);
		model.addAttribute("name","권용국");
		model.addAttribute("dto",dto);
		model.addAttribute("chart",getOrganChart);
		return "document/c_writeDocument";
	}
}


