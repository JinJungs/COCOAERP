package kh.cocoa.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.FilesMsgDTO;

@Service
public class FilesService implements FilesDAO {
	@Autowired
	private FilesDAO fdao;
	// 게시판용 파일 업로드
	public int uploadFiles(int noBoard_seq, FilesDTO fdto) { 
		return fdao.uploadFiles(noBoard_seq,fdto); 
	}

	// 업무일지용 파일 업로드
	public int uploadFilesBusinessLog(int logDoc_seq, FilesDTO fdto) {
		return fdao.uploadFilesBusinessLog(logDoc_seq,fdto);
	}
	//파일 불러오기
	public List<FilesDTO> downloadFilesBySeq(int noBoard_seq){
		return fdao.downloadFilesBySeq(noBoard_seq);
	}
	//첨부파일 목록
	public List<FilesDTO> downloadFileList(FilesDTO dto) {
		return fdao.downloadFileList(dto);
	}
	
	//앨범게시판에서 게시글 사진 불러오기
		public FilesDTO getImage(FilesDTO fdto) {
			System.out.println("사진불러오기 :"+fdto.getBoard_seq());
			return fdao.getImage(fdto);
		}
	//게시글에 업로드된 파일 갯수 확인
	public int isExistUploadFile(FilesDTO fdto) {
		return fdao.isExistUploadFile(fdto);
	}
	//게시글에 업로드된 첨부파일 리스트 불러오기
	public List<FilesDTO> getFilesBySeq(FilesDTO fdto) {
		return fdao.getFilesBySeq(fdto);
	}
	//파일 삭제하기
	public int deleteNotificationBoardFiles(int seq) {
		return fdao.deleteNotificationBoardFiles(seq);
	}
	//임시보관 문서에 첨부된 파일 삭제
	public int logFileDel(int seq) {
		return fdao.logFileDel(seq);
	}

	/*용국 업로드*/

	@Override
	public int documentInsertFile(String oriName,String savedName,int doc_seq) {

		return fdao.documentInsertFile(oriName,savedName,doc_seq);
	}
	//DocumentSeq에 따른 파일리스트
	public List<FilesDTO> getFilesListByDocSeq(String seq){
		return fdao.getFilesListByDocSeq(seq);
	}	
	/* =============채팅 파일=============== */
	//파일 업로드
	@Override
	public int uploadFilesMsg(FilesDTO fdto) {
		return fdao.uploadFilesMsg(fdto); 
	}
	//파일 msg_seq수정
	@Override
	public int updateMsgSeq(int msg_seq, String savedName) {
		return fdao.updateMsgSeq(msg_seq, savedName);
	}
	//msg_seq로 파일 oriname 찾기
	@Override
	public String getSavedName(int msg_seq) {
		return fdao.getSavedName(msg_seq);
	}
	//파일 모아보기 리스트
	@Override
	public List<FilesMsgDTO> showFileMsg(int m_seq){
		List<FilesMsgDTO> list = fdao.showFileMsg(m_seq);
		return list;
	}
	//파일 모아보기 리스트를 url에 넣기 위해 인코딩
	public List<FilesMsgDTO> encodedShowFileMsg(List<FilesMsgDTO> list) throws UnsupportedEncodingException{
		for(FilesMsgDTO dto : list) {
			String savedname = URLEncoder.encode(dto.getSavedname(), "UTF-8");
			String orinameEncoded = URLEncoder.encode(dto.getOriname(), "UTF-8");
			dto.setSavedname(savedname);
			dto.setOrinameEncoded(orinameEncoded);
		}
		return list;
	}
	//임시저장 업무일지 파일 불러오기
	@Override
	public List<FilesDTO> getLogFilesBySeq(int seq, FilesDTO fdto) {
		return fdao.getLogFilesBySeq(seq,fdto);
	}
	//게시글에 업로드된 파일 갯수 확인
	@Override
	public int getLogUploadFileCount(FilesDTO fdto) {
		return fdao.getLogUploadFileCount(fdto);
	}
		
	/* =============채팅 파일=============== */

	@Override
	public int deleteDocFile(int seq) {
		return fdao.deleteDocFile(seq);
	}

	public List<FilesDTO> getFilesListByDocSeq2(int seq){
		return fdao.getFilesListByDocSeq2(seq);
	}

	@Override
	public int updateFile(int seq,int b_seq) {
		return fdao.updateFile(seq,b_seq);
	}
	
	@Override
	public int insertFile(FilesDTO dto) {
		return fdao.insertFile(dto);
	}
	@Override
	public List<FilesDTO> getEmailFiles(String seq) {
		return fdao.getEmailFiles(seq);
	}
	//임시저장 - 다시 임시저장 부분 파일 업로드
	public int uploadFilesTempSave(int seq, FilesDTO fdto) {
		return fdao.uploadFilesTempSave(seq,fdto);
	}

	
}
