package kh.cocoa.dao;


import kh.cocoa.dto.TemplateFormDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TemplateFormDAO {

    public List<TemplateFormDTO> getTempleateFormList();

    public int delTemplateForm(int code);

    public int addTemplateForm(TemplateFormDTO dto);

    public int modTemlateForm(TemplateFormDTO dto);

    public TemplateFormDTO getFormInfoByCode(int code);
}
