package kh.cocoa.dao;

import java.sql.Date;
import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	//임시저장한 문서 리스트
	public List<DocumentDTO> getSearchTemporaryList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	//상신한 문서 리스트
	public List<DocumentDTO> getSearchRaiseList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//승인된 문서 리스트
	public List<DocumentDTO> getSearchApprovalList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//반려된 문서 리스트
	public List<DocumentDTO> getSearchRejectList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);
	
	//회수한 문서 리스트
	public List<DocumentDTO> getSearchReturnList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);

	//페이지네이션
	public int getSearchBoardCount(int empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status);

	//결재서류 내용받아오기
	public DocumentDTO getDocument(String seq);

	//읽기관련
	//status 받아오기
	public String getStatusBySeq(String seq);
	
	//temp_code 받아오기
	public String getTemp_codeBySeq(String seq);
	
	//=====임시저장, 재상신=================================================
	//임시저장 -> 임시저장
	public int tempToUpdate(DocumentDTO dto, String temp_code, String submitType);
	
	//==================================================================
	
	//문서대장
	public List<DocumentDTO> getAllConfirmDoc(Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum);

	public int getAllDocCount(Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int cpage);
	
	//전체보기
	//기안한 모든 문서(임시저장 제외) 받기
	public List<DocumentDTO> getAllDraftDocument(int empCode);
	
	
	
	//용국
	//문서 추가.
	public int addDocument(DocumentDTO dto);

	//방금 작성한 문서 doc_code 가져오기.
	public int getDocCode(int writer_code);

	//임시 저장
	public int addSaveDocument(DocumentDTO dto);
}


