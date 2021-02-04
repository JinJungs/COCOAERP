package kh.cocoa.controller;


import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TeamService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/restorganchart")
public class RestOrganChartController {

    @Autowired
    private TeamService teamService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private DepartmentsService departmentsService;

    @RequestMapping("/getteamlist.organ")
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

    @RequestMapping("getteamemplist.organ")
    public String getTeamEmpList(int team_code){
        List<EmployeeDTO> list=employeeService.getTeamEmpList(team_code);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("getEmptyTeamInfo.organ")
    public String getEmptyTeamInfo(@RequestParam("team_code") int team_code){
        TeamDTO getTeamName =teamService.getTeamName(team_code);
        JSONObject json = new JSONObject(getTeamName);
        return json.toString();
    }

    @RequestMapping("getSearchList.organ")
    public String getSearchList(@RequestParam("name") String name){
        List<EmployeeDTO> s1 = employeeService.getEmpNameSearchList(name);
        List<EmployeeDTO> s2 = employeeService.getDeptNameSearchList(name);
        JSONArray json = new JSONArray();
        json.put(s1);
        json.put(s2);
        return json.toString();
    }

    @RequestMapping("getEmpInfo.organ")
    public String getEmpInfo(@RequestParam("code") int code){
        EmployeeDTO info = employeeService.getEmpInfo(code);
        JSONObject json = new JSONObject(info);
        return json.toString();
    }

    @RequestMapping("getDeptEmpList.organ")
    public String getDeptEmpList(@RequestParam("code") int code){
        List<EmployeeDTO> info = employeeService.getDeptEmpList(code);
        JSONArray json = new JSONArray(info);
        return json.toString();
    }

    @RequestMapping("getDeptEmptyInfo.organ")
    public String getDeptEmptyInfo(@RequestParam("code") int code){
        DepartmentsDTO getDeptName = departmentsService.getDeptNameByCode(code);
        JSONObject json = new JSONObject(getDeptName);
        return json.toString();
    }

    @RequestMapping("getAllEmpList.organ")
    public String getAllEmpList(){
        List<EmployeeDTO> all =employeeService.getAllEmpListOrderByPos();
        JSONArray json = new JSONArray(all);
        return json.toString();
    }

    @RequestMapping("getSearchTopDept.organ")
    public String getSearchTopDept(@RequestParam("name") String name){
        DepartmentsDTO getTop = departmentsService.getSearchTopDept(name);
        int count = employeeService.getAllEmpCount();
        HashMap<String,Object> map = new HashMap<>();
        if(getTop!=null) {
            map.put("count",count);
            map.put("name", getTop.getName());
            map.put("code", getTop.getCode());
        }
        JSONObject json = new JSONObject(map);
        return json.toString();
    }

    @RequestMapping("getSearchTeamList.organ")
    public String getSearchTeamList(@RequestParam("name") String name){

    }
}
