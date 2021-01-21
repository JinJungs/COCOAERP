package kh.cocoa.service;

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
	
	@Override
	public int recordTotalCount() { //getNavi에 들어가는 내용
		return ndao.recordTotalCount();
	}
	
	//게시글 리스트 가져오기
	public List<BoardDTO> getNotificationBoardListCpage(String cpage){
		int startRowNum = (Integer.parseInt(cpage)-1)*Configurator.recordCountPerPage+1;
		int endRowNum = Integer.parseInt(cpage) *Configurator.recordCountPerPage+1;
		return getNotificationBoardList(startRowNum,endRowNum);
	}
	//Dao에 있는 것
	@Override
	public List<BoardDTO> getNotificationBoardList(int startRowNum, int endRowNum){
		return ndao.getNotificationBoardList(startRowNum,endRowNum);
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
}
