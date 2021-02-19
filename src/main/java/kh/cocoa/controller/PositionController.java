package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.PositionDTO;
import kh.cocoa.service.PositionService;


@Controller
@RequestMapping("/position")
public class PositionController {
	@Autowired
	private PositionService pservice;
	
	@RequestMapping("/getPositionList.position")
	public NexacroResult getPositionList() {
		NexacroResult nr = new NexacroResult();
		
		List<PositionDTO> list = pservice.getPositionList();
	
		nr.addDataSet("out_position", list);
		return nr;
	}
}
