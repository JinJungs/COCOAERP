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

	@Override
	public int modTemplates(TemplatesDTO dto) {
		return tdao.modTemplates(dto);
	}

	@Override
	public int delTemplate(int code) {
		return tdao.delTemplate(code);
	}

	@Override
	public List<TemplatesDTO> searchList(String getSearch, int form_code) {
		return tdao.searchList(getSearch,form_code);
	}

	@Override
	public List<TemplatesDTO> getTemplateListbyFormCode(int form_code) {
		return tdao.getTemplateListbyFormCode(form_code);
	}

	@Override
	public TemplatesDTO getTemplateInfo(int code) {
		return tdao.getTemplateInfo(code);
	}

	@Override
	public int getTempCode(int code) {
		return tdao.getTempCode(code);
	}

	@Override
	public int getTemplateCount(int form_code) {
		return tdao.getTemplateCount(form_code);
	}

	@Override
	public List<TemplatesDTO> getTemplateList3() {
		return tdao.getTemplateList3();
	}
}
