package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmployeeService;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	EmployeeService eservice;
	
    @RequestMapping("/")
    public String toIndex() {
        return "/messenger/messengerIndex";
    }

    @RequestMapping("contactList")
    public String toContactList() {
    	List<EmployeeDTO> list = eservice.getAllEmployee();
    	List<EmployeeDTO> dept_list = eservice.getDeptMember(1);
    	List<EmployeeDTO> team_list = eservice.getTeamMember(11);
    	System.out.println(list.get(1));
    	System.out.println("부서멤버"+dept_list);
    	System.out.println("팀멤버"+team_list);
        return "/messenger/contactList";
    }

    @RequestMapping("chat")
    public String toChat() {
        return "/messenger/chat";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
