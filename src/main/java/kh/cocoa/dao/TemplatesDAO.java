package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;
import kh.cocoa.dto.TemplatesDTO;

import java.util.List;

@Mapper
public interface TemplatesDAO {
	//용국
	//기본 템플릿 리스트
	public List<TemplatesDTO> getTemplateList();

	//만든 템플릿 리스트
	public List<TemplatesDTO> getSubTemplateList();

	//업무보고 제외.
	public List<TemplatesDTO> getTemplateList2();

	//해당 템플릿 폼에 위치한 요소들만
	public List<TemplatesDTO> getClickTemplateList(int code);

	public int addTemplates(TemplatesDTO dto);

}
