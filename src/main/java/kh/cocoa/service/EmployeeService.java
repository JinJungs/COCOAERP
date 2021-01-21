package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.EmployeeDAO;
import kh.cocoa.dto.EmployeeDTO;

@Service
public class EmployeeService implements EmployeeDAO {
	@Autowired
	EmployeeDAO edao;
	//전체 멤버 호출
	@Override
	public List<EmployeeDTO> getAllEmployee(){
		return edao.getAllEmployee();
	}
	//사용자와 같은 부서멤버 호출
	@Override
	public List<EmployeeDTO> getDeptMember(int dept_code) {
		return edao.getDeptMember(dept_code);
	}
	//사용자와 같은 팀 멤버 호출
	@Override
	public List<EmployeeDTO> getTeamMember(int team_code) {
		return edao.getTeamMember(team_code);
	};
	@Override
	public List<EmployeeDTO> getOrganChart() {
		return edao.getOrganChart();
	}
}

