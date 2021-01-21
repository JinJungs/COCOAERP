package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/message")
public class MessageController {

    @RequestMapping("/")
    public String toChatExam() {
        return "/messenger/chatExam";
    }

    @RequestMapping("chat")
    public String toChat() {
        return "/messenger/chat";
    }
}
