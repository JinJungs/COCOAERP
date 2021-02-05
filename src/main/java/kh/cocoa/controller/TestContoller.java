package kh.cocoa.controller;

import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TeamService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/test")
public class TestContoller {

    @Autowired
    private TeamService teamService;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private DepartmentsService departmentsService;

    @RequestMapping("getTeamList")
    public String getTeamList(@RequestParam("code")List<Integer> code){
        List<TeamDTO> list = new ArrayList<>();
        List<HashMap> hmlist = new ArrayList<>();
        for(int i=0;i<code.size();i++){
            list=teamService.getTeamList(code.get(i));
            for(int j=list.size()-1;j>=0;j--){
                HashMap map = new HashMap<>();
                int getTemaCount=employeeService.getTeamCount(list.get(j).getCode());
                map.put("count",getTemaCount);
                map.put("team_code",list.get(j).getCode());
                map.put("team_name",list.get(j).getName());
                map.put("dept_code",list.get(j).getDept_code());
                hmlist.add(map);
            }
        }
        JSONArray json = new JSONArray(hmlist);
        return json.toString();
    }

    @RequestMapping("getemplist")
    public String getemplist(@RequestParam("team_code")List<Integer> team_code){
        List<EmployeeDTO> getTeamList = new ArrayList<>();

        List<HashMap> hmlist = new ArrayList<>();
        for(int i=0;i<team_code.size();i++) {
            getTeamList=employeeService.getTeamEmp(team_code.get(i));
            for(int j=0;j<getTeamList.size();j++){
                HashMap map = new HashMap<>();
                map.put("code",getTeamList.get(j).getCode());
                map.put("name",getTeamList.get(j).getName());
                map.put("dept_code",getTeamList.get(j).getDept_code());
                map.put("dept_name",getTeamList.get(j).getDeptname());
                map.put("pos_code",getTeamList.get(j).getPos_code());
                map.put("pos_name",getTeamList.get(j).getPosname());
                map.put("team_code",getTeamList.get(j).getTeam_code());
                map.put("team_name",getTeamList.get(j).getTeamname());
                hmlist.add(map);
            }
        }
        JSONArray json = new JSONArray(hmlist);
        return json.toString();
    }

    @RequestMapping("getSearchList")
    public String getSearchList(@RequestParam("name")String name){
        List<EmployeeDTO> s1 = employeeService.getEmpNameSearchList(name);
        List<TeamDTO> s2 = teamService.getSearchTeamList(name);
        List<EmployeeDTO> s3 = employeeService.getDeptNameSearchList(name);
        JSONArray json = new JSONArray();
        json.put(s1);
        json.put(s2);
        json.put(s3);
        return json.toString();
    }

    @RequestMapping("getDeptList")
    public String getDeptList(){
        List<DepartmentsDTO> getDeptList = departmentsService.getDeptList();
        JSONArray json = new JSONArray(getDeptList);
        return json.toString();
    }
}
