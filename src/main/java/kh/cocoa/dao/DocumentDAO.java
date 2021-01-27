package kh.cocoa.dao;

import java.sql.Date;
import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	//임시저장한 문서 리스트
	public List<DocumentDTO> getSearchTemporaryList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	//상신한 문서 리스트
	public List<DocumentDTO> getSearchRaiseList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//승인된 문서 리스트
	public List<DocumentDTO> getSearchApprovalList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//반려된 문서 리스트
	public List<DocumentDTO> getSearchRejectList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//회수한 문서 리스트

	public List<DocumentDTO> getSearchReturnList(String empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);

	//페이지네이션
	public int getSearchBoardCount(String empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status);

	//결재서류 내용받아오기
	public DocumentDTO getDocument(String seq);
	
	//용국
	//문서 추가.
	public int addDocument(DocumentDTO dto);

	//방금 작성한 문서 doc_code 가져오기.
	public int getDocCode(int writer_code);

	//임시 저장
	public int addSaveDocument(DocumentDTO dto);
}


