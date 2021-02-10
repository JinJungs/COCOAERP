package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.FilesMsgDTO;

@Mapper 
public interface FilesDAO {



	//파일 업로드
	public int uploadFiles(int noBoard_seq,FilesDTO fdto);

	//업무일지용 파일 업로드
	public int uploadFilesBusinessLog(int logDoc_seq, FilesDTO fdto);

	//게시글에 업로드된 파일 갯수 확인
	public int isExistUploadFile(FilesDTO fdto);
	
	//앨범게시판에서 게시글 사진 불러오기
	public FilesDTO getImage(FilesDTO fdto);

	//파일 다운로드
	public List<FilesDTO> downloadFilesBySeq(int noBoard_seq);

	//첨부파일 목록
	public List<FilesDTO> downloadFileList(FilesDTO dto);
	
	//게시글에 업로드된 첨부파일 리스트 불러오기
	public List<FilesDTO> getFilesBySeq(FilesDTO fdto);

	//파일 삭제
	public int deleteNotificationBoardFiles(int seq);
	
	//임시보관 문서에 첨부된 파일 삭제
	public int logFileDel(int seq);

	/*용국 업로드*/
	public int documentInsertFile(String oriName,String savedName,int doc_seq);

	public List<FilesDTO> getFilesListByDocSeq(String seq);

	//프로필 변경
	public int insertProfile(String oriname,String savedname,int emp_code);

	public FilesDTO findBeforeProfile(int emp_code);

	public int modProfile(String oriname,String savedname,int emp_code);

	/*======***채팅***=====*/
	/*=====채팅 파일 업로드=====*/
	public int uploadFilesMsg(FilesDTO fdto);
	
	public int updateMsgSeq(int msg_seq, String savedName);
	
	public String getSavedName(int msg_seq);
	/*=====채팅 파일 모아보기=====*/
	public List<FilesMsgDTO> showFileMsg(int m_seq);
	/*======***채팅***=====*/

	//용국 파일 삭제
	public int deleteDocFile(int seq);

	public List<FilesDTO> getFilesListByDocSeq2(int seq);

	public int updateFile(int seq,int b_seq);
	
	//임시저장 업무일지 파일 불러오기
	public List<FilesDTO> getLogFilesBySeq(int seq, FilesDTO fdto);
	
	//게시글에 업로드된 파일 갯수 확인
	public int getLogUploadFileCount(FilesDTO fdto);

	//임시저장 - 다시 임시저장 부분 파일 업로드
	public int uploadFilesTempSave(int seq, FilesDTO fdto);
	
	//이메일 파일저장
	public int insertFile(FilesDTO dto);
	//이메일 파일 리스트
	public List<FilesDTO> getEmailFiles(String seq);
}
