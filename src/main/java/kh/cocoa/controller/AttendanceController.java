package kh.cocoa.controller;

import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import kh.cocoa.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    public String count(){
        System.out.println("도착!!!");
        return "/attendance/attendanceView";
    }
}
