package kh.cocoa.dao;

import kh.cocoa.dto.EmployeeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmployeeDAO {

    public List<EmployeeDTO> getOrganChart();
}
