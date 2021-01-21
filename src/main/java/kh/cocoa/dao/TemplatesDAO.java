package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;
import kh.cocoa.dto.TemplatesDTO;

import java.util.List;

@Mapper
public interface TemplatesDAO {
	public List<TemplatesDTO> getTemplateList();
	public List<TemplatesDTO> getSubTemplateList();
}