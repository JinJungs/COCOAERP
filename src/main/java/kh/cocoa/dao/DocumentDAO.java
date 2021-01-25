package kh.cocoa.dao;

import java.sql.Date;
import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	//임시저장한 문서 리스트
	public List<DocumentDTO> getSearchTemporaryList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText);
	//상신한 문서 리스트
	public List<DocumentDTO> getSearchRaiseList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText);
	
	//승인된 문서 리스트
	public List<DocumentDTO> getSearchApprovalList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText);
	
	//반려된 문서 리스트
	public List<DocumentDTO> getSearchRejectList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText);
	//회수한 문서 리스트
	public List<DocumentDTO> getSearchReturnList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText);


	//용국
	//문서 추가.
	public int addDocument(DocumentDTO dto);

}




