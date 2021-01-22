package kh.cocoa.dao;

import kh.cocoa.dto.DepartmentsDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DepartmentsDAO {

    public String getDeptName();

    public List<DepartmentsDTO> getDeptList();
}
