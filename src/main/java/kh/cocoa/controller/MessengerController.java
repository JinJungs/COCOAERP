package kh.cocoa.controller;

import kh.cocoa.dto.*;
import kh.cocoa.service.*;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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
        System.out.println("로그인한 ID / 방 seq : " +code +" / "+seq);
        
        //MESSENGER 테이블 정보 불러오기
        MessengerDTO messenger = mservice.getMessengerInfo(seq);
        
        if(messenger.getType().contentEquals("S")) {
        	 // 해당 채팅방에 있는 상대방 정보 불러오기 - 다중채팅시 오류나겠다...(지금은 한갠데 여러개 받아야해서)
            MessengerViewDTO partyDTO = mservice.getMessengerPartyEmpInfo(seq,code);
            model.addAttribute("partyDTO",partyDTO);
        }else {
        	List<MessengerViewDTO> listPartyDTO = mservice.getListMessengerPartyEmpInfo(seq);
        	model.addAttribute("listPartyDTO",listPartyDTO);
        }
     
        model.addAttribute("loginDTO",loginDTO);
        //messenger : 해당 시퀀스의 메신저 테이블 정보
        model.addAttribute("messenger", messenger);
        model.addAttribute("seq", seq);
        return "/messenger/chat";
    }
    
    //연락처에서 1:1채팅창 열기(혹은 생성)
    @RequestMapping("openCreateSingleChat")
    public String chatFromContact(int partyEmpCode, Model model) {
    	System.out.println("openCreateSingleChat 도착 !");
    	System.out.println("partyEmpCode : "+partyEmpCode);
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
    		dto.setName("");
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
    	return "redirect:/messenger/chat?seq="+seq;
    }

    //채팅방 생성
    //추가 인원이 1명인 경우 1:1 채팅방 생성 컨트롤러로 전달
    @RequestMapping("addChatRoom")
    public String addChatRoom(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	System.out.println("addChatRoom 도착");
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        int seq;
        //참가자 담을 리스트 partyList / form의 emp_code 네임으로 받아온 code 리스트
    	List<MessengerPartyDTO> partyList = new ArrayList<>();
    	String[] empCodeList = request.getParameterValues("emp_code");
    	
    	//form 의 empCodeList를 받은 String배열을 int형으로 바꿔 MessengerPartyDTO형 리스트에 넣는다.
    	for(String i : empCodeList) {
    		System.out.println(i);
    		int emp_code = Integer.parseInt(i);
    		MessengerPartyDTO dto = new MessengerPartyDTO().builder().emp_code(emp_code).build();
    		partyList.add(dto);
    	}

    	if(partyList.size()==1) {
    		System.out.println("1명 있을 때");
    		//추가 인원이 1인이면 개인 채팅방 열기(혹은 생성)
    		int partyEmpCode = partyList.get(0).getEmp_code();
    		System.out.println("partyEmpCode : "+partyEmpCode);
    		//redirectAttributes.addFlashAttribute("partyEmpCode", partyEmpCode);
    		//리스트 말고 하나의 값을 보내려면 redirectAttributes가 안되는 것 같다.. why?
    		return "redirect:/messenger/openCreateSingleChat?partyEmpCode="+partyEmpCode;
    	}else if(partyList.size()>1) {
    		System.out.println("2명 이상 있을 때");
    		//messenger 타입지정 + 생성
    		MessengerDTO messenger = new MessengerDTO();
    		messenger.setType("M");
    		messenger.setName(loginDTO.getName()+" 님 외 "+partyList.size()+"명");
    		//메신저 테이블 인서트 후 시퀀스값 받아오기
    		int insertRoomResult = mservice.insertMessengerRoomGetSeq(messenger);
    		System.out.println("insertRoomResult : "+insertRoomResult);
    		//Messenger 테이블 seq = Messenger_Party의 m_seq
    		seq = messenger.getSeq();
			
    		//멤버추가하기
    		//참가자 리스트에 로그인한 아이디 코드도 넣기
    		MessengerPartyDTO logined = new MessengerPartyDTO().builder().emp_code(code).build();
    		partyList.add(logined);
    		for(MessengerPartyDTO i : partyList) {
    			i.setM_seq(seq);
    		}
    		int insertMemResult = mpservice.setMessengerMember(partyList);
    		System.out.println("insertMemResult : "+insertMemResult);
    		
    		redirectAttributes.addFlashAttribute("loginDTO",loginDTO);
    		redirectAttributes.addFlashAttribute("partyList",partyList);
    		//redirectAttributes.addFlashAttribute("seq",seq);
    		return "redirect:/messenger/chat?seq="+seq;
    	}else {
    		//에러
    		return "error";
    	}
    }
    /*
    @RequestMapping("addMember")
    public String addMember(HttpServletRequest request, MessengerDTO messenger) {
    	
    	//참가자 담을 리스트 partyList / form의 emp_code 네임으로 받아온 code 리스트
    	List<MessengerPartyDTO> partyList = new ArrayList<>();
    	String[] empCodeList = request.getParameterValues("emp_code");
    	
    	//form 의 empCodeList를 받은 String배열을 int형으로 바꿔 MessengerPartyDTO형 리스트에 넣는다.
    	for(String i : empCodeList) {
    		System.out.println(i);
    		int emp_code = Integer.parseInt(i);
    		MessengerPartyDTO dto = new MessengerPartyDTO().builder().emp_code(emp_code).m_seq(messenger.getSeq()).build();
    		partyList.add(dto);
    	}
    	if(messenger.getType().contentEquals("S")&&partyList.size()!=0) {
    		//매퍼 만들기 : messenger 타입 변경 
    	}
		int insertMemResult = mpservice.setMessengerMember(partyList);
    	//리턴 무엇으로??
    	return "";
    }
    */
    @RequestMapping("addMemberToChatRoom")
    public String addMemberToChatRoom(int seq, HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	System.out.println("addMemberToChatRoom 도착, 방 시퀀스 : "+seq);
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        //참가자 담을 리스트 partyList / form의 emp_code 네임으로 받아온 code 리스트
    	List<MessengerPartyDTO> partyList = new ArrayList<>();
    	String[] empCodeList = request.getParameterValues("emp_code");

    	//form 의 empCodeList를 받은 String배열을 int형으로 바꿔 MessengerPartyDTO형 리스트에 넣는다.
    	for(String i : empCodeList) {
    		int emp_code = Integer.parseInt(i);
    		MessengerPartyDTO dto = new MessengerPartyDTO().builder().m_seq(seq).emp_code(emp_code).build();
    		partyList.add(dto);
    	}

    	//메신저 타입 보기
    	MessengerDTO messenger = mservice.getMessengerInfo(seq);
    	System.out.println("추가할 메신저의 정보 : "+messenger);

    	if(messenger.getType().contentEquals("S")) {
    		System.out.println("1:1에서 추가할 때");
    		//채팅방 설정 : 타입 M으로, 채팅방 이름 인원수로
    		int resultType = mservice.updateTypeToM(seq);
    		//String name = loginDTO.getName() + "님 외 " + (partyList.size()+1) + "명";
    		String name = loginDTO.getName() + "님의 단체 채팅방";
    		int resultName = mservice.updateName(seq, name);
    		System.out.println(resultType +" : "+ resultName);
    	}
    	int insertMemResult = mpservice.setMessengerMember(partyList);
    	System.out.println("인원 추가 결과 : "+insertMemResult);
    	//!!return을 어디로 해줄지...
    	return "";
    }

    @RequestMapping("messengerSearch")
    public String messengerSearch(String contents,Model model){
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int code = loginDTO.getCode();
        // 로그인한 사람의 이름은 제외해야함
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(code, contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(code, contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(code, contents);
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
        // 로그인한 사람의 이름은 제외해야함
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(code, contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(code, contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(code, contents);
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
    public String openMemberList(Model model, int seq) {
    	System.out.println("openMemberList 도착 ㅣ seq : "+seq);
    	if(seq > 0) {//둘다 같은 jsp에 넣고 jsp의 form action부분만 바꿔조도 됨. 일단은 분리
    	    // 방의 seq로 참여자의 code의 list를 보내줌
            //List<MessengerViewDTO> codeList = mservice.getListMessengerPartyEmpInfo(seq);
    		model.addAttribute("seq",seq);
    		//model.addAttribute("codeList",codeList);
    		return "/messenger/addMemberListToChat";
    	}
    	return "/messenger/addMemberList";
    }

    //채팅방 설정 변경창 열기
    @RequestMapping("openModifChat")
    public String openModifChat(int seq, Model model) {
    	System.out.println("openModifChat컨트롤러 도탁 ! : " + seq);
    	//채팅방에 참가 중인 사람들 코드 전달해야함
    	//model.addAttribute("listPartyDTO",listPartyDTO);
    	model.addAttribute("seq",seq);

    	return "/mssenger/modifChat";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        e.printStackTrace();
        return "index";
    }

}
