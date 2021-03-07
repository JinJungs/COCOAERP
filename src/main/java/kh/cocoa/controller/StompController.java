package kh.cocoa.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.dto.MessengerPartyDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;
import kh.cocoa.service.MessengerPartyService;

@Controller
public class StompController {
	@Autowired
	private SimpMessageSendingOperations messagingTemplate;
	
	@Autowired
	private MessageService msgservice;
	
	@Autowired
	private FilesService fservice;
	
	@Autowired
	private EmployeeService eservice;
	
	@Autowired
	private MessengerPartyService mpservice;

	@Autowired
	private HttpSession session;
	
	@MessageMapping("/getChat/text/{seq}")
	//@SendTo("/topic/message")
	public void getChatText(MessageDTO message, String savedname) throws Exception {
		//01. 스톰프 메세지 전송
		messagingTemplate.convertAndSend("/topic/" + message.getM_seq(), message);
		//02. 스톰프 메세지 연락처로 전송
		messagingTemplate.convertAndSend("/contact/"+message.getM_seq(), message);
	}
	

	//파일관련 메세지 저장
	@MessageMapping("/getChat/fileMessage/{seq}")
	public void getChatFile(MessageDTO message) throws Exception {
		System.out.println("스톰프 파일전송 메제시 컨트롤러 도착!");

		//01. 미리 받은 시퀀스로 FILE 혹은 IMAGE 타입의 메세지 저장
		int result = msgservice.insertMessageGotSeq(message);

		//02. 스톰프 메세지 전송 : Message, FilesDTO(originName, savedname)
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);
		//03. 스톰프 메세지 연락처로 전송 : Message, FilesDTO(originName, savedname)
		messagingTemplate.convertAndSend("/contact/"+message.getM_seq(), message);
	}
	
	@MessageMapping("/getChat/announce/{seq}")
	public void getChatAnnounce(MessageDTO message) throws Exception {
		System.out.println("스톰프 공지 메제시 컨트롤러 도착!");
		System.out.println("스톰프컨트롤러 MessageDTO : "+message);
		//담아온 내용과 조합해 안내문구로 쏠 문장
		String announce;
		
		//메세지 저장시 안내 문구 제외 들어갈 내용만 넣기 : 예) '000님이 들어가셨습니다' 에서 000만 저장
		msgservice.insertMessage(message);
		
		String typeAn = message.getType().substring(message.getType().lastIndexOf("_")+1);
		System.out.println("typeAn : "+typeAn);
		
		if(typeAn.contentEquals("MODIF")) {
			announce = message.getEmpname()+"님이 "+message.getContents()+" (으)로 채팅방 이름을 바꿨습니다.";
			// 연락처리스트에서 사용하기 위해 변경된 채팅방이름을 roomname변수에 저장
			message.setRoomname(message.getContents());
		}else if(typeAn.contentEquals("EXIT")) {
			//나가기 처리 여기서
	        MessengerPartyDTO mparty = new MessengerPartyDTO();
	    	mparty.setM_seq(message.getM_seq());
	    	mparty.setEmp_code(message.getEmp_code());
	    	int result = mpservice.exitMutiRoom(mparty);
	    	if(result>0) {
	    		announce = message.getEmpname()+" 님이 퇴장하였습니다.";
	    	}else {
	    		announce = "공지사항을 불러오는데 오류가 발생했습니다.";
	    	}
		}else if(typeAn.contentEquals("ADD")) {
			//content에 스트링 형으로 받아온 json 파싱해주기
			System.out.println("참가자 추가 공지 StompController 도착 ! ");
	    	//[code1,code2...]의 형태로 도착한 partyListEdited를 자르고 편집해 
			//_이름1,이름2,이름3 형식으로 바꿔준다.
			String partyListEdited = message.getContents().substring(1, message.getContents().length()-1);
	    	String[] partyListArr = partyListEdited.split(",");
	    	String addedNames = "";
	    	for(String i : partyListArr) {
	    		System.out.println("partyListArr[i] : "+i);
	    		int addedCode = Integer.parseInt(i);
	    		if(addedNames.isEmpty()) {
	    			addedNames += eservice.getEmpNameByCode(addedCode);
	    		}else {
	    			addedNames += " ,";
	    			addedNames += eservice.getEmpNameByCode(addedCode);
	    		}
	    	}
	    	//포문 돌리면서 참가자들 이름 받기 해야됨
			announce = message.getEmpname() + "님이 "+ addedNames + " 님을 채팅방에 초대하였습니다.";
		}else {
			//공지 메세지 타입이 등록되지 않았습니다.
			announce = "공지사항을 불러오는데 오류가 발생했습니다.";
		}
		message.setContents(announce);
		
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);
		messagingTemplate.convertAndSend("/contact/"+message.getM_seq(), message);
	}

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "error";
    }
}
