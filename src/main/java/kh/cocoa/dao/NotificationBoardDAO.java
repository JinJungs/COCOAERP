package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;

@Mapper 
public interface NotificationBoardDAO {

	//게시글 파일 업로드 - board & files seq값 동일하게 맞추기
	public int noBoardSelectSeq();

	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum,int menu_seq);

	//검색한 리스트 가져오기
	public List<BoardDTO> getSearchList(String search, String searchBy, int menu_seq);

	//네비게이터 가져오기
	String getNavi(int cpage, int menu_seq);

	//네비게이터
	public int recordTotalCount(int menu_seq);

	//글작성
	int notificationBoardCreateDone(int noBoard_seq,BoardDTO bdto,int menu_seq);

	//게시글 읽기
	public BoardDTO notificationBoardContentsSelect(BoardDTO dto);
	
	//seq로 게시글 수 확인
	public int getSearchCount(int menu_seq);

	//조회수 올리기
	public void notificationBoardViewCount(BoardDTO dto);

	//게시글 수정
	public int notificationBoardContentsModify(BoardDTO dto);

	//게시글 삭제
	public int notificationBoardContentsDel(int seq);
	
	//앨범 게시판 글 불러오기
	public List<BoardDTO> getAlbumBoardListCpage(String cpage, int menu_seq);

}
