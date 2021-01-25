package kh.cocoa.controller;

import com.google.gson.JsonArray;
import com.sun.org.apache.bcel.internal.generic.ANEWARRAY;
import kh.cocoa.dto.DepartmentsDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TeamDTO;
import kh.cocoa.service.ConfirmService;
import kh.cocoa.service.DepartmentsService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TeamService;
import kh.cocoa.statics.DocumentConfigurator;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/restdocument")
public class RestDocumentController {

    @Autowired
    private TeamService tservice;

    @Autowired
    private DepartmentsService dservice;

    @Autowired
    private EmployeeService eservice;

    @Autowired
    private ConfirmService cservice;


    @RequestMapping("getteamlist.document")
    public String getTeamList(int code){
        List<TeamDTO> getTeamList = new ArrayList<>();
        getTeamList=tservice.getTeamList(code);
        JSONArray json = new JSONArray(getTeamList);

        return json.toString();
    }

    @RequestMapping("getemplist.document")
    public String getEmpList(int code){
        List<EmployeeDTO> getEmpPosList = new ArrayList<>();
        getEmpPosList=eservice.getEmpPos(code);
        JSONArray json = new JSONArray(getEmpPosList);

        return json.toString();
    }



    @RequestMapping("addconfirmlist.document")
    public String addConfirmList(int code){
        List<EmployeeDTO> list =eservice.getConfirmEmp(code);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("addmainconfirmlist.document")
    public String addMainConfirmList(@RequestParam(value = "code",required = true)List<Integer> code){
        System.out.println(code.size());
        List<EmployeeDTO> getConfirmInfo = new ArrayList<>();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        for(int i=0;i<code.size();i++){
            getConfirmInfo=eservice.getConfirmEmp(code.get(i));
            HashMap<String,Object> map = new HashMap<>();
            map.put("code",code.get(i));
            map.put("emp_name",getConfirmInfo.get(0).getName());
            map.put("dept_name",getConfirmInfo.get(0).getDeptname());
            map.put("pos_name",getConfirmInfo.get(0).getPosname());
            hmlist.add(map);
        }

        JSONArray json = new JSONArray(hmlist);
        return json.toString();
    }
}
