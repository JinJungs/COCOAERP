package kh.cocoa.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesMsgDTO;
import kh.cocoa.dto.MessengerViewDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessengerService;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	private EmployeeService eservice;
	
	@Autowired
    private MessengerService mservice;

    @Autowired
    private HttpSession session;
    
    @Autowired
    private FilesService fservice;
	
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
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(contents);

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
        JSONArray jArrayMember = new JSONArray();
        JSONArray jArrayDept = new JSONArray();
        JSONArray jArrayTeam = new JSONArray();
        JSONArray jArrayAll = new JSONArray();
        HashMap<String,Object> param = null;
        //(1) 멤버이름으로 찾기
        List<EmployeeDTO> memberList = eservice.searchEmployeeByName(contents);
        //(2) 부서이름으로 찾기
        List<EmployeeDTO> deptList = eservice.searchEmployeeByDeptname(contents);
        //(3) 팀이름으로 찾기
        List<EmployeeDTO> teamList = eservice.searchEmployeeByTeamname(contents);

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
        jArrayAll.put(jArrayMember);
        jArrayAll.put(jArrayDept);
        jArrayAll.put(jArrayTeam);
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
    	for(FilesMsgDTO i : list) {
    		System.out.println(i.getOrinameEncoded());
    	}
    	return "/messenger/showFiles";
    }
    
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

}
