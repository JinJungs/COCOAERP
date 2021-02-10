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
	
/*	@MessageMapping("/addMember/chatAnnounce/{seq}")
	//@SendTo("/topic/message")
	public void addMember(String savedname) throws Exception {
		//1.멤버 추가시 멤버 이름(부서/직급), 메신저 방을 스톰프로 전달
		//2.채팅창에 뿌려준다.
		
		messagingTemplate.convertAndSend("/topic/" + message.getM_seq(), message);
//		messagingTemplate.convertAndSendToUser(message.getId(), "/topic/" + message.getRoomid(), message.getMsg());
	}*/
	
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "error";
    }
}
