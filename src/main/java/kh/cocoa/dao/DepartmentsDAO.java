package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.DepartmentsDTO;

@Mapper
public interface DepartmentsDAO {

    public String getDeptName();

    public DepartmentsDTO getDeptNameByCode(int code);

    public List<DepartmentsDTO> getDeptList();

    public DepartmentsDTO getDept();

    public DepartmentsDTO getSearchTopDept(String name);

    public List<DepartmentsDTO> getSearchDeptCode(String name);
    

    /* ====소형=== 관리자 - 사용자관리*/
    public List<DepartmentsDTO> getDeptListOrderByCode();
    
    public List<DepartmentsDTO> getDeptListWithout0();

    public List<DepartmentsDTO> getDeptListForFilter();
    
    public int addDept(List<DepartmentsDTO> dto);
    
    public int updateDept(List<DepartmentsDTO> dto);
    
    public int deleteDept(List<DepartmentsDTO> dto);

}
