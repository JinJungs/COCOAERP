package kh.cocoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.MessageDTO;

@Controller
public class StompController {
	@Autowired
	private SimpMessageSendingOperations messagingTemplate;
	
	@MessageMapping("/getChat/text/{seq}")
	//@SendTo("/topic/message")
	public void getChatText(MessageDTO message) throws Exception {
		//1.받아온 내용들로 MESSAGE 테이블에 인서트(??뇌피셜. 조사 필요)
		//2.전송
		System.out.println("getChat>>" + message);
		System.out.println("SEQ=" + message.getSeq());
		System.out.println("MSG=" + message.getContents());
		System.out.println("WRITE_DATE="+message.getWrite_date());
		System.out.println("EMP_CODE="+message.getEmp_code());
		System.out.println("MSG_SEQ(방seq)"+message.getM_seq());
		
		messagingTemplate.convertAndSend("/topic/" + message.getM_seq(), message);
//		messagingTemplate.convertAndSendToUser(message.getId(), "/topic/" + message.getRoomid(), message.getMsg());
	}
	

	//컨트롤러를 통해 저장하는 방법. 그렇지 않으면 위의 컨트롤러와 합쳐도 상관없음
	@MessageMapping("/getChat/fileMessage/{seq}")
	public void getChatFile(MessageDTO message) throws Exception {
		System.out.println("스톰프 파일전송 메제시 컨트롤러 도착!");
		System.out.println("getChat>>" + message);
		System.out.println("SEQ=" + message.getSeq());
		System.out.println("MSG=" + message.getContents());
		System.out.println("WRITE_DATE="+message.getWrite_date());
		System.out.println("EMP_CODE="+message.getEmp_code());
		System.out.println("MSG_SEQ(방seq)"+message.getM_seq());
		//01. FILE 혹은 IMAGE 타입의 메세지 저장
		
		
		

		//messagingTemplate.convertAndSend("/topic/" + dto.getMeg_seq(), dto.getOriname());
		messagingTemplate.convertAndSend("/topic/"+message.getM_seq(), message);

	}
}
