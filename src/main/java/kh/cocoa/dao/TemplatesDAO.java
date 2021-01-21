package kh.cocoa.dao;

import kh.cocoa.dto.TemplatesDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TemplatesDAO {

    public List<TemplatesDTO> getTemplateList();
    public List<TemplatesDTO> getSubTemplateList();

}
