package kh.cocoa.dao;

import java.util.List;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DocumentDTO;

@Mapper
public interface DocumentDAO {
	public List<DocumentDTO> getTempList();

}
