package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CocoaWorksBoardController {
	//자유게시판
    @RequestMapping("/cocoaWorksBoard")
    public String cocoaWorksBoard() {
        return "/community/cocoaWorksBoard";
    }
    //자유게시글 읽기
    @RequestMapping("/cocoaWorksBoardRead")
    public String cocoaWorksBoardRead() {
        return "/community/cocoaWorksBoardRead";
    }
    //자유게시글 작성
    @RequestMapping("/cocoaWorksBoardCreate")
    public String cocoaWorksBoardCreate() {
        return "/community/cocoaWorksBoardCreate";
    }
    //자유게시글 수정 
    @RequestMapping("/cocoaWorksBoardModify")
    public String cocoaWorksBoardModify() {
        return "/community/cocoaWorksBoardModify";
    }
    
}
