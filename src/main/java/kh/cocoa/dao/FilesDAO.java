package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.FilesDTO;

@Mapper 
public interface FilesDAO {
	
	//파일
	public int uploadFiles(int noBoard_seq,FilesDTO fdto);

	/*용국 업로드*/
	public int documentInsertFile(String oriName,String savedName,int doc_seq);
}
