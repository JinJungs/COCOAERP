package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
    @RequestMapping("/test")
    public String test() {
        return "document/writedocument";
    }

    @RequestMapping("/test2")
    public String test2(){
        return "document/templatelist";
    }
}
