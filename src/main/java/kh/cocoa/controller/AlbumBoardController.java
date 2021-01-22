package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AlbumBoardController {
	
	//앨범게시판
    @GetMapping("/albumBoard")
    public String albumBoard() {
        return "/community/albumBoard";
    }
    //앨범게시판 읽기
    @GetMapping("/albumBoardRead")
    public String albumBoardRead() {
        return "/community/albumBoardRead";
    }
    //앨범게시판 작성
    @GetMapping("/albumBoardCreate")
    public String albumBoardCreate() {
        return "/community/albumBoardCreate";
    }
    //앨범게시판 수정 
    @GetMapping("/albumBoardModify")
    public String albumBoardModify() {
        return "/community/albumBoardModify";
    }
}
