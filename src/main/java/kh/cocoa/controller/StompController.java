package kh.cocoa.controller;

import java.nio.ByteBuffer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import kh.cocoa.dto.MessageDTO;

@Controller
public class StompController {
	@Autowired
	private SimpMessageSendingOperations messagingTemplate;
	
	@MessageMapping("/getChat/text/{seq}")
//	@SendTo("/topic/message")
	public MessageDTO getChatText(MessageDTO message) throws Exception {
		//1.받아온 내용들로 MESSAGE 테이블에 인서트(??뇌피셜. 조사 필요)
		//2.전송
		System.out.println("getChat>>" + message);
		System.out.println("SEQ=" + message.getSeq());
		System.out.println("MSG=" + message.getContents());
		System.out.println("WRITE_DATE="+message.getWrite_date());
		System.out.println("EMP_CODE="+message.getEmp_code());
		System.out.println("MSG_SEQ(방seq)"+message.getMsg_seq());
		
		messagingTemplate.convertAndSend("/topic/" + message.getMsg_seq(), message.getContents());
//		messagingTemplate.convertAndSendToUser(message.getId(), "/topic/" + message.getRoomid(), message.getMsg());
		 
		return message;
	}
	
	//ResponseEntity<byte[]>
	
	@MessageMapping("/getChat/file")
	public ByteBuffer getChatFile(ByteBuffer file) throws Exception {
		//1.받아온 내용들로 file 저장 
		//2.FilesDTO를 이용해 테이블에 인서트 (매개변수 추가하고 chqt.jsp에서도 추가)
		//2.다운받을 수 있는 링크 전송(oriname)
		System.out.println("파일전송 컨트롤러 도착!");
		System.out.println(file);
//		System.out.println("getChatFile>>" + file);
//		System.out.println(file.toString());
		//System.out.println(dto.getSeq());
		
		//FilesDTO dto = new FilesDTO();
		//dto.setMeg_seq(1);
		//messagingTemplate.convertAndSend("/topic/" + dto.getMeg_seq(), dto.getOriname());
		messagingTemplate.convertAndSend("/topic", "hi i was there");
		 
		return file;
	}
}
