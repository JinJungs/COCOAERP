package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.FilesDTO;

@Mapper 
public interface FilesDAO {
	
	//파일
	int insertFile( FilesDTO dto);
}
