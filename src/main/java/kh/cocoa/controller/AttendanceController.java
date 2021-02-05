package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
    @Autowired
    AttendanceService attenService;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/toAttendanceView")
    public String toTA() { return "/attendance/attendanceView"; }

    @RequestMapping(value = "/startWork")
    public String startWork() {
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        System.out.println(loginSession.getCode());
        int result = attenService.startWork(loginSession.getCode());
        return "/attendance/attendanceView";
    }
}
