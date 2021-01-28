package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.CommentListDTO;

@Mapper 
public interface CommentListDAO {
	//댓글 쓰기
	public int noBoardWriteComment(CommentListDTO dto);
	//댓글 리스트 불러오기
	List<CommentListDTO> noBoardWriteCommentList(int seq);
	//댓글 수 확인
	public int noBoardCommentCount(int seq);
	//댓글 삭제
	public int noBoardDeleteComment(int seq);
	//댓글 수정
	public int noBoardUpdateComment(CommentListDTO dto);

}
