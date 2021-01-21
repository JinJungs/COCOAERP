package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.FilesDTO;

@Service
public class FilesService {
	@Autowired
	private FilesDAO fdao;
	
	//파일
	public int insertFile( FilesDTO dto) {
		return fdao.insertFile( dto);
	}
}
