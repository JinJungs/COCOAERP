package kh.cocoa.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.DocumentDAO;
import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.statics.DocumentConfigurator;

@Service
public class DocumentService implements DocumentDAO{
	
	@Autowired
	private DocumentDAO ddao;
	//임시저장한 문서
	@Override
	public List<DocumentDTO> getSearchTemporaryList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	//상신한 문서
	@Override
	public List<DocumentDTO> getSearchRaiseList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	//승인된 문서
	@Override
	public List<DocumentDTO> getSearchApprovalList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	//반려된 문서
	@Override
	public List<DocumentDTO> getSearchRejectList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	//회수한 문서
	@Override
	public List<DocumentDTO> getSearchReturnList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	
	//=================페이지네이션
	public String getSearchNavi(String empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status) {
		endDate = plusOneDate(endDate);
		int recordTotalCount = getSearchBoardCount(empCode, startDate, endDate, templateList, searchText, cpage, status);
		
		int pageTotalCount = recordTotalCount/DocumentConfigurator.recordCountPerPage;
		if(recordTotalCount%DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if(cpage < 1) {
			cpage = 1;
		}else if(cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}
		
		int startNavi = (cpage-1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}
		
		StringBuilder sb = new StringBuilder();
		//temporary
		if(status.contentEquals("TEMP")) {
			if(needPrev) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage="+(startNavi-1)+"&status="+status+"&searchText="+searchText+"><    </a>");
			}
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage="+i+"&status="+status+"&searchText="+searchText+"> " +i + " </a>");
			}if(needNext) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage="+(endNavi+1)+"&status="+status+"&searchText="+searchText+">   > </a>");
			}
		}
		//raise
		else if(status.contentEquals("RAISE")) {
			System.out.println("recordTotalCount " + recordTotalCount);
			if(needPrev) {
				sb.append("<a href=/document/d_searchRaise.document?cpage="+(startNavi-1)+"&status="+status+"&searchText="+searchText+"><    </a>");
			}
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<a href=/document/d_searchRaise.document?cpage="+i+"&status="+status+"&searchText="+searchText+"> " +i + " </a>");
			}if(needNext) {
				sb.append("<a href=/document/d_searchRaise.document?cpage="+(endNavi+1)+"&status="+status+"&searchText="+searchText+">   > </a>");
			}
		}
		//confirm
		else if(status.contentEquals("CONFIRM")) {
			System.out.println("recordTotalCount " + recordTotalCount);
			if(needPrev) {
				sb.append("<a href=/document/d_searchApproval.document?cpage="+(startNavi-1)+"&status="+status+"&searchText="+searchText+"><    </a>");
			}
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<a href=/document/d_searchApproval.document?cpage="+i+"&status="+status+"&searchText="+searchText+"> " +i + " </a>");
			}if(needNext) {
				sb.append("<a href=/document/d_searchApproval.document?cpage="+(endNavi+1)+"&status="+status+"&searchText="+searchText+">   > </a>");
			}
		}
		//reject
		else if(status.contentEquals("REJECT")) {
			System.out.println("recordTotalCount " + recordTotalCount);
			if(needPrev) {
				sb.append("<a href=/document/d_searchReject.document?cpage="+(startNavi-1)+"&status="+status+"&searchText="+searchText+"><    </a>");
			}
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<a href=/document/d_searchReject.document?cpage="+i+"&status="+status+"&searchText="+searchText+"> " +i + " </a>");
			}if(needNext) {
				sb.append("<a href=/document/d_searchReject.document?cpage="+(endNavi+1)+"&status="+status+"&searchText="+searchText+">   > </a>");
			}
		}
		//return
		else if(status.contentEquals("RETURN")) {
			System.out.println("recordTotalCount " + recordTotalCount);
			if(needPrev) {
				sb.append("<a href=/document/d_searchReturn.document?cpage="+(startNavi-1)+"&status="+status+"&searchText="+searchText+"><    </a>");
			}
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<a href=/document/d_searchReturn.document?cpage="+i+"&status="+status+"&searchText="+searchText+"> " +i + " </a>");
			}if(needNext) {
				sb.append("<a href=/document/d_searchReturn.document?cpage="+(endNavi+1)+"&status="+status+"&searchText="+searchText+">   > </a>");
			}
		}
		return sb.toString();
	}
	
	@Override
	public int getSearchBoardCount(String empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status) {
		return ddao.getSearchBoardCount(empCode, startDate, endDate, templateList, searchText, cpage, status);
	}
	@Override
	public DocumentDTO getDocument(String seq) {
		return ddao.getDocument(seq);
	}
	//+@
	//날짜 하루 더해주는 메서드(endDate에 이용)
	public Date plusOneDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		return new Date(cal.getTimeInMillis());
	}
	
	//날짜 두개 비교해서 바꿔주는 메서드
	public List<Date> reInputDates(Date startDate, Date endDate){
		if(endDate.before(startDate)) {
			Date temp = endDate;
			endDate = startDate;
			startDate = temp;
		}
		List<Date> list = new ArrayList<>();
		list.add(startDate);
		list.add(endDate);
		return list;
	}
	
}
