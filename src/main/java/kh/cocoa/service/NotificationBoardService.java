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
	/*======Search List=================================================================*/
	//게시글 검색 리스트
	public List<BoardDTO> notificationBoardListBySearch(int cpage, String search,String searchBy) {
		List<BoardDTO> list = notificationBoardListBySearch(); 
		List<BoardDTO> searchList2 = new ArrayList<BoardDTO>();

		list = notificationBoardSearchList(list, search);
		int startRowNum = (cpage-1) * Configurator.recordCountPerPage;
		int endRowNum = startRowNum + Configurator.recordCountPerPage - 1; 

		//마지막 페이지 출력시 endRowNum 제한
		int totalCount = getSearchCount(search); //검색된 게시글 수
		if(endRowNum >= totalCount) {
			endRowNum = totalCount-1; 
		}
		for(int i=startRowNum; i<=endRowNum; i++) {
			searchList2.add(list.get(i));   
		}

		return searchList2;
	}

	@Override 
	public List<BoardDTO> notificationBoardListBySearch(){ 
		return ndao.notificationBoardListBySearch(); 
	}

	//검색한 리스트 받기
	public List<BoardDTO> notificationBoardSearchList(List<BoardDTO> list, String search){
		//검색한 리스트 받기
		List<BoardDTO> searchList = new ArrayList<BoardDTO>();
		for(int i=0; i<list.size(); i++) {
			String title = list.get(i).getTitle();
			String contents = list.get(i).getContents();

			// 글 내용이나 글제목이 검색창에 입력된 것과 같은 경우 리스트 가져오기
			if(contents.contains(search) || title.contains(search)) {
				searchList.add(list.get(i));
			}
		}
		return searchList;
	}
	//검색된 게시글 수
	public int getSearchCount(String search) {
		List<BoardDTO> list = notificationBoardListBySearch();
		list = notificationBoardSearchList(list, search);
		return list.size();
	}
	//검색 게시글 네비
	public String notificationBoardSearchNavi(int cpage, String search,String searchBy) {
		int recordTotalCount = getSearchCount(search);
		System.out.println("검색 recordTotalCount :"+ recordTotalCount);
		int pageTotalCount = recordTotalCount/Configurator.recordCountPerPage;
		if(recordTotalCount/Configurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		if(cpage < 1) {
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
		
		System.out.println("검색 후 총 페이지 개수 : " + pageTotalCount);
		System.out.println("검색 후 현재 위치 : " + cpage);
		System.out.println("검색 후  시작 네비 : " + startNavi);
		System.out.println("검색 후 끝 네비 : " + endNavi);

		StringBuilder sb = new StringBuilder();
		if(needPrev) {
			sb.append("<li class=page-item disabled><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+(startNavi-1)+"&search="+search+">Previous</a></li>");
		}
		for(int i=startNavi; i<=endNavi; i++) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+i+"&search="+search+"> "+i+"</a></li>");
		}if(needNext) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardSearch.no?cpage="+(endNavi+1)+"&search="+search+">Next</a></li>");
		}

		return sb.toString();
	}
	/*======List=================================================================*/

	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardListCpage(String cpage){
		int startRowNum = (Integer.parseInt(cpage)-1)*Configurator.recordCountPerPage+1;
		int endRowNum = Integer.parseInt(cpage) *Configurator.recordCountPerPage-1;
		return getNotificationBoardList(startRowNum,endRowNum);
	}
	@Override
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum){
		return ndao.getNotificationBoardList(startRowNum,endRowNum);
	}
	@Override
	public int recordTotalCount() { //getNavi에 들어가는 내용
		return ndao.recordTotalCount();
	}
	//네비게이터 가져오기
	@Override
	public String getNavi(int cpage) {
		int recordTotalCount = recordTotalCount();
		System.out.println("totalCount :"+ recordTotalCount);
		int pageTotalCount;
		if(recordTotalCount / Configurator.recordCountPerPage > 0) {
			System.out.println("recordCountPage  "+Configurator.recordCountPerPage);
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage +1;
		}else {
			pageTotalCount = recordTotalCount / Configurator.recordCountPerPage;
		}

		if(cpage < 1) {
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
		System.out.println("총 페이지 개수 : " + pageTotalCount);
		System.out.println("현재 위치 : " + cpage);
		System.out.println("시작 네비 : " + startNavi);
		System.out.println("끝 네비 : " + endNavi);
		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<li class=page-item disabled><a class=page-link href=/noBoard/notificationBoardList.no?cpage="+(startNavi-1)+">Previous</a></li>");
		}
		for(int i = startNavi; i<=endNavi; i++){
			sb.append("<li class=page-item><a class=page-link href =/noBoard/notificationBoardList.no?cpage="+i+"> "+i+"</a></li>");
		}
		if(needNext) {
			sb.append("<li class=page-item><a class=page-link href=/noBoard/notificationBoardList.no?cpage="+(endNavi+1)+">Next</a></li>");
		}
		return sb.toString();

	}

	//글작성
	public int notificationBoardCreateDone(BoardDTO bdto) {
		return ndao.notificationBoardCreateDone(bdto);
	}

	//게시글 읽기
	public BoardDTO notificationBoardContentsSelect(int seq) {
		return ndao.notificationBoardContentsSelect(seq);
	}
	//게시글 조회수 올리기
	public void notificationBoardViewCount(int seq) {
		ndao.notificationBoardViewCount(seq);
	}
	//게시글 수정
	public int notificationBoardContentsModify(BoardDTO dto) {
		return ndao.notificationBoardContentsModify(dto);
	}
	//게시글 삭제
	public int notificationBoardContentsDel(int seq) {
		return ndao.notificationBoardContentsDel(seq);
	}

}
