package kh.cocoa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesMsgDTO;
import kh.cocoa.dto.MessageViewDTO;
import kh.cocoa.dto.MessengerDTO;
import kh.cocoa.dto.MessengerPartyDTO;
import kh.cocoa.dto.MessengerViewDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;
import kh.cocoa.service.MessengerPartyService;
import kh.cocoa.service.MessengerService;


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

    @Autowired
    private FilesService fservice;
    
    @Autowired
    private MessengerPartyService mpservice;

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

    //채팅방 열기
    @RequestMapping("chat")
    public String toChat(int seq, Model model) {
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        System.out.println("로그인한 ID : " +code);
        // 해당 채팅방에 있는 상대방 정보 불러오기 - 다중채팅시 오류나겠다...(지금은 한갠데 여러개 받아야해서)
        MessengerViewDTO partyDTO = mservice.getMessengerPartyEmpInfo(seq,code);
        // 참가자 여러명일 경우. 완성시 위의 것과 합치기? + chat.jsp 수정 필요
        //List<MessengerViewDTO> listPartyDTO = mservice.getListMessengerPartyEmpInfo(seq, code);
        
        model.addAttribute("loginDTO",loginDTO);
        model.addAttribute("seq",seq);
        model.addAttribute("partyDTO",partyDTO);
        return "/messenger/chat";
    }
    
    //연락처에서 1:1채팅창 열기(혹은 생성)
    @RequestMapping("openCreateSingleChat")
    public String chatFromContact(int partyEmpCode, Model model) {
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
    	int code = loginDTO.getCode();
    	System.out.println("code / partyEmpCode : "+code +" : "+partyEmpCode);
    	int seq;
    	//개인 채팅방 존재 유무 파악
    	int checkSingleRoom = mservice.isSingleMessengerRoomExist(code, partyEmpCode);
    	System.out.println("checkSingleRoom : "+checkSingleRoom);
    	if(checkSingleRoom == 0) {
    		//없을 경우 채팅방 생성 (S타입)
    		MessengerDTO dto = new MessengerDTO();
    		dto.setType("S");
    		dto.setName("test");
    		int insertRoomResult = mservice.insertMessengerRoomGetSeq(dto);
    		System.out.println("insertRoomResult : "+insertRoomResult);
    		//Messenger 테이블 seq = Messenger_Party의 m_seq
    		seq = dto.getSeq();
			
    		//멤버추가하기
    		List<MessengerPartyDTO> memberList = new ArrayList<>();
    		MessengerPartyDTO mine = new MessengerPartyDTO().builder().m_seq(seq).emp_code(code).build();
    		MessengerPartyDTO party = new MessengerPartyDTO().builder().m_seq(seq).emp_code(partyEmpCode).build();
    		memberList.add(mine);
    		memberList.add(party);
    		int insertMemResult = mpservice.setMessengerMember(memberList);
    		System.out.println("insertMemResult : "+insertMemResult);
    	}else {
    		seq = mservice.getSingleMessengerRoom(code, partyEmpCode);
    	}
    	System.out.println("채팅방 seq : "+seq);
    	model.addAttribute("loginDTO",loginDTO);
        //model.addAttribute("seq",seq);
        //model.addAttribute("partyDTO",partyDTO);
    	return "redirect:/messenger/chat?seq="+seq;
    }

    //채팅방 생성
    @RequestMapping("addChatRoom")
    @ResponseBody
    public String addChatRoom( Model model, @RequestParam(value = "empCodeList[]") List<String> empCodeList) {
//    	임시로 삭제 : MessengerDTO messenger, List<MessengerPartyDTO> partyList,
    	
    	System.out.println("addChatRoom 도착");
    	System.out.println(empCodeList);
    	return "";
    	/*
    	//참가자 목록 : 3인 이상 = M타입 채팅방 생성 // 2인 이상 = chatFromContact
    	//받아올 값 : Messenger name / 참가자 코드 리스트
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        int seq;
        
    	if(partyList.size()==1) {
    		//추가 인원이 1인이면 개인 채팅방 열기(혹은 생성)
    		int partyEmpCode = partyList.get(0).getEmp_code();
    		model.addAttribute("partyEmpCode", partyEmpCode);
    		return "/messenger/openCreateSingleChat";
    	}else if(partyList.size()>1) {
    		//받아올 값 : Messenger name / 참가자 코드 리스트
    		messenger.setType("M");
    		int insertRoomResult = mservice.insertMessengerRoomGetSeq(messenger);
    		System.out.println("insertRoomResult : "+insertRoomResult);
    		//Messenger 테이블 seq = Messenger_Party의 m_seq
    		seq = messenger.getSeq();
			
    		//멤버추가하기
    		int insertMemResult = mpservice.setMessengerMember(partyList);
    		System.out.println("insertMemResult : "+insertMemResult);
    		//!! 만드는 사람의 정보도 넣어야함
    		
    		model.addAttribute("loginDTO",loginDTO);
    		model.addAttribute("partyList",partyList);
    		model.addAttribute("seq",seq);
    		return "/messenger/chat";
    	}else {
    		//리턴 에이잭스? 에러?
    		return null;
    	}
    	*/
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
    
    //파일 모아보기 팝업
    @RequestMapping("showFiles")
    public String showFiles(Model model, int m_seq) throws Exception {
    	//01.전체 이미지/파일 불러오기
    	List<FilesMsgDTO> fileList = fservice.showFileMsg(m_seq);
    	System.out.println(fileList);
    	List<FilesMsgDTO> list = fservice.encodedShowFileMsg(fileList);
    	model.addAttribute("list", list);
    	return "/messenger/showFiles";
    }
    
    //멤버 추가를 위한 리스트 열기
    @RequestMapping("openMemberList")
    public String openMemberList(Model model) {
    	List<EmployeeDTO> memberList = eservice.getAllEmployee();
    	model.addAttribute("memberList", memberList);
    	return "/messenger/addMemberList";
    }
    
    

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        e.printStackTrace();
        return "index";
    }

}
