package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;

@Mapper 
public interface NotificationBoardDAO {
	
	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum);

	//네비게이터 가져오기
	String getNavi(int cpage);

	//네비게이터
	public int recordTotalCount();

	//글작성
	int notificationBoardCreateDone(BoardDTO bdto);
	
	//게시글 읽기
	public BoardDTO notificationBoardContentsSelect(int seq);

	
}
