package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.service.DocumentService;

@Controller
@RequestMapping("/documentN")
public class NexacroDocumentController {
	
	@Autowired
	private DocumentService dservice;
	
	/*넥사크로*/
	@GetMapping("getEarlyList.documentN")
	public NexacroResult getEarlyList() {
		System.out.println("도큐먼트 받기");
		NexacroResult nr = new NexacroResult();
		List<DocumentDTO> list = dservice.getLeaveListConfirmed();
		
		nr.addDataSet("out_document", list);
		
		return nr;
	}
}
