package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.service.DocumentService;


@Controller
@RequestMapping("/document")
public class DocumentController {

	@Autowired
	private DocumentService dservice;

	//임시저장된 문서메인 이동
	@RequestMapping("toTempMain.document")
	public String toTempMain(Model model) {
		List<DocumentDTO> list = dservice.getTemporaryList();
		model.addAttribute("list", list);
		return "/document/d_temporaryMain";
	}
	@RequestMapping("d_searchTemporary.document")
	public String searchTemporaryList(Model model) {
		List<DocumentDTO> list = dservice.getSearchTemporaryList();
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
}
