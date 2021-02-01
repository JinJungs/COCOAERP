package kh.cocoa.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
//지금은 필요 없고 바이너리파일 받는 웹소켓 참고용으로 두는 중 / 
//현재 endpoint/ChatEndpoint 로 가서 파일 받기 작업
public class ReplyEchoHandler extends TextWebSocketHandler {
	List<WebSocketSession> sessions = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		System.out.println("afterConnectionEstablished:" + session);
		sessions.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage:" + session + " : " + message);
		String senderId = session.getId(); //http의 세션 아이디가 있으면 그걸로 바꾸기
		for (WebSocketSession sess: sessions) {
			sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionEstablished:" + session + ":" + status);
	}
}
