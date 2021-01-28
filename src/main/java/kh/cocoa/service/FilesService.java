package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.FilesDTO;

@Service
public class FilesService implements FilesDAO {
	@Autowired
	private FilesDAO fdao;
	/*-------------------**회사소식**--------------------------*/
	//파일 업로드
	public int uploadFiles(int noBoard_seq, FilesDTO fdto) { 
		return fdao.uploadFiles(noBoard_seq,fdto); 
	}
	//파일 불러오기
	public List<FilesDTO> downloadFilesBySeq(int noBoard_seq){
		return fdao.downloadFilesBySeq(noBoard_seq);
	}
	//첨부파일 목록
	public List<FilesDTO> downloadFileList(FilesDTO dto) {
		return fdao.downloadFileList(dto);
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

	/*용국 업로드*/

	@Override
	public int documentInsertFile(String oriName,String savedName,int doc_seq) {

		return fdao.documentInsertFile(oriName,savedName,doc_seq);
	}
	//DocumentSeq에 따른 파일리스트
	public List<FilesDTO> getFilesListByDocSeq(String seq){
		return fdao.getFilesListByDocSeq(seq);
	}
}
