//package kh.cocoa.handler;
//
//import java.io.IOException;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.BinaryMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.BinaryWebSocketHandler;
//
//@Component
//public class BinarySocketHandler extends BinaryWebSocketHandler  {
//	@Override
//	 public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
//		System.out.println("BinarySocketHandler arrived!");
//         try {
//             session.sendMessage(new BinaryMessage("hello world".getBytes()));
//         } catch (IOException e) {
//             e.printStackTrace();
//         }
//     }
//}
