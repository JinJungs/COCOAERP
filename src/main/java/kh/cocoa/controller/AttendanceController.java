package kh.cocoa.controller;

import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import kh.cocoa.service.EmployeeService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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

    @RequestMapping(value = "/startWork")
    public String startWork(HttpServletRequest request, RedirectAttributes rttr) throws Exception{
        // 1. 오늘 출근했는지 체크
        // 2. 외근 체크가 되었는지 아닌지
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        Timestamp chkWork = attenService.checkStart(loginSession.getCode());
        String msg;
        if(chkWork == null) {
            String chkBox = request.getParameter("outSide");
            if (chkBox == null) {
                int result = attenService.startWork(loginSession.getCode());
            }
            else {
                int result = attenService.outSideWork(loginSession.getCode());
            }
            //model.addAttribute("result", "success");
            msg = "sucess";
            rttr.addAttribute("result", msg);
        }
        else{
            //model.addAttribute("result", "already");
            msg = "already";
            rttr.addAttribute("result", msg);

        }
        return "redirect:/attendance/toAttendanceView";
    }

    @RequestMapping(value = "/endWork")
    public String endWork(RedirectAttributes rttr) throws Exception{
        // 1. 오늘 출근했는지 체크
        // 2. 퇴근되어 있는지 체크
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        Timestamp chkWork = attenService.checkStart(loginSession.getCode());
        if(chkWork != null){
            Timestamp chkEnd = attenService.checkEnd(loginSession.getCode());
            if(chkEnd == null) {
                int result = attenService.offWork(loginSession.getCode());
                // model.addAttribute("result", "offWork");
                rttr.addAttribute("result", "offWork");
            }
            else{
                //model.addAttribute("result", "alreadyOff");
                rttr.addAttribute("result", "alreadyOff");
            }
        }else {
            // model.addAttribute("result", "workedYet");
            rttr.addAttribute("result", "workedYet");
        }
        return "redirect:/attendance/toAttendanceView";
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
        SimpleDateFormat frm = new SimpleDateFormat ( "HHMM");
        Date time = new Date();
        String getCurTime = frm.format(time);
        String isInWork = attenService.isInWork(1000);
        if(isInWork!=null){
            isInWork=isInWork.replaceAll(":","").substring(0,4);
        }
        if(isInWork==null){
            if(Integer.parseInt(getCurTime)>930){
                model.addAttribute("statusMsg","아직 출근하지 않았습니다.");
                model.addAttribute("isInWork","late");
            }else{
                model.addAttribute("statusMsg","아직 출근하지 않았습니다.");
                model.addAttribute("isInWork","atd");
            }
        }else{
            if(Integer.parseInt(isInWork)>930){
                model.addAttribute("isInWork","late");
            }else{
                model.addAttribute("isInWork","atd");
            }
            model.addAttribute("statusMsg","안녕하세요.");
        }
        EmployeeDTO empInfo = employeeService.getEmpInfo(1000);
        model.addAttribute("empInfo",empInfo);
        return "/attendance/attendanceMain";
    }

    @RequestMapping("/toAtdReq")
    public String toAtdReq(Model model){
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
}
