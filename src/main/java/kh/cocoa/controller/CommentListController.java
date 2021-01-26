package kh.cocoa.controller;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.cocoa.dto.CommentListDTO;
import kh.cocoa.service.CommentListService;

@Controller
@RestController
@RequestMapping("/comment")
public class CommentListController {
	@Autowired
	CommentListService cservice;

	/*------------------*** 회사 공지 ****------------------*/
	//댓글 작성
	@RequestMapping("noBoardWriteComment.co") 
	public String noBoardWriteComment(CommentListDTO dto) {
		System.out.println("회사공지 글쓰기 컨트롤러 도착");
		System.out.println("컨텐츠? "+dto.getContents());
		System.out.println("게시글 번호" + dto.getSeq());
		//로그인한 아이디로 댓글 작성자 보이게 하기
		int writer_code = 1005;
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
	public String noBoardWriteCommentList(CommentListDTO dto,int seq,Model model) {
		System.out.println("댓글 리스트 불러오기");
		System.out.println("게시글 seq 은?"+seq);
		JSONArray jArray = new JSONArray();
		List<CommentListDTO> list = cservice.noBoardWriteCommentList(dto,seq);
		System.out.println("댓글 list : "+list);
		// list를 JsonArray로 바꾼다.
		for (int i = 0; i < list.size(); i++) {
			HashMap<String,Object> param = new HashMap<String, Object>();
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
		int result = cservice.noBoardUpdateComment(dto);
		JsonObject obj = new JsonObject();
		obj.addProperty("result", result);
		return new Gson().toJson(obj);
	}
}
