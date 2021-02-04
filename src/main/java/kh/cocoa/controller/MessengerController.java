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
import org.springframework.web.bind.annotation.ResponseBody;

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
    	//사원번호 세션값===========================================
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
    	//==========================================================
    	//재직중인 전체 멤버 리스트
    	List<EmployeeDTO> memberList = eservice.getAllEmployee();
    	//채팅방 불러오기
    	List<MessengerViewDTO> chatList = mservice.myMessengerList(loginDTO.getCode());

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
        // 해당 채팅방에 있는 상대방 정보 불러오기 - 다중채팅시 오류나겠다...(지금은 한갠데 여러개 받아야해서)
        MessengerViewDTO partyDTO = mservice.getMessengerPartyEmpInfo(seq,code);
        model.addAttribute("loginDTO",loginDTO);
        model.addAttribute("seq",seq);
        model.addAttribute("partyDTO",partyDTO);
        return "/messenger/chat";
    }

    @RequestMapping("messengerSearch")
    public String messengerSearch(String contents,Model model){
        System.out.println("contents : "+ contents);
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByDeptTeamname(contents);

        //(4) 사람이 속한 채팅방찾기

        //(5) 메세지 찾기

        model.addAttribute("searchKeyword",contents);
        model.addAttribute("memberList",memberList);
        model.addAttribute("deptList",deptList);
        model.addAttribute("teamList",teamList);
        return "/messenger/messengerSearch";
    }

    @RequestMapping("messengerSearchAjax")
    @ResponseBody
    public String messengerSearchAjax(String contents){
        System.out.println("contents : "+ contents);
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByDeptTeamname(contents);


        return "1";
    }
    
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
