package kh.cocoa.service;

import kh.cocoa.dao.DepartmentsDAO;
import kh.cocoa.dto.DepartmentsDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentsService implements DepartmentsDAO {

    @Autowired
    private DepartmentsDAO ddao;

    @Override
    public String getDeptName() {
        return ddao.getDeptName();
    }

    @Override
    public DepartmentsDTO getDeptNameByCode(int code) {
        return ddao.getDeptNameByCode(code);
    }

    @Override
    public List<DepartmentsDTO> getDeptList() {
        return ddao.getDeptList();
    }

    @Override
    public DepartmentsDTO getDept() {
        return ddao.getDept();
    }

    @Override
    public DepartmentsDTO getSearchTopDept(String name) {
        return ddao.getSearchTopDept(name);
    }

    @Override
    public List<DepartmentsDTO> getSearchDeptCode(String name) {
        return ddao.getSearchDeptCode(name);
    }
    
    /* ====소형=== 관리자 - 사용자관리*/
    @Override
    public List<DepartmentsDTO> getDeptListOrderByCode(){
    	return ddao.getDeptListOrderByCode();
    };
    
    @Override
    public List<DepartmentsDTO> getDeptListForFilter() {
    	return ddao.getDeptListForFilter();
    }
}
