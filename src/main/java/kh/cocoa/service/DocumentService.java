package kh.cocoa.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.DocumentDAO;
import kh.cocoa.dto.DocumentDTO;

@Service
public class DocumentService implements DocumentDAO{
	
	@Autowired
	private DocumentDAO ddao;
	//임시저장한 문서
	@Override
	public List<DocumentDTO> getSearchTemporaryList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText);
	}
	//상신한 문서
	@Override
	public List<DocumentDTO> getSearchRaiseList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText);
	}
	//승인된 문서
	@Override
	public List<DocumentDTO> getSearchApprovalList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText);
	}
	//반려된 문서
	@Override
	public List<DocumentDTO> getSearchRejectList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText);
	}
	//회수한 문서
	@Override
	public List<DocumentDTO> getSearchReturnList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText);
	}
	
	//=================페이지네이션
	/*public String getSearchNavi(String searchText) {
		int recordTotalCount = getSearchBoardCount(searchText);
	}*/
	
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

	//용국


	@Override
	public int addDocument(DocumentDTO dto) {
		return ddao.addDocument(dto);
	}

	@Override
	public int getDocCode(int writer_code) {
		return ddao.getDocCode(writer_code);
	}
}
