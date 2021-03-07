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
import kh.cocoa.service.SidebarService;

@Controller
@RequestMapping("/NecBoard")
public class NexacroBoardController {
	@Autowired
	private NotificationBoardService nservice;
	@Autowired
	private SidebarService sservice;
	//게시판 불러오기
		@RequestMapping("/getBoardMenuList.nc")
		public NexacroResult getBoardMenuList() {

			NexacroResult nr = new NexacroResult();
			List<BoardMenuDTO> list = new ArrayList<BoardMenuDTO>();
			list = nservice.getBoardMenuList();
			for(int i=0; i<list.size(); i++) {
				list.get(i).setChk(0);
			}
			
			nr.addDataSet("out_board_menu",list);
			return nr;
		}
	//게시판 추가
	@RequestMapping("/addBoard.nc")
	public void addBoard(@ParamVariable(name="type")String type,@ParamVariable(name="name")String name) {
		int board_menu_seq = nservice.bms();
		int result = nservice.addBoard(type,name,board_menu_seq);
		
		int result1 = sservice.addSideBar(name,board_menu_seq);
		
	}
	//게시판 삭제
	@RequestMapping("/delBoard.nc")
	public void delBoard(@ParamVariable(name="seq")int seq) {
		//보드메뉴에서 지우기
		int result = nservice.delBoard(seq);
		//사이드바에서 목록지우기
		int result1 = sservice.delBoard(seq);
		//게시글 내용도 지우기
		int result2 = nservice.delBoardText(seq);
	}
	//게시판 수정
	@RequestMapping("/uptBoard.nc")
	public void uptBoard(@ParamVariable(name="name")String name,@ParamVariable(name="seq")int seq) {
		
		int result = nservice.uptBoard(name,seq);
		
		int result1 = sservice.uptSideBar(name,seq);
		
	}
}
