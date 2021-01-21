package kh.cocoa.service;

import kh.cocoa.dao.TemplatesDAO;
import kh.cocoa.dto.TemplatesDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TemplateService implements TemplatesDAO{

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
}
