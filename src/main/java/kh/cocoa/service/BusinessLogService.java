package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.BusinessLogDAO;
import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.DocumentDTO;

@Service
public class BusinessLogService implements BusinessLogDAO {
	
	@Autowired
	private BusinessLogDAO bdao;
	
	//업무일지 종류에 따라 문서 저장
	@Override
	public int createLog(int logDoc_seq,DocumentDTO ddto,String selectBy) {
		return bdao.createLog(logDoc_seq,ddto,selectBy);
	}
	//업무일지 seq & files doc_seq 맞추기
	@Override
	public int logDocSelectSeq() {
		return bdao.logDocSelectSeq();
	}
	//임시 문서 저장
	@Override
	public int tempSavedLog(int logDoc_seq, DocumentDTO ddto, String selectBy) {
		System.out.println("서비스 selectBy : "+selectBy);
		return bdao.tempSavedLog(logDoc_seq,ddto,selectBy);
	}
	/*----------------보관함 (임시저장 / 업무일지 / 확인요청)-------------------------*/
	
	//글 전체 리스트
	@Override
	public List<BoardDTO> getLogAllList(String status) {
		return bdao.getLogAllList(status);
	}
	//일일 리스트
	public List<BoardDTO> dailyList(String status) {
		return bdao.dailyList(status);
	}
	// 주간 리스트
	public List<BoardDTO> weeklyList(String status) {
		return bdao.weeklyList(status);
	}
	//월별 리스트
	public List<BoardDTO> monthlyList(String status) {
		return bdao.monthlyList(status);
	}
	/*----------보낸업무 일지함 ------*/
	//전체
	public List<BoardDTO> sentLogAllList() {
		return bdao.sentLogAllList();
	}
	//일일
	public List<BoardDTO> sentLogDailyList() {
		return bdao.sentLogDailyList();
	}
	//주간
	public List<BoardDTO> sentLogWeeklyList() {
		return bdao.sentLogWeeklyList();
	}
	//월간
	public List<BoardDTO> sentLogMonthlyList() {
		return bdao.sentLogMonthlyList();
	}
	/*---------------업무일지 읽기--------------*/
	//글 가져오기
	public List<BoardDTO> getLogBySeq(int seq) {
		return bdao.getLogBySeq(seq);
	}
	//수정버튼 - 작성자인 경우만 보임
	public int checkWriter(DocumentDTO ddto) {
		return bdao.checkWriter(ddto);
	}
	/*--------------업무일지 수정 시 리스트 불러오기*/
	public DocumentDTO getLogBySeqMod(int seq,DocumentDTO dto) {
		return bdao.getLogBySeqMod(seq,dto);
	}
}
