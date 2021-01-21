package kh.cocoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String toContactList(Model model) {
    	//임시! 사원번호 세션값===========================================
    	EmployeeDTO loginDTO = EmployeeDTO.builder().code(1000).dept_code(1).team_code(11).deptname("개발부").teamname("개발1팀").build();
    	//==========================================================
    	List<EmployeeDTO> memberList = eservice.getAllEmployee();
    	int a = memberList.get(0).getDept_code();
//    	List<EmployeeDTO> dept_list = eservice.getDeptMember(1);
//    	List<EmployeeDTO> team_list = eservice.getTeamMember(11);
    	model.addAttribute("memberList", memberList);
    	model.addAttribute("loginDTO",loginDTO);
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
