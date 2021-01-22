package kh.cocoa.controller;

import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService msgservice;

    @RequestMapping("/")
    public String toChatExam() {
        return "/messenger/chatExam";
    }

    @RequestMapping("chat")
    public String toChat() {
        return "/messenger/chat";
    }

    // 메세지 테이블에 insert
    @RequestMapping("createMessage")
    @ResponseBody
    public String insertMessage(MessageDTO msgdto) {
        int result = msgservice.insertMessage(msgdto);
        return "";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }
}
