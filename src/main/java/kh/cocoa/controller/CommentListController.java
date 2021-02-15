package kh.cocoa.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.cocoa.dto.CommentListDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.CommentListService;

@Controller
@RestController
@RequestMapping("/comment")
public class CommentListController {
	@Autowired
	private CommentListService cservice;
	
	@Autowired
	private HttpSession session;
	
	/*------------------*** 회사 공지 ****------------------*/
	//댓글 작성
	@RequestMapping("noBoardWriteComment.co") 
	public String noBoardWriteComment(CommentListDTO dto) {
		
		//로그인한 아이디로 댓글 작성자 보이게 하기
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		
		int writer_code = (Integer)loginDTO.getCode();
		System.out.println("댓글?" +writer_code);
		dto.setWriter_code(writer_code);

		//댓글 작성 (DB에 저장)
		int result = cservice.noBoardWriteComment(dto);
		System.out.println("댓글 결과는?"+result);
		JsonObject obj = new JsonObject();
		obj.addProperty("result", result);
		return new Gson().toJson(obj);
	}
	//댓글 리스트 불러오기
	@RequestMapping("noBoardWriteCommentList.co")
	public String noBoardWriteCommentList(int seq,CommentListDTO dto,Model model) {
		System.out.println("댓글 리스트 불러오기");
		System.out.println("게시글 seq 은?"+seq);
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");

		int writer_code = (Integer)loginDTO.getCode();
		//로그인한 정보의 code를 board DTO writer_code에 넣어주기
		dto.setWriter_code(writer_code);
		System.out.println("동일한 사람?"+writer_code);
		JSONArray jArray = new JSONArray();
		List<CommentListDTO> list = cservice.noBoardWriteCommentList(seq);
		System.out.println("댓글 list : "+list);
		
		//int checkWriter =0;
		// list를 JsonArray로 바꾼다.
		for (int i = 0; i < list.size(); i++) {
			HashMap<String,Object> param = new HashMap<String, Object>();
			//댓글 작성자와 로그인한 사람이 동일한지 확인하고 수정 삭제 권환주기
			int checkWriter = cservice.checkWriter(seq,writer_code);
			if(writer_code==list.get(i).getWriter_code()) {
				param.put("checkWriter", checkWriter);
			}else{
				param.put("checkWriter", 0);
			}
			param.put("seq", list.get(i).getSeq());
			param.put("contents", list.get(i).getContents());
			param.put("board_seq", list.get(i).getBoard_seq());
			param.put("writer_code", list.get(i).getWriter_code());
			param.put("write_date", list.get(i).getWrite_date());
			param.put("name", list.get(i).getName());
			jArray.put(param);
		//댓글 수 확인
		int noBoardCommentCount = cservice.noBoardCommentCount(seq);
		System.out.println("해당 게시글에 댓글 수는? "+noBoardCommentCount);
		
		model.addAttribute("list",list);
		model.addAttribute("writer_code",writer_code);
		model.addAttribute("noBoardCommentCount",noBoardCommentCount);

		}
		return jArray.toString();
	}
	//댓글 삭제
	@RequestMapping("noBoardDeleteComment.co")
	public String noBoardDeleteComment(int seq) {
		System.out.println("댓글 삭제 컨트롤러 도착");
		int result = cservice.noBoardDeleteComment(seq);
		JsonObject obj = new JsonObject();
		obj.addProperty("result", result);
		return new Gson().toJson(obj);
	}

	//댓글 수정
	@RequestMapping("noBoardUpdateComment.co")
	public String noBoardUpdateComment(CommentListDTO dto) {
		System.out.println("댓글수정 도착!");
		int result = cservice.noBoardUpdateComment(dto);
		JsonObject obj = new JsonObject();
		obj.addProperty("result", result);
		return new Gson().toJson(obj);
	}
}
