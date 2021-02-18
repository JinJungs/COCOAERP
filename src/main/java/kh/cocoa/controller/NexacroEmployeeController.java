package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.NexacroFakeEmployeeDTO;
import kh.cocoa.dto.NexacroSearchDTO;
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
	//리스트 불로오기 온로드
	@RequestMapping("/nexEmpList.nex")
	public NexacroResult dsEmpList() {
		NexacroResult nr = new NexacroResult();
		//사원 전체 불러오기
		List<EmployeeDTO> emp_list = eservice.getAllEmployeeOrderByCode();
		//부서목록 불러오기(전체 : -10)
		List<DepartmentsDTO> dept_list = ddservice.getDeptListWithout0();
		DepartmentsDTO dept_all = new DepartmentsDTO(-10,"전체",0);
		dept_list.add(0, dept_all);
		//팀목록 불러오기(전체 : -10)
		List<TeamDTO> team_list = tservice.getAllTeamList();
		TeamDTO team_all = new TeamDTO().builder().code(-10).name("전체").build();
		team_list.add(0,team_all);
		//직위 목록 불러오기
		List<PositionDTO> pos_list = pservice.getAllPosList();
		PositionDTO pos_all = new PositionDTO().builder().code(-10).name("전체").build();
		pos_list.add(0,pos_all);
		
		nr.addDataSet("out_emp_list",emp_list);
		nr.addDataSet("out_dept_list", dept_list);
		nr.addDataSet("out_team_list", team_list);
		nr.addDataSet("out_pos_list", pos_list);
		return nr;
	}
	
	//검색 
	@RequestMapping("/nexEmpSearch.nex")
	public NexacroResult nexEmpSearch(@ParamDataSet(name="in_ds_search")NexacroSearchDTO dto) {
		int dept_code = dto.getDept_code();
		int team_code = dto.getTeam_code();
		int pos_code = dto.getPos_code();
		String search = dto.getSearch();
		String searchWhat = dto.getSearchWhat();
		System.out.println("nexEmpSearch 도착. 들어온 값 : ");
		System.out.println(dto);
		System.out.println("검색하고나서 ㅣ ");
		List<EmployeeDTO> emp_list = eservice.searchEmployee(dto);
		System.out.println(emp_list);
		
		NexacroResult nr = new NexacroResult();
		nr.addDataSet("out_emp_list", emp_list);
		return nr;
	}
	
	//지금까지 작업한 내용 저장
	@RequestMapping("/nexSave.nex")
	public NexacroResult nexSave(@ParamDataSet(name="in_ds_employee")List<NexacroFakeEmployeeDTO> list) {
		NexacroResult nr = new NexacroResult();
		System.out.println("nexSave.nex 도착");

		System.out.println(list);

		return nr;
	}

	

	
	
}
