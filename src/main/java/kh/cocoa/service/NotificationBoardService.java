package kh.cocoa.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.NotificationBoardDAO;
import kh.cocoa.dto.BoardDTO;
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
		return ndao.getSearchCount(menu_seq);
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
		return ndao.getAlbumBoardListCpage(cpage,menu_seq);
	}

	/*======Search List=================================================================*/
	List<BoardDTO> searchList;
	//게시글 검색 리스트
	public List<BoardDTO>notificationBoardListBySearch(String search, String searchBy, int menu_seq, int cpage) {
		System.out.println("서비스 검색 menu_seq"+menu_seq);
		System.out.println("서비스 검색 search " +search);
		System.out.println("서비스 검색 searchBy " +searchBy);
		System.out.println("서비스 검색 cpage " +cpage);
		
		//검색한 결과
		searchList = getSearchList(search,searchBy,menu_seq);
		
		System.out.println("검색 결과는? "+searchList);
		System.out.println("검색 결과는? "+searchList.size());
		
		int startRowNum = (cpage-1) * Configurator.recordCountPerPage;
		int endRowNum = startRowNum + Configurator.recordCountPerPage-1; 

		//마지막 페이지 출력시 endRowNum 제한
		int totalCount = getSearchCount(menu_seq); //검색된 게시글 수
		System.out.println("검색된 게시글 수는? "+totalCount);

		if(endRowNum >= totalCount) {
			endRowNum = totalCount-1; 
		}
		return ndao.getSearchList(search,searchBy,menu_seq);
	}
	@Override
	public List<BoardDTO> getSearchList(String search, String searchBy, int menu_seq){
		return ndao.getSearchList(search,searchBy,menu_seq);
	}
	@Override
	public int getSearchCount(int menu_seq) {
		return ndao.getSearchCount(menu_seq);
	}
	//검색 게시글 네비
	public String notificationBoardSearchNavi(int menu_seq,int cpage, String search,String searchBy) {
		int recordTotalCount = searchList.size();

		int pageTotalCount = recordTotalCount/Configurator.recordCountPerPage;
		if(recordTotalCount%Configurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
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
		System.out.println("시작 갯수는?"+startRowNum);
		int endRowNum = Integer.parseInt(cpage) *Configurator.recordCountPerPage;
		System.out.println("끝 갯수는?"+endRowNum);
		return getNotificationBoardList(startRowNum,endRowNum,menu_seq);
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
	public String getNavi(int cpage,int menu_seq) {
		System.out.println("navi에서 menu_seq값은?" +menu_seq);
		System.out.println("navi에서 cpage값은?" +cpage);

		int recordTotalCount = recordTotalCount(menu_seq);
		System.out.println("게시글 수" +recordTotalCount);
		
		int pageTotalCount = recordTotalCount/Configurator.recordCountPerPage;
		System.out.println("페이지 갯수" +pageTotalCount);
		
		if(recordTotalCount%Configurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}


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
			sb.append("<li class=page-item disabled><a class=page-link href=/noBoard/notificationBoardList.no?cpage="+(startNavi-1)+"&menu_seq="+menu_seq+">Previous</a></li>");
		}
		for(int i = startNavi; i<=endNavi; i++){
			sb.append("<li class=page-item><a class=page-link href =/noBoard/notificationBoardList.no?cpage="+i+"&menu_seq="+menu_seq+"> "+i+"</a></li>");
		}
		if(needNext) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardList.no?cpage="+(endNavi+1)+"&menu_seq="+menu_seq+">Next</a></li>");
		}
		return sb.toString();

	}


}
