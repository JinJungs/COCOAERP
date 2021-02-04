package kh.cocoa.service;

import kh.cocoa.dao.EmployeeDAO;
import kh.cocoa.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService implements EmployeeDAO {
	@Autowired
	private EmployeeDAO edao;
	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	//----------------- 로그인 -----------------//
	@Override
	public String login(int code, String password) {

		//return edao.login(code, password);

		String result =  edao.login(code, password);
		System.out.println(result);
		if(pwEncoder.matches(password, result)) {
			return "T";
		} else {
			return "F";
		}
	}

	@Override
	public EmployeeDTO loginInfo(int code) { return edao.loginInfo(code); }

	@Override
	public int myInfoModify(String password, String gender, String phone, String address, String office_phone, int code){
		if(password != null){
			pwEncoder = new BCryptPasswordEncoder();
			password = pwEncoder.encode(password);
		}
		return edao.myInfoModify(password, gender, phone, address, office_phone, code);
	}

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
	public EmployeeDTO getEmpInfo(int code) {return edao.getEmpInfo(code); }

	@Override
	public int getTeamCount(int team_code) {
		return edao.getTeamCount(team_code);
	}

	@Override
	public List<EmployeeDTO> getTeamEmpList(int team_code) {
		return edao.getTeamEmpList(team_code);
	}

	@Override
	public List<EmployeeDTO> getEmpNameSearchList(String name) {
		return edao.getEmpNameSearchList(name);
	}

	@Override
	public List<EmployeeDTO> getDeptNameSearchList(String name) {
		return edao.getDeptNameSearchList(name);
	}

	@Override
	public List<EmployeeDTO> getDeptEmpList(int dept_code) {
		return edao.getDeptEmpList(dept_code);
	}

	@Override
	public List<EmployeeDTO> getAllEmpListOrderByPos() {
		return edao.getAllEmpListOrderByPos();
	}

	@Override
	public int getAllEmpCount() {
		return edao.getAllEmpCount();
	}

	//----------------- 채팅 -----------------//
	// 멤버이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByName(String contents){
		return edao.searchEmployeeByName(contents);
	}
	// 부서이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByDeptname(String contents){
		return edao.searchEmployeeByDeptname(contents);
	}
	//팀이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByDeptTeamname(String contents){
		return edao.searchEmployeeByDeptname(contents);
	}

	@Override
	public int isEmailExist(String email) {
		return edao.isEmailExist(email);
	}
	
	
}

