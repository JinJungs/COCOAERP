package kh.cocoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;

import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;

@Controller
public class StompController {
	@Autowired
	private SimpMessageSendingOperations messagingTemplate;
	
	@Autowired
	private MessageService msgservice;
	
	@Autowired
	private FilesService fservice;
	
	@MessageMapping("/getChat/text/{seq}")
	//@SendTo("/topic/message")
	public void getChatText(MessageDTO message, String savedname) throws Exception {
		//1.받아온 내용들로 MESSAGE 테이블에 인서트(??뇌피셜. 조사 필요)
		//2.전송
		System.out.println("getChat>>" + message);
		System.out.println("SEQ=" + message.getSeq());
		System.out.println("MSG=" + message.getContents());
		System.out.println("WRITE_DATE="+message.getWrite_date());
		System.out.println("EMP_CODE="+message.getEmp_code());
		System.out.println("MSG_SEQ(방seq)"+message.getM_seq());
		System.out.println("savedname : "+savedname);
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
			announce = message.getEmp_code()+"님이 "+message.getContents()+" 으로 채팅방 이름을 바꿨습니다.";
		}else if(typeAn.contentEquals("EXIT")) {
			announce = message.getEmp_code()+" 님이 퇴장하였습니다.";
			System.out.println("퇴장 : "+announce);
		}else if(typeAn.contentEquals("ADD")) {
			//content에 스트링 형으로 받아온 json 파싱해주기
			
			//포문 돌리면서 참가자들 이름 받기
			
			announce = "채팅참가 공지 메세지 구현 중";
		}else {
			announce = "공지 메세지 타입이 등록되지 않았습니다.";
		}
		message.setContents(announce);
		
		//message.setContents(message.getEmp_code()+"님이 "+message.getContents()+" 으로 채팅방 이름을 바꿨습니다.");
		//messagingTemplate.convertAndSend("/topic/announce/"+message.getM_seq(), message);
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);
	}
	
	
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "error";
    }
}
