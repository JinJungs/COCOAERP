package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.MessengerDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	EmployeeService eservice;
	
	@Autowired
	MessengerService mservice;
	
    @RequestMapping("/")
    public String toIndex() {
        return "/messenger/messengerIndex";
    }

    @RequestMapping("contactList")
    public String toContactList(Model model) {
    	//임시! 사원번호 세션값===========================================
    	EmployeeDTO loginDTO = EmployeeDTO.builder().code(1000).name("권용국").dept_code(1).team_code(11).deptname("개발부").teamname("개발1팀").build();
    	//==========================================================
    	//재직중인 전체 멤버 리스트
    	List<EmployeeDTO> memberList = eservice.getAllEmployee();
    	//채팅방 불러오기
    	List<MessengerDTO> chatList = mservice.myMessengerList(loginDTO.getCode());
    	//임시로 보내는 개인 정보. 세션으로 대체될 예정
    	model.addAttribute("loginDTO",loginDTO);
    	model.addAttribute("memberList", memberList);
    	model.addAttribute("chatList", chatList);
        return "/messenger/contactList";
    }

    @RequestMapping("chat")
    public String toChat(int seq, Model model) {
        model.addAttribute("seq",seq);
        return "/messenger/chat";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
