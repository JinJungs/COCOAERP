package kh.cocoa.handler;

import kh.cocoa.dto.MessageDTO;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageHandler {
    @MessageMapping("/hello")
    @SendTo("/topic/roomId")
    public MessageDTO broadcasting(MessageDTO message)throws Exception{
        System.out.println("message: "+ message.getContents());
        return message;
    }

    @MessageMapping("/out")
    @SendTo("/topic/out")
    public String outroom(String message) throws Exception{
        System.out.println("out message: "+ message);
        return message;
    }

    @MessageMapping("/in")
    @SendTo("/topic/in")
    public String inroom(String message) throws Exception{
        System.out.println("in message: "+ message);
        return message;
    }
}
