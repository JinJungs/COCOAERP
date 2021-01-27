package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.FilesDTO;

@Mapper 
public interface FilesDAO {
	
	//파일
	public int uploadFiles(int noBoard_seq,FilesDTO fdto);
	//Document seq에 따른 파일리스트 가져오기
	public List<FilesDTO> getFilesListByDocSeq(String seq);
}
