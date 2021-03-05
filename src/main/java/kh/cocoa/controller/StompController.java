package kh.cocoa.controller;

import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpSession;

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
	private HttpSession session;
	
	@MessageMapping("/getChat/text/{seq}")
	//@SendTo("/topic/message")
	public void getChatText(MessageDTO message, String savedname) throws Exception {
		//1.받아온 내용들로 MESSAGE 테이블에 인서트(??뇌피셜. 조사 필요)
		//2.전송
		System.out.println("MSG=" + message.getContents());
		System.out.println("WRITE_DATE="+message.getWrite_date());
		System.out.println("savedname : "+savedname);
		System.out.println("empname : "+message.getEmpname());
		System.out.println("getType : "+message.getType());
		messagingTemplate.convertAndSend("/topic/" + message.getM_seq(), message);
//		messagingTemplate.convertAndSendToUser(message.getId(), "/topic/" + message.getRoomid(), message.getMsg());
	}
	

	//파일관련 메세지 저장
	@MessageMapping("/getChat/fileMessage/{seq}")
	public void getChatFile(MessageDTO message) throws Exception {
		System.out.println("스톰프 파일전송 메제시 컨트롤러 도착!");
		System.out.println("스톰프컨트롤러 MessageDTO : "+message);

		//01. 미리 받은 시퀀스로 FILE 혹은 IMAGE 타입의 메세지 저장
		int result = msgservice.insertMessageGotSeq(message);
		System.out.println("insertMessageGotSeq result : "+result);

		//02.스톰프 메세지 전송 : Message, FilesDTO(originName, savedname)
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);
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
		}else if(typeAn.contentEquals("EXIT")) {
			announce = message.getEmpname()+" 님이 퇴장하였습니다.";
			System.out.println("퇴장 : "+announce);
		}else if(typeAn.contentEquals("ADD")) {
			//content에 스트링 형으로 받아온 json 파싱해주기
			System.out.println("참가자 추가 공지 StompController 도착 ! ");
			System.out.println("추가한 사람 : "+message.getEmp_code());
			System.out.println(message.getContents());
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
			announce = message.getEmpname() + "님이 "+ addedNames + " 님을 채팅방에 초대하셨습니다.";
		}else {
			//공지 메세지 타입이 등록되지 않았습니다.
			announce = "공지사항을 불러오는데 오류가 발생했습니다.";
		}
		message.setContents(announce);
		
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);
	}

	@MessageMapping("/getChat/contactListText/{code}")
	public void contactListText(MessageDTO message) throws Exception{
		System.out.println("연락처 리스트 소켓에서 msg : " +message.getContents());
		messagingTemplate.convertAndSend("/contact/"+message.getM_seq(), message);
	}
	
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "error";
    }
}
