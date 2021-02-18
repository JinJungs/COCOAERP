package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.service.DepartmentsService;

@Controller
@RequestMapping("/department")
public class DepartmentController {
	
	@Autowired
	private DepartmentsService dservice;
	
	@RequestMapping("/getDeptList.department")
	public NexacroResult getDeptList() {
		NexacroResult nr = new NexacroResult();
		
		List<DepartmentsDTO> list = dservice.getDeptListForFilter();
	
		nr.addDataSet("out_departments", list);
		return nr;
	}
}
