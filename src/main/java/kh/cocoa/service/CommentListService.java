package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.CommentListDAO;
import kh.cocoa.dto.CommentListDTO;

@Service
public class CommentListService implements CommentListDAO{
	@Autowired
	private CommentListDAO cdao;

	/*------------------*** 회사 공지 ****------------------*/
	//코멘트 쓰기
	@Override
	public int noBoardWriteComment(CommentListDTO dto) {
		System.out.println("서비스 코멘트 쓰기");
		return cdao.noBoardWriteComment(dto);
	}
	//코멘트 리스트 불러오기
	@Override
	public List<CommentListDTO> noBoardWriteCommentList(int seq) {
		System.out.println("서비스 코멘트 리스트");
		return cdao.noBoardWriteCommentList(seq);
	}
	//댓글 수 확인
	public int noBoardCommentCount(int seq) {
		return cdao.noBoardCommentCount(seq);
	}
	//댓글 삭제
	public int noBoardDeleteComment(int seq) {
		return cdao.noBoardDeleteComment(seq);
	}
	//댓글 수정
	public int noBoardUpdateComment(CommentListDTO dto) {
		return cdao.noBoardUpdateComment(dto);
	}
	//댓글 작성자와 로그인한 사람이 동일한지 확인하고 수정 삭제 권환주기
	public String checkWriter(int seq,int writer_code) {
		System.out.println("여기서 id는?" + writer_code);
		return cdao.checkWriter(seq,writer_code);
	}
	public String getModContents(int seq) {
		return cdao.getModContents(seq);
	}
}
