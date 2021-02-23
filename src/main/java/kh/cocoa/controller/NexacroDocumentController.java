package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@RequestMapping("getEarlyList.documentN")
	public NexacroResult getEarlyList() {
		NexacroResult nr = new NexacroResult();
		try {
			List<DocumentDTO> list = dservice.getLeaveListConfirmed();
			
			nr.addDataSet("out_document", list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return nr;
	}
	
}
