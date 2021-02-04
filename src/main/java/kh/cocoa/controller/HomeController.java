package kh.cocoa.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmployeeService;

@Controller
public class HomeController {

	@Autowired
	private EmployeeService eservice;
	
	@Autowired
	private HttpSession session;

    @RequestMapping("/test")
    public String test() {
        return "document/c_writeDocument";
    }

    @RequestMapping("/test2")
    public String test2() {
        return "document/c_templateList";
    }

    @RequestMapping("/")
    public String login() {
        return "/membership/login";
    }
    /*-----------지영 - 버그리포트--------*/
    @GetMapping("/bug")
    public String bug(Model model) {
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		
		//보내는 사람 이메일 입력
		EmployeeDTO sender_email = eservice.getSenderEmail(writer_code);
		model.addAttribute("sender_email",sender_email);
        return "/bugReport/bugReport";
    }
}