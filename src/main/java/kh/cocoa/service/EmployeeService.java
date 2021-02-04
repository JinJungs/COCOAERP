package kh.cocoa.service;

import kh.cocoa.dao.EmployeeDAO;
import kh.cocoa.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService implements EmployeeDAO {
	@Autowired
	private EmployeeDAO edao;

	//----------------- 로그인 -----------------//
	@Override
	public String login(int code, String password) { return edao.login(code, password); }

	@Override
	public EmployeeDTO loginInfo(int code) { return edao.loginInfo(code); }

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

	//용국 메서드
	@Override
	public List<EmployeeDTO> getOrganChart() {
		return edao.getOrganChart();
	}

	//선택자 뽑아오는 서비스

	@Override
	public List<EmployeeDTO> getConfirmEmp(int code) {
		return edao.getConfirmEmp(code);
	}

	//팀코드로 직책꺼내오기
	@Override
	public List<EmployeeDTO> getEmpPos(int code) {return edao.getEmpPos(code); }

	@Override
	public EmployeeDTO getEmpInfo(int code) {
		return edao.getEmpInfo(code);
	}
	/*-------------지영-BugReport-----------*/
	public EmployeeDTO getSenderEmail(int writer_code) {
		System.out.println("서비스에서 wc는?" +writer_code);
		return edao.getSenderEmail(writer_code);
	}
}

