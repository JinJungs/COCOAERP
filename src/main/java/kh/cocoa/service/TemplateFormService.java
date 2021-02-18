package kh.cocoa.service;

import kh.cocoa.dao.TemplateFormDAO;
import kh.cocoa.dto.TemplateFormDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TemplateFormService implements TemplateFormDAO {

    @Autowired
    private TemplateFormDAO dao;

    @Override
    public List<TemplateFormDTO> getTempleateFormList() {
        return dao.getTempleateFormList();
    }

    @Override
    public int delTemplateForm(int code) {
        return dao.delTemplateForm(code);
    }

    @Override
    public int addTemplateForm(TemplateFormDTO dto) {
        return dao.addTemplateForm(dto);
    }

    @Override
    public int modTemlateForm(TemplateFormDTO dto) {
        return dao.modTemlateForm(dto);
    }
}
