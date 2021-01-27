package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/membership")
public class EmployeeController {
    @Autowired
    private EmployeeService eservice;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/login")
    public String login(int code, String password){
        String result = eservice.login(code, password);
        if (!result.isEmpty()) {
            EmployeeDTO loginDTO = eservice.loginInfo(code);
            session.setAttribute("loginDTO", loginDTO);
            return "index";
        }
        else {
            return "/login/login";
        }
    }
}
