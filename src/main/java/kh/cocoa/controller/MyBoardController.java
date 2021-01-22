package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyBoardController {
	//내가 쓴글
    @RequestMapping("/myBoard")
    public String myBoard() {
        return "/community/myBoard";
    }
}
