package kh.cocoa.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.NotificationBoardService;

@Controller
@RequestMapping("/myBoard")
public class MyBoardController {
	@Autowired
	private NotificationBoardService nservice;
	@Autowired
	private HttpSession session;
	//내가 쓴글
    @RequestMapping("/myBoard.mb")
    public String myBoard(Model model) {
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		//내가쓴글 불러오기
		List<BoardDTO> mylist = nservice.getMyBoardList(writer_code);
		
		model.addAttribute("list", mylist);
		
		return "community/myBoard";
		
    }
}
