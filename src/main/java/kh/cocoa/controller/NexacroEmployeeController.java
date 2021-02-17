package kh.cocoa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.OrganizationDTO;
import kh.cocoa.dto.PositionDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.PositionService;
import kh.cocoa.service.TeamService;

@Controller
@RequestMapping("/nexEmployee")
public class NexacroEmployeeController {

	@Autowired
	EmployeeService eservice;
	
	@Autowired
	DepartmentsService ddservice;
	@Autowired
	TeamService tservice;
	@Autowired
	PositionService pservice;
	
	@RequestMapping("/nexEmpList.nex")
	public NexacroResult dsEmpList() {
		NexacroResult nr = new NexacroResult();
		List<EmployeeDTO> emp_list = eservice.getAllEmployeeOrderByCode();
		List<DepartmentsDTO> dept_list = ddservice.getDeptListOrderByCode();
		List<TeamDTO> team_list = tservice.getAllTeamList();
		List<PositionDTO> pos_list = pservice.getAllPosList();
		
		nr.addDataSet("out_emp_list",emp_list);
		nr.addDataSet("out_dept_list", dept_list);
		nr.addDataSet("out_team_list", team_list);
		nr.addDataSet("out_pos_list", pos_list);
		return nr;
	}
	
	@RequestMapping("/nexOrganDept.nex")
	public NexacroResult dsDeptList() {
		System.out.println("nexOrgan.nex 도착! 가라 조직도!");
		NexacroResult nr = new NexacroResult();
		List<OrganizationDTO> org_list = new ArrayList<>();
		List<DepartmentsDTO> dept_list = ddservice.getDeptListOrderByCode();
		List<TeamDTO> team_list = tservice.getAllTeamList();
		
		for(DepartmentsDTO i : dept_list) {
			int dept_code = i.getCode();
			String dept_name = i.getName();
			OrganizationDTO dto = new OrganizationDTO();
			dto.setOrg_nm(i.getName());
			dto.setOrg_cd(i.getCode());
			//기업 최고 단위 제외
			if(i.getCode()!=0) {
				dto.setP_org_cd(0);
				dto.setLevel(1);			
				
			}else {
				dto.setLevel(0);
			}
			org_list.add(dto);
			
			List<TeamDTO> t_list = tservice.getTeamListByDeptCode(dept_code);
			for(TeamDTO j : t_list) {
				OrganizationDTO dtoj = new OrganizationDTO();
				dto.setOrg_nm(j.getName());
				dto.setOrg_cd(j.getCode());
				dto.setP_org_cd(dept_code);
				dto.setLevel(2);
				org_list.add(dtoj);
			}
		}
		//dept_code별로 team_list 뽑기
		//첫번째 부서코드
		

		System.out.println(org_list);
		nr.addDataSet("out_org_list", org_list);
		return nr;
	}
	
	
}
