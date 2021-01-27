package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.FilesDTO;

@Service
public class FilesService implements FilesDAO {
	@Autowired
	private FilesDAO fdao;
	
	@Override
	public int uploadFiles(int noBoard_seq, FilesDTO fdto) {
		return fdao.uploadFiles(noBoard_seq,fdto);
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
