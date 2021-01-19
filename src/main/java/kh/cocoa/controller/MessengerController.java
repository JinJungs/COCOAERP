package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("messenger")
public class MessengerController {

    @RequestMapping("/chat")
    public String toChat(){
        System.out.println("채팅?");
        return "index";
    }

//    @ExceptionHandler
//    public String error(Exception e){
//        e.printStackTrace();
//        return "error";
//    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e)
    { System.err.println(e.getClass()); return "index"; }
}
