package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.MessageViewDTO;
import kh.cocoa.dto.MessengerViewDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.MessageService;
import kh.cocoa.service.MessengerService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	private EmployeeService eservice;
	
	@Autowired
    private MessengerService mservice;

	@Autowired
    private MessageService msgservice;

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
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();

        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(contents);
        //(4) 사람이 속한 채팅방찾기

        //(5) 메세지 찾기
        List<MessageViewDTO> messageList = msgservice.searchMsgByContents(code, contents);

        model.addAttribute("searchKeyword",contents);
        model.addAttribute("memberList",memberList);
        model.addAttribute("deptList",deptList);
        model.addAttribute("teamList",teamList);
        model.addAttribute("messageList",messageList);
        return "/messenger/messengerSearch";
    }

    @RequestMapping("messengerSearchAjax")
    @ResponseBody
    public String messengerSearchAjax(String contents){
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        JSONArray jArrayMember = new JSONArray();
        JSONArray jArrayDept = new JSONArray();
        JSONArray jArrayTeam = new JSONArray();
        JSONArray jArrayMessage = new JSONArray();
        JSONArray jArrayAll = new JSONArray();
        HashMap<String,Object> param = null;
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(contents);
        //(4) 메세지 찾기
        List<MessageViewDTO> messageList = msgservice.searchMsgByContents(code, contents);
        
        // 나중에 이중for문으로 정리하기
        // jArrayMember에 memberList 넣기
        for (int i = 0; i < memberList.size(); i++) {
            param = new HashMap<>();
            param.put("code",memberList.get(i).getCode());
            param.put("name",memberList.get(i).getName());
            param.put("email",memberList.get(i).getEmail());
            param.put("deptname",memberList.get(i).getDeptname());
            param.put("teamname",memberList.get(i).getTeamname());
            param.put("posname",memberList.get(i).getPosname());
            jArrayMember.put(param);
        }
        // jArrayDept에 deptList 넣기
        for (int i = 0; i < deptList.size(); i++) {
            param = new HashMap<>();
            param.put("code",deptList.get(i).getCode());
            param.put("name",deptList.get(i).getName());
            param.put("email",deptList.get(i).getEmail());
            param.put("deptname",deptList.get(i).getDeptname());
            param.put("teamname",deptList.get(i).getTeamname());
            param.put("posname",deptList.get(i).getPosname());
            jArrayDept.put(param);
        }
        // jArrayTeam에 teamList 넣기
        for (int i = 0; i < teamList.size(); i++) {
            param = new HashMap<>();
            param.put("code",teamList.get(i).getCode());
            param.put("name",teamList.get(i).getName());
            param.put("email",teamList.get(i).getEmail());
            param.put("deptname",teamList.get(i).getDeptname());
            param.put("teamname",teamList.get(i).getTeamname());
            param.put("posname",teamList.get(i).getPosname());
            jArrayTeam.put(param);
        }
        // jArrayMessage에 messageList 넣기
        for (int i = 0; i < messageList.size(); i++) {
            param = new HashMap<>();
            param.put("seq",messageList.get(i).getSeq());
            param.put("contents",messageList.get(i).getContents());
            param.put("write_date",messageList.get(i).getWrite_date());
            param.put("emp_code",messageList.get(i).getEmp_code());
            param.put("m_seq",messageList.get(i).getM_seq());
            param.put("type",messageList.get(i).getType());
            param.put("m_type",messageList.get(i).getM_type());
            param.put("name",messageList.get(i).getName());
            param.put("party_seq",messageList.get(i).getParty_seq());
            param.put("party_emp_code",messageList.get(i).getEmp_code());
            param.put("empname",messageList.get(i).getEmpname());
            param.put("party_empname",messageList.get(i).getParty_empname());
            jArrayMessage.put(param);
        }
        jArrayAll.put(jArrayMember);
        jArrayAll.put(jArrayDept);
        jArrayAll.put(jArrayTeam);
        jArrayAll.put(jArrayMessage);
        return jArrayAll.toString();
    }
    
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
