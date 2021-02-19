package kh.cocoa.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;

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
		//팀목록 불러오기(전체 : -10)
		List<TeamDTO> team_list = tservice.getAllTeamList();
		//직위 목록 불러오기
		List<PositionDTO> pos_list = pservice.getAllPosList();
		
		//콤보에 전체 항목 넣기 위해 : 넥사에서 하는방법 찾기
		/*
		PositionDTO pos_all = new PositionDTO().builder().code(-10).name("전체").build();
		pos_list.add(0,pos_all);
		DepartmentsDTO dept_all = new DepartmentsDTO(-10,"전체",0);
		dept_list.add(0, dept_all);
		TeamDTO team_all = new TeamDTO().builder().code(-10).name("전체").build();
		team_list.add(0,team_all);
		*/
		
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
	public NexacroResult nexSave(@ParamDataSet(name="in_ds_employee")List<Map<String,Object>> dataList) {
		NexacroResult nr = new NexacroResult();
		System.out.println("nexSave.nex 도착");
		int size = dataList.size();
        for (int i=0; i<size; i++) {
            Map<String,Object> emp = dataList.get(i);
            int rowType = Integer.parseInt(String.valueOf(emp.get(DataSetRowTypeAccessor.NAME)));
            if (rowType == DataSet.ROW_TYPE_INSERTED){
               System.out.println("추가된 로우 : "+ emp);
            }else if (rowType == DataSet.ROW_TYPE_UPDATED){
            	System.out.println("수정된 로우 : "+ emp);
            }else if (rowType == DataSet.ROW_TYPE_DELETED){
            	System.out.println("삭제된 로우 : "+ emp);
            }
        }

		return nr;
	}

	

	
	
}
