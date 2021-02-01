package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.FilesDTO;

@Mapper 
public interface FilesDAO {
	/*-------------------**회사소식**--------------------------*/
	//파일 업로드
	public int uploadFiles(int noBoard_seq,FilesDTO fdto);

	//게시글에 업로드된 파일 갯수 확인
	public int isExistUploadFile(FilesDTO fdto);

	//파일 다운로드
	public List<FilesDTO> downloadFilesBySeq(int noBoard_seq);

	//첨부파일 목록
	public List<FilesDTO> downloadFileList(FilesDTO dto);
	
	//게시글에 업로드된 첨부파일 리스트 불러오기
	public List<FilesDTO> getFilesBySeq(FilesDTO fdto);

	//파일 삭제
	public int deleteNotificationBoardFiles(int seq);

	/*용국 업로드*/
	public int documentInsertFile(String oriName,String savedName,int doc_seq);

	public List<FilesDTO> getFilesListByDocSeq(String seq);

	/* 채팅 파일 업로드 */
	public int uploadFilesMsg(FilesDTO fdto);

	//용국 파일 삭제
	public int deleteDocFile(int seq);

	public List<FilesDTO> getFilesListByDocSeq2(int seq);

	public int updateFile(int seq,int b_seq);
}
