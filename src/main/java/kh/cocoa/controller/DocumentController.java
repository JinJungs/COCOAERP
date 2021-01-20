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
		List<DocumentDTO> list = dservice.getTempList();
		System.out.println("리스트 크기" + list.size());
		for(int i=0; i<list.size();i++) {
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
}
