package kh.cocoa.service;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

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
	public List<DocumentDTO> getTemporaryList() {
		return ddao.getTemporaryList();
	}
	@Override
	public List<DocumentDTO> getSearchTemporaryList(Date startDate, Date endDate, String template) {
		endDate = plusOneDate(endDate);
		
		return ddao.getSearchTemporaryList(startDate, endDate, template);
	}
	//상신한 문서
	@Override
	public List<DocumentDTO> getRaiseList() {
		return ddao.getRaiseList();
	}
	//승인된 문서
	@Override
	public List<DocumentDTO> getApprovalList() {
		return ddao.getApprovalList();
	}
	//반려된 문서
	@Override
	public List<DocumentDTO> getRejectList() {
		return ddao.getRejectList();
	}
	//회수한 문서
	@Override
	public List<DocumentDTO> getReturnList() {
		return ddao.getReturnList();
	}
	
	
	//+@
	//날짜 하루 더해주는 메서드(endDate에 이용)
	public Date plusOneDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		return new Date(cal.getTimeInMillis());
	}
}
