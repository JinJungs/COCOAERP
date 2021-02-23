package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.NotificationBoardDAO;
import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.BoardMenuDTO;
import kh.cocoa.statics.Configurator;

@Service
public class NotificationBoardService implements NotificationBoardDAO {
	@Autowired
	private NotificationBoardDAO ndao;

	//글작성
	public int notificationBoardCreateDone(int noBoard_seq,BoardDTO bdto,int menu_seq) {
		return ndao.notificationBoardCreateDone(noBoard_seq,bdto,menu_seq);
	}

	//게시글 읽기
	public BoardDTO notificationBoardContentsSelect(BoardDTO dto) {
		return ndao.notificationBoardContentsSelect(dto);
	}
	//seq로 게시글 수 확인
	public int isExistReadPage(int menu_seq) {
		return ndao.isExistReadPage(menu_seq);
	}

	//게시글 조회수 올리기
	public void notificationBoardViewCount(BoardDTO dto) {
		ndao.notificationBoardViewCount(dto);
	}
	//게시글 수정
	public int notificationBoardContentsModify(BoardDTO dto) {
		return ndao.notificationBoardContentsModify(dto);
	}
	//게시글 삭제
	public int notificationBoardContentsDel(int seq) {
		return ndao.notificationBoardContentsDel(seq);
	}
	//게시글 파일 업로드 - board & files seq값 동일하게 맞추기
	@Override
	public int noBoardSelectSeq() {
		return ndao.noBoardSelectSeq();
	}
	//앨범 게시판 게시글 불러오기
	public List<BoardDTO> getAlbumBoardListCpage(String cpage, int menu_seq) {
		List<BoardDTO> result = ndao.getAlbumBoardListCpage(cpage,menu_seq);
		return result;
	}

	/*======Search List=================================================================*/
	
	@Override
	public List<BoardDTO> getAlbumBoardListSearch(String search, String searchBy, int menu_seq,int cpage){
		return ndao.getAlbumBoardListSearch(search,searchBy,menu_seq,cpage);
	}
	//게시글 검색 리스트
	public List<BoardDTO>notificationBoardListBySearch(String search, String searchBy, int menu_seq, int cpage) {
		
		//검색한 결과
		int searchList = getSearchCount(search,searchBy,menu_seq);
		System.out.println("검색결과?"+searchList);
		
		int startRowNum = (cpage-1) * Configurator.recordCountPerPage+1;
		int endRowNum = cpage * Configurator.recordCountPerPage; 
		
		
		return getSearchList(startRowNum, endRowNum,search,searchBy,menu_seq);
	}
	@Override
	public List<BoardDTO> getSearchList(int startRowNum, int endRowNum,String search, String searchBy, int menu_seq){
		return ndao.getSearchList(startRowNum,endRowNum,search,searchBy,menu_seq);
	}
	@Override
	public int getSearchCount(String search, String searchBy, int menu_seq) {
		System.out.println("왜지"+search + searchBy);
		return ndao.getSearchCount(search,searchBy,menu_seq);
	}
	//검색 게시글 네비
	public String notificationBoardSearchNavi(int menu_seq,int cpage,String search,String searchBy,int getSearchCount) {
		int recordTotalCount = getSearchCount;
		System.out.println("여기서 갯수!!"+recordTotalCount);

		int pageTotalCount;
		if (recordTotalCount % Configurator.recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage +1;
		} else {
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage;
		}
		
		System.out.println("페이지 수는?"+pageTotalCount);
		
		if(cpage < 0) {
			cpage = 1;
		}else if(cpage>pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage-1)/Configurator.recordCountPerPage*Configurator.recordCountPerPage + 1;
		int endNavi = startNavi + Configurator.recordCountPerPage -1;
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}
		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<li class=page-item disabled><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+(startNavi-1)+"&menu_seq="+menu_seq+"&search="+search+">Previous</a></li>");
		}
		for(int i=startNavi; i<=endNavi; i++) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+i+"&menu_seq="+menu_seq+"&search="+search+"> "+i+"</a></li>");
		}if(needNext) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+(endNavi+1)+"&menu_seq="+menu_seq+"&search="+search+">Next</a></li>");
		}

		return sb.toString();
	}

	/*======List=================================================================*/
	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardListCpage(String cpage,int menu_seq){
		int startRowNum = (Integer.parseInt(cpage)-1)*Configurator.recordCountPerPage+1;
		int endRowNum = Integer.parseInt(cpage) *Configurator.recordCountPerPage;
		return getNotificationBoardList(startRowNum,endRowNum,menu_seq);
	}
	//게시글 리스트 불러오기 @ 메인화면
	public List<BoardDTO> getNoBoardList(int menu_seq) {
		return ndao.getNoBoardList(menu_seq);
	}
	
	@Override
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum,int menu_seq){
		return ndao.getNotificationBoardList(startRowNum,endRowNum,menu_seq);
	}
	@Override
	public int recordTotalCount(int menu_seq) { //getNavi에 들어가는 내용
		return ndao.recordTotalCount(menu_seq);
	}
	//네비게이터 가져오기
	@Override
	public String getNavi(String type,int cpage,int menu_seq) {

		int recordTotalCount = recordTotalCount(menu_seq);
		System.out.println("총 게시글 수는?"+recordTotalCount);
		
		int pageTotalCount;
		if (recordTotalCount % Configurator.recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage;
		}
		
		System.out.println("페이지 수는?"+pageTotalCount);

		if(cpage < 0) {
			cpage=1;
		}else if(cpage > pageTotalCount) {
			cpage=pageTotalCount;
		}
		int startNavi = (cpage-1) / Configurator.naviCountPerPage * Configurator.naviCountPerPage +1;
		int endNavi = startNavi + Configurator.naviCountPerPage-1;

		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}
		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<li class=page-item disabled><a class=page-link href=/noBoard/notificationBoardList.no?type="+type+"&cpage="+(startNavi-1)+"&menu_seq="+menu_seq+">Previous</a></li>");
		}
		for(int i = startNavi; i<=endNavi; i++){
			sb.append("<li class=page-item><a class=page-link href =/noBoard/notificationBoardList.no?type="+type+"&cpage="+i+"&menu_seq="+menu_seq+"> "+i+"</a></li>");
		}
		if(needNext) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardList.no?type="+type+"&cpage="+(endNavi+1)+"&menu_seq="+menu_seq+">Next</a></li>");
		}
		return sb.toString();

	}
	//게시글 작성자와 로그인한 사람이 동일한지 확인하고 수정 삭제 권환주기
	public int checkWriter(BoardDTO dto) {
		return ndao.checkWriter(dto);
	}
	//내가 쓴글 리스트 가져오기
	public List<BoardDTO> getMyBoardList(int writer_code) {
		return ndao.getMyBoardList(writer_code);
	}
	//넥사크로 - 모든 보드 메뉴 불러오기
	public List<BoardMenuDTO> getBoardMenuList() {
		return ndao.getBoardMenuList();
	}
	//넥사크로 게시판 추가
	@Override
	public int addBoard(String type, String name,int board_menu_seq) {
		return  ndao.addBoard(type,name,board_menu_seq);
	}
	//넥사크로 게시판 수정
	@Override
	public int uptBoard(String name,int seq) {
		return ndao.uptBoard(name,seq);
	}
	@Override
	public int bms() {
		return ndao.bms();
	}

	//보드메뉴에서 지우기
	public int delBoard(int seq) {
		return ndao.delBoard(seq);
	}

	//게시글 내용도 지우기
	public int delBoardText(int seq) {
		return ndao.delBoardText(seq);
	}
}
