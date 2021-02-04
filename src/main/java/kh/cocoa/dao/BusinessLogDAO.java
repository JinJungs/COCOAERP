package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.DocumentDTO;

@Mapper 
public interface BusinessLogDAO {

	//업무일지 종류에 따라 문서 저장
	public 	int createLog(int logDoc_seq,DocumentDTO ddto,String selectBy);
	
	//업무일지 seq & files doc_seq 맞추기
	public int logDocSelectSeq();
	
	//임시 문서 저장
	public int tempSavedLog(int logDoc_seq, DocumentDTO ddto, String selectBy);

	/*----------------보관함 (임시저장 / 업무일지 / 확인요청)-------------------------*/
	//글 전체 리스트
	public List<BoardDTO> getLogAllList(String status);
	
	//일일 리스트 
	public List<BoardDTO> dailyList(String status);
	
	//주간 리스트
	public List<BoardDTO> weeklyList(String status);
	
	//월별리스트
	public List<BoardDTO> monthlyList(String status);

	/*----------보낸업무 일지함 -------*/
	//전체
	public List<BoardDTO> sentLogAllList();
	//일일
	public List<BoardDTO> sentLogDailyList();
	//주간
	public List<BoardDTO> sentLogWeeklyList();
	//월별
	public List<BoardDTO> sentLogMonthlyList();
	/*---------------업무일지 읽기--------------*/
	//글 내용 가져오기
	public List<BoardDTO> getLogBySeq(int seq);
	//수정버튼 - 작성자인 경우만 보임
	public int checkWriter(DocumentDTO ddto);

	/*--------------업무일지 수정 시 리스트 불러오기*/
	public DocumentDTO getLogBySeqMod(int seq,DocumentDTO dto);
}
