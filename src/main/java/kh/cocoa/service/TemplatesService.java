package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.TemplatesDAO;
import kh.cocoa.dto.TemplatesDTO;

@Service
public class TemplatesService implements TemplatesDAO{
	
	@Autowired
	private TemplatesDAO tdao;
	
	@Override
	public List<TemplatesDTO> getTemplateList() {
		return tdao.getTemplateList();
	}
	
	@Override
	public List<TemplatesDTO> getSubTemplateList() {
		return tdao.getSubTemplateList();
	}

	@Override
	public List<TemplatesDTO> getTemplateList2() {
		return tdao.getTemplateList2();
	}

	@Override
	public List<TemplatesDTO> getClickTemplateList(int code) {
		return tdao.getClickTemplateList(code);
	}

	@Override
	public int addTemplates(TemplatesDTO dto) {
		return tdao.addTemplates(dto);
	}
}
