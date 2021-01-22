package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.FilesDTO;

@Mapper 
public interface FilesDAO {
	
	//파일
	public int uploadFiles(int noBoard_seq,FilesDTO fdto);
}
