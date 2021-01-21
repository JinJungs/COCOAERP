package kh.cocoa.service;

import kh.cocoa.dao.EmployeeDAO;
import kh.cocoa.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EmployeeService implements EmployeeDAO {

    @Autowired
    private EmployeeDAO edao;

    @Override
    public List<EmployeeDTO> getOrganChart() {
        return edao.getOrganChart();
    }
}
