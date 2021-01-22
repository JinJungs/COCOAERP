package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.FilesDTO;

@Service
public class FilesService {
	@Autowired
	private FilesDAO fdao;
	
	//파일 업로드
	public int uploadFiles(int noBoard_seq, FilesDTO fdto) { 
		return fdao.uploadFiles(noBoard_seq,fdto); 
	}
	 
}
