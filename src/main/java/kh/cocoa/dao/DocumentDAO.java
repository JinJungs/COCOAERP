package kh.cocoa.dao;

import java.sql.Date;
import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	//임시저장한 문서 리스트
	public List<DocumentDTO> getTemporaryList();
	public List<DocumentDTO> getSearchTemporaryList(Date startDate, Date endDate, String template);
	//상신한 문서 리스트
	public List<DocumentDTO> getRaiseList();
	//승인된 문서 리스트
	public List<DocumentDTO> getApprovalList();
	//반려된 문서 리스트
	public List<DocumentDTO> getRejectList();
	//회수한 문서 리스트
	public List<DocumentDTO> getReturnList();
}
