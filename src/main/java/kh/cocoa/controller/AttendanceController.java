package kh.cocoa.controller;

import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
    @Autowired
    AttendanceService attenService;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/toAttendanceView")
    public String toTA(Model model) {
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> attendance = attenService.getAttendanceList(loginSession.getCode());
        model.addAttribute("attendance", attendance);
        System.out.println(attendance.size());
        return "/attendance/attendanceView";
    }

    @RequestMapping(value = "/startWork")
    public String startWork(Model model, HttpServletRequest request) {
        // 1. 오늘 출근했는지 체크
        // 2. 외근 체크가 되었는지 아닌지
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        Timestamp chkWork = attenService.checkStart(loginSession.getCode());
        if(chkWork == null) {
            String chkBox = request.getParameter("outSide");
            if (chkBox == null) {
                int result = attenService.startWork(loginSession.getCode());
            }
            else {
                int result = attenService.outSideWork(loginSession.getCode());
            }
            model.addAttribute("result", "success");
        }
        else{
            model.addAttribute("result", "already");
        }
        return "redirect::/attendance/toAttendanceView";
    }

    @RequestMapping(value = "/endWork")
    public String endWork(Model model) {
        // 1. 오늘 출근했는지 체크
        // 2. 퇴근되어 있는지 체크
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        Timestamp chkWork = attenService.checkStart(loginSession.getCode());
        if(chkWork != null){
            Timestamp chkEnd = attenService.checkEnd(loginSession.getCode());
            if(chkEnd == null) {
                int result = attenService.offWork(loginSession.getCode());
                model.addAttribute("result", "offWork");
            }
            else{
                model.addAttribute("result", "alreadyOff");
            }
        }else {
            model.addAttribute("result", "workedYet");
        }
        return "redirect::/attendance/toAttendanceView";
    }

    @RequestMapping(value = "getAttendance")
    public String getAttendance(Model model) {
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> attendance = attenService.getAttendanceList(loginSession.getCode());
        model.addAttribute("attendance", attendance);
        System.out.println(attendance.size());
        return "/attendance/attendanceView";
    }
}
