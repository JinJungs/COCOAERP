package kh.cocoa.controller;

import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import kh.cocoa.dto.AtdChangeReqDTO;
import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.statics.Configurator;
import org.json.JSONArray;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/attendance")
@Slf4j
public class AttendanceController {
    @Autowired
    AttendanceService attenService;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/toAttendanceView")
    public String toTA(Model model) {
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        if (loginSession==null){
            return "/";
        }
        List<AttendanceDTO> attendance = attenService.getAttendanceList(loginSession.getCode());
        model.addAttribute("attendance", attendance);
        return "/attendance/attendanceView";
    }


    @RequestMapping(value = "getAttendance")
    public String getAttendance(Model model) {
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> attendance = attenService.getAttendanceList(loginSession.getCode());
        model.addAttribute("attendance", attendance);
        System.out.println(attendance.size());
        return "/attendance/attendanceView";
    }

    @RequestMapping("toMain")
    public String toMain(Model model){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        if(loginSession==null){
            return "redirect:/";
        }
        EmployeeDTO empInfo = employeeService.getEmpInfo(loginSession.getCode());
        List<AtdChangeReqDTO> reqList = attenService.getAtdReqListToMain(loginSession.getCode());
        model.addAttribute("empInfo",empInfo);
        System.out.println(reqList);
        model.addAttribute("reqList",reqList);
        return "/attendance/attendanceMain";
    }

    @RequestMapping("/toAtdReq")
    public String toAtdReq(Model model){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        if(loginSession==null){
            return "redirect:/";
        }
        return "/attendance/attendanceChangeReq";
    }

    @RequestMapping("count")
    @ResponseBody
    public String count(){
        JSONArray json = new JSONArray();
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        String countLate = attenService.countStatusLate(loginSession.getCode());
        String countIn = attenService.countStatusWork(loginSession.getCode());
        json.put(countLate);
        json.put(countIn);
        if(!countIn.equals("0")){
            int hour = attenService.countWorkHour(loginSession.getCode());
            int min = attenService.countWorkMin(loginSession.getCode());
            System.out.println(hour);
            System.out.println(min);
            if(min >=60) {
                System.out.println(min/60);
                System.out.println(min%60);
                hour+=min/60;
                min=min%60;
                System.out.println(hour);
                System.out.println(min);
            }
            json.put(hour);
            json.put(min);
        }
        return json.toString();
    }

    @RequestMapping("getListToNex")
    public NexacroResult getListToNex(){
        List<AtdChangeReqDTO> list = attenService.getReqListToNex();
        List<HashMap> hmlist = new ArrayList<>();
        for(int i=0;i<list.size();i++){
            HashMap<String,Object> hm = new HashMap();
            hm.put("seq",list.get(i).getSeq());
            hm.put("start_time",list.get(i).getStart_time());
            hm.put("end_time",list.get(i).getEnd_time());
            if(list.get(i).getContents()!=null) {
                hm.put("contents", Configurator.getReXSSFilter(list.get(i).getContents()));
            }else{
                hm.put("contents","");
            }
            hm.put("status",list.get(i).getStatus());
            hm.put("atd_seq",list.get(i).getAtd_seq());
            hm.put("today",list.get(i).getToday());
            hm.put("atd_status",list.get(i).getAtd_status());
            hm.put("emp_code",list.get(i).getEmp_code());
            hm.put("name",list.get(i).getName());
            if(list.get(i).getComments()!=null) {
                hm.put("comments", Configurator.getReXSSFilter(list.get(i).getComments()));
            }else{
                hm.put("comments","");
            }
            hm.put("overtime",list.get(i).getOvertime());
            hmlist.add(hm);
        }
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",hmlist);
        return nr;
    }

    @RequestMapping("saveAtdReq")
    public NexacroResult saveAtdReq(@ParamDataSet(name="in_ds") AtdChangeReqDTO dto){
        dto.setComments(Configurator.XssReplace(dto.getComments()));
        int updateResult = attenService.saveAtdReq(dto);
        dto.setToday(dto.getToday().substring(0,8).replaceAll("-",""));
        dto.setStart_time(dto.getStart_time().replaceAll(":",""));
        dto.setEnd_time(dto.getEnd_time().replaceAll(":",""));
        int start_time=Integer.parseInt(dto.getStart_time().substring(0,2));
        int end_time=Integer.parseInt(dto.getEnd_time().substring(0,2));
        if((end_time-start_time)-1>8){
            dto.setOvertime((end_time-start_time)-9);
        }
        if(updateResult>0) {
            if (dto.getStatus().contentEquals("승인")) {
                int modAtdTime=attenService.modAtdTime(dto);
            }
        }

        return new NexacroResult();
    }


    @Scheduled(cron="0 0 0 * * MON-SAT") //평일 00시 00분 업데이트
    public void addAttendance() throws InterruptedException{
        log.info("출근 자동 업데이트");
        List<Integer> getAllEmpCode=employeeService.getAllEmpCode();
        for(int i=0;i<getAllEmpCode.size();i++) {
            int toDayUpdateAtd = attenService.toDayUpdateAtd(getAllEmpCode.get(i));
        }
    }

    @Scheduled(cron="0 0/59 23 * * MON-SAT") //평일 11시 50분 업데이트
    public void updateAttendanceStatus() throws InterruptedException{
        log.info("누락자 자동 업데이트");
        List<EmployeeDTO> getAllEmpCode=employeeService.getAllMWEmpCode();
        for(int i=0;i<getAllEmpCode.size();i++) {
            int toDayUpdateAtd = attenService.updateMWEmpAtd(getAllEmpCode.get(i).getAtd_seq());
        }
    }


}
