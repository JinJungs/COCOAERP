package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.DocumentDTO;

@Mapper 
public interface BusinessLogDAO {

	//업무일지 종류에 따라 문서 저장
	public 	int createLog(int logDoc_seq,DocumentDTO ddto,String selectBy,int dept_code);
	
	//업무일지 seq & files doc_seq 맞추기
	public int logDocSelectSeq();
	
	//임시 문서 저장
	public int tempSavedLog(int logDoc_seq, DocumentDTO ddto, String selectBy,int dept_code);

	/*----------------임시저장 보관함 ------------------------*/
	//글 전체 리스트
	public List<BoardDTO> getLogAllList(String status,int writer_code);
	
	//일일 리스트 
	public List<BoardDTO> dailyList(String status,int writer_code);
	
	//주간 리스트
	public List<BoardDTO> weeklyList(String status,int writer_code);
	
	//월별리스트
	public List<BoardDTO> monthlyList(String status,int writer_code);

	/*----------------확인요청 보관함 -------------------------*/
	public List<BoardDTO> logAllListR(String status, int pos_code, int dept_code);
	
	public List<BoardDTO> dailyListR(String status, int pos_code, int dept_code);

	public List<BoardDTO> weeklyListR(String status, int pos_code, int dept_code);

	public List<BoardDTO> monthlyListR(String status, int pos_code, int dept_code);
	
	/*----------------업무일지  보관함------------------------*/

	public List<BoardDTO> logAllListC(String status, int dept_code);

	public List<BoardDTO> dailyListC(String status, int dept_code);

	public List<BoardDTO> weeklyListC(String status, int dept_code);

	public List<BoardDTO> monthlyListC(String status, int dept_code);
	/*----------보낸업무 일지함 -------*/
	//전체
	public List<BoardDTO> sentLogAllList(int writer_code);
	//일일
	public List<BoardDTO> sentLogDailyList(int writer_code);
	//주간
	public List<BoardDTO> sentLogWeeklyList(int writer_code);
	//월별
	public List<BoardDTO> sentLogMonthlyList(int writer_code);
	/*---------------업무일지 읽기--------------*/
	//글 내용 가져오기
	public DocumentDTO getLogBySeq(int seq);
	//수정버튼 - 작성자인 경우만 보임
	public int checkWriter(int seq, int writer_code);

	/*--------------업무일지 수정 시 리스트 불러오기*/
	public DocumentDTO getLogBySeqMod(int seq,DocumentDTO dto, String status);

	/*--------임시보관된 문서 삭제--------*/
	public int logDel(int seq);

	/*----------확인요청 문서 거절-------*/
	public int updateStatusReject(int seq, String status);

	/*----------확인요청 문서 승인-------*/
	public int updateStatusConfirm(int seq,String report_contents);

	//수정페이지 - 임시저장
	public int logModifyTempUpdateDaily(DocumentDTO ddto);
	
	//수정페이지 - 임시저장
	public int logModifyTempUpdate(DocumentDTO ddto);

	//수정 페이지 - 수정 후 상신 (일일)
	public int logModifyDaily(DocumentDTO ddto);

	//수정 페이지 - 수정 후 상신 (주간 & 월별)
	public int logModify(DocumentDTO ddto);

}
