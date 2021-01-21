package kh.cocoa.service;

import kh.cocoa.dao.DepartmentsDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DepartmentsService implements DepartmentsDAO {

    @Autowired
    private DepartmentsDAO ddao;

    @Override
    public String getDeptName() {
        return ddao.getDeptName();
    }
}
