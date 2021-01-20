package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	public List<DocumentDTO> getTempList();
	
}
