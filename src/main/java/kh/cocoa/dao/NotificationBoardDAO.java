package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;

@Mapper 
public interface NotificationBoardDAO {

	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum);

	//게시글 검색 리스트
	public List<BoardDTO> notificationBoardListBySearch();


	//네비게이터 가져오기
	String getNavi(int cpage);

	//네비게이터
	public int recordTotalCount();

	//글작성
	int notificationBoardCreateDone(BoardDTO bdto);

	//게시글 읽기
	public BoardDTO notificationBoardContentsSelect(int seq);

	//조회수 올리기
	public void notificationBoardViewCount(int seq);

	//게시글 수정
	public int notificationBoardContentsModify(BoardDTO dto);

	//게시글 삭제
	public int notificationBoardContentsDel(int seq);













}
