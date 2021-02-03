package kh.cocoa.controller;


import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TeamService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
        List<EmployeeDTO> s2 = employeeService.getDeptNamesearchList(name);
        JSONArray json = new JSONArray();
        json.put(s1);
        json.put(s2);
        return json.toString();
    }
}
