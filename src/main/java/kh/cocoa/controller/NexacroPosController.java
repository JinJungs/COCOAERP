package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.PositionDTO;
import kh.cocoa.service.PositionService;

@Controller
@RequestMapping("/nexPos")
public class NexacroPosController {
	
	@Autowired
	PositionService pservice;
	
	@RequestMapping("/loadPosList.nex")
	public NexacroResult loadPosList() {
		System.out.println("M13 포스로딩도착!");
		NexacroResult nr = new NexacroResult();
		//직위 목록 불러오기
		List<PositionDTO> pos_list = pservice.getAllPosList();
		nr.addDataSet("out_pos_list", pos_list);
		System.out.println(pos_list);
		return nr;
	}
}
