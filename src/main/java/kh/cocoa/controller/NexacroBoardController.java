package kh.cocoa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.BoardMenuDTO;
import kh.cocoa.service.NotificationBoardService;

@Controller
@RequestMapping("/NecBoard")
public class NexacroBoardController {
	@Autowired
	private NotificationBoardService nservice;
	//게시판 불러오기
		@RequestMapping("/getBoardMenuList.nc")
		public NexacroResult getBoardMenuList() {
			System.out.println("리스트 부르기");
			

			NexacroResult nr = new NexacroResult();
			List<BoardMenuDTO> list = new ArrayList<BoardMenuDTO>();
			list = nservice.getBoardMenuList();
			
			nr.addDataSet("out_board_menu",list);
			System.out.println(list);
			return nr;
		}
	//게시판 추가
	@RequestMapping("/addBoard.nc")
	public void addBoard(@ParamVariable(name="type")String type,@ParamVariable(name="name")String name) {
		System.out.println("추가");
		System.out.println(type);
		System.out.println(name);
		
		int result = nservice.addBoard(type,name);
		
	}
	//게시판 삭제
	@RequestMapping("/delBoard.nc")
	public String delBoard() {
		System.out.println("삭제");
		return "";
	}
	//게시판 수정
	@RequestMapping("/uptBoard.nc")
	public String uptBoard(@ParamVariable(name="name")String name,@ParamVariable(name="seq")int seq) {
		System.out.println("수정");
		System.out.println(name);
		System.out.println(seq);

		int result = nservice.uptBoard(name,seq);
		
		return "";
	}
}
