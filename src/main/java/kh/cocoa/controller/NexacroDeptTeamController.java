package kh.cocoa.controller;

import java.util.ArrayList;
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
import kh.cocoa.dto.OrganizationDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.TeamService;

@Controller
@RequestMapping("/nexDeptTeam")
public class NexacroDeptTeamController {
	
	@Autowired
	DepartmentsService ddservice;
	
	@Autowired
	TeamService tservice;
	
	//부서 조직도 불러오기
	
	@RequestMapping("/nexOrganDept.nex")
	public NexacroResult dsDeptList() {
		System.out.println("nexOrgan.nex 도착! 가라 조직도!");
		NexacroResult nr = new NexacroResult();
		List<OrganizationDTO> org_list = new ArrayList<>();
		List<DepartmentsDTO> dept_list = ddservice.getDeptListOrderByCode();
		
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
				dtoj.setOrg_nm(j.getName());
				dtoj.setOrg_cd(j.getCode());
				dtoj.setP_org_cd(dept_code);
				dtoj.setLevel(2);
				org_list.add(dtoj);
			}
		}	
		nr.addDataSet("out_org_list", org_list);
		return nr;
	}
	
	//저장하기
	@RequestMapping("saveOrgan.nex")
	public NexacroResult saveOrgan(@ParamDataSet(name="in_ds_org") List<Map<String,Object>> dataList) {
		System.out.println(dataList);
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

		NexacroResult nr = new NexacroResult();
		return nr;
	}

}
