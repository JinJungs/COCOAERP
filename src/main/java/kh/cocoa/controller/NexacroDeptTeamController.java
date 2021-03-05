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
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.DeptOrganizationDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.PositionService;
import kh.cocoa.service.TeamService;

@Controller
@RequestMapping("/nexDeptTeam")
public class NexacroDeptTeamController {
	
	@Autowired
	DepartmentsService ddservice;
	
	@Autowired
	TeamService tservice;
	
	@Autowired
	PositionService pservice;
	
	@Autowired
	EmployeeService eservice;
	
	//부서 조직도 불러오기
	
	@RequestMapping("/nexOrganDept.nex")
	public NexacroResult dsDeptList() {
		NexacroResult nr = new NexacroResult();
		List<DeptOrganizationDTO> org_list = new ArrayList<>();
		List<DepartmentsDTO> dept_list = ddservice.getDeptListOrderByCode();
		
		for(DepartmentsDTO i : dept_list) {
			int dept_code = i.getCode();
			String dept_name = i.getName();
			DeptOrganizationDTO dto = new DeptOrganizationDTO();
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
			System.out.println(i+" 번째 부서 dto : "+dto);
			
			List<TeamDTO> t_list = tservice.getTeamListByDeptCode(dept_code);
			for(TeamDTO j : t_list) {
				DeptOrganizationDTO dtoj = new DeptOrganizationDTO();
				dtoj.setOrg_nm(j.getName());
				dtoj.setOrg_cd(j.getCode());
				dtoj.setP_org_cd(dept_code);
				dtoj.setLevel(2);
				org_list.add(dtoj);
				System.out.println(i+"번째 부서의 팀 dtoj : "+dtoj);
			}
			//무소속 팀
			if(tservice.countNoTeam(dept_code)>0 && i.getCode()!=0) {
				DeptOrganizationDTO dtoNone = new DeptOrganizationDTO();
				dtoNone.setOrg_nm("무소속");
				dtoNone.setOrg_cd(-1);
				dtoNone.setP_org_cd(dept_code);
				dtoNone.setLevel(2);
				org_list.add(dtoNone);
				System.out.println(i+"번째 부서의 무소속 : "+dtoNone);
			}
		}
		//사원 전체 불러오기
		List<EmployeeDTO> emp_list = eservice.getAllEmployeeOrderByCode();
		nr.addDataSet("out_emp_list", emp_list);
		nr.addDataSet("out_org_list", org_list);
		return nr;
	}
	
	//저장하기
	@RequestMapping("saveOrgan.nex")
	public NexacroResult saveOrgan(@ParamDataSet(name="in_ds_org") List<Map<String,Object>> dataList) {
		System.out.println(dataList);
        int size = dataList.size();
        
        List<DepartmentsDTO> dAddList = new ArrayList<>();
        List<TeamDTO> tAddList = new ArrayList<>();
        
        List<DepartmentsDTO> dModifList = new ArrayList<>();
        List<TeamDTO> tModifList = new ArrayList<>();
        
        List<DepartmentsDTO> dDelList = new ArrayList<>();
        List<TeamDTO> tDelList = new ArrayList<>();
        
        for (int i=0; i<size; i++) {
            Map<String,Object> emp = dataList.get(i);
            String org_nm = (String)emp.get("org_nm");
            int level = (int)emp.get("level");
            int org_cd; 
            int p_org_cd;
            if((int)emp.get("p_org_cd")!= 0) {
            	p_org_cd = (int)emp.get("p_org_cd");
            }else{
            	p_org_cd = 0;
            };
            if((int)emp.get("org_cd")>0) {
            	org_cd = (int)emp.get("org_cd");
            }else {
            	org_cd = 0;
            }
            //DeptOrganizationDTO dto = new DeptOrganizationDTO().builder().org_nm(org_nm).org_cd(org_cd).p_org_cd(p_org_cd).level(level).build();
            
            int rowType = Integer.parseInt(String.valueOf(emp.get(DataSetRowTypeAccessor.NAME)));
            if (rowType == DataSet.ROW_TYPE_INSERTED){
               System.out.println("추가된 로우 : "+ emp);
               //System.out.println(dto);
               if(level==1) {
            	   //부서
            	   DepartmentsDTO dDto = new DepartmentsDTO();
            	   dDto.setName(org_nm);
            	   System.out.println("add할 부서 : "+dDto);
            	   dAddList.add(dDto);
               }else if(level==2) {
            	   //팀
            	   TeamDTO tDto = new TeamDTO();
            	   tDto.setName(org_nm);
            	   tDto.setDept_code(p_org_cd);
            	   System.out.println("add할 팀 : "+tDto);
            	   tAddList.add(tDto);
               }
               
            }else if (rowType == DataSet.ROW_TYPE_UPDATED){
            	System.out.println("수정된 로우 : "+ emp);
            	if(level==1) {
             	   //부서
             	   DepartmentsDTO dDto = new DepartmentsDTO();
             	   dDto.setCode(org_cd);
             	   dDto.setName(org_nm);
             	   System.out.println("modify할 부서 : "+dDto);
             	   dModifList.add(dDto);
                }else if(level==2) {
             	   //팀
             	   TeamDTO tDto = new TeamDTO();
             	   tDto.setName(org_nm);
             	   tDto.setCode(org_cd);
             	   tDto.setDept_code(p_org_cd);
             	   System.out.println("modify할 팀 : "+tDto);
             	   tModifList.add(tDto);
                }
            }else if (rowType == DataSet.ROW_TYPE_DELETED){
            	System.out.println("삭제된 로우 : "+ emp);
            	if(level==1) {
              	   //부서
              	   DepartmentsDTO dDto = new DepartmentsDTO();
              	   dDto.setCode(org_cd);
              	   System.out.println("del할 부서 : "+dDto);
              	   dDelList.add(dDto);
                 }else if(level==2) {
              	   //팀
              	   TeamDTO tDto = new TeamDTO();
              	   tDto.setCode(org_cd);
              	   System.out.println("del할 팀 : "+tDto);
              	   tDelList.add(tDto);
                 }
            }
        }
        //추가리스트 / 수정리스트 / 삭제리스트
        if(dAddList.size()>0)
        {
        	ddservice.addDept(dAddList);
        }
        if(tAddList.size()>0) {
        	tservice.addTeam(tAddList);
        }
        if(dModifList.size()>0) {
        	ddservice.updateDept(dModifList);
        }
        if(tModifList.size()>0) {
        	tservice.updateTeam(tModifList);
        }
        if(dDelList.size()>0) {
        	ddservice.deleteDept(dDelList);
        }
        if(tDelList.size()>0) {
        	tservice.deleteTeam(tDelList);
        }
		NexacroResult nr = new NexacroResult();
		return nr;
	}

}
