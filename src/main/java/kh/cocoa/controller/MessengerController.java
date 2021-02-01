package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.MessengerViewDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	private EmployeeService eservice;
	
	@Autowired
    private MessengerService mservice;

    @Autowired
    private HttpSession session;
	
    @RequestMapping("/")
    public String toIndex() {
        return "/messenger/messengerIndex";
    }

    @RequestMapping("contactList")
    public String toContactList(Model model) {
    	//임시! 사원번호 세션값===========================================
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
    	//==========================================================
    	//재직중인 전체 멤버 리스트
    	List<EmployeeDTO> memberList = eservice.getAllEmployee();
    	//채팅방 불러오기
    	List<MessengerViewDTO> chatList = mservice.myMessengerList(loginDTO.getCode());
    	//임시로 보내는 개인 정보. 세션으로 대체될 예정
    	model.addAttribute("loginDTO",loginDTO);
    	model.addAttribute("memberList", memberList);
    	model.addAttribute("chatList", chatList);
        return "/messenger/contactList";
    }

    @RequestMapping("chat")
    public String toChat(int seq, Model model) {
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        System.out.println("로그인한 ID : " +code);
        // Messenger 테이블에서 내 아이디가 emp_code나 emp_code2에 있는지 검사 후
        //int emp_code = mservice.whatIsChatFriendID(code);
        // 상대방의 code를 이용해 정보를 employee에서 가져오기
        // EmployeeDTO partnerDTO = eservice.getEmployeeInfoChatFriend();
        model.addAttribute("loginDTO",loginDTO);
        model.addAttribute("seq",seq);
        return "/messenger/chat";
    }
    
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
