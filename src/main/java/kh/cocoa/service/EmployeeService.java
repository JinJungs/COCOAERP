package kh.cocoa.service;

import kh.cocoa.dao.EmployeeDAO;
import kh.cocoa.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

	@Override
	public String findIdByEmail(String email) { return edao.findIdByEmail(email); }

	@Override
	public String findPwByEmail(String email, int code) { return edao.findPwByEmail(email, code); }

	@Override
	public int updateTempPw(String password, int code) {
		if(password != null){
			pwEncoder = new BCryptPasswordEncoder();
			password = pwEncoder.encode(password);
		}
		return edao.updateTempPw(password, code);
	}

	public static String getRandomStr(int size) {
		if(size > 0) {
			char[] temp = new char[size];
			for(int i = 0; i < temp.length; i++) {
				int div = (int)Math.floor(Math.random() * 2);

				if(div == 0) {	// 0일때 숫자
					temp[i] = (char)(Math.random() * 10 + '0');
				}else {	// 1일때 알파벳
					temp[i] = (char)(Math.random() * 26 + 'A');
				}
			}
			return new String(temp);
		}
		return new String("Error");
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
	}

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

	@Override
	public List<EmployeeDTO> getTeamEmp(int team_code) {
		return edao.getTeamEmp(team_code);
	}

	@Override
	public List<EmployeeDTO> getSearchEmpCode(String name) {
		return edao.getSearchEmpCode(name);
	}

	//----------------- 채팅 -----------------//
	// 멤버이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByName(int code, String contents){
		return edao.searchEmployeeByName(code, contents);
	}
	// 부서이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByDeptname(int code, String contents){
		return edao.searchEmployeeByDeptname(code, contents);
	}
	//팀이름으로 찾기
	@Override
	public List<EmployeeDTO> searchEmployeeByTeamname(int code, String contents){
		return edao.searchEmployeeByTeamname(code, contents);
	}

	@Override
	public int isEmailExist(String email) {
		return edao.isEmailExist(email);
	}
	/*-------------지영-BugReport-----------*/
	public EmployeeDTO getSenderEmail(int writer_code) {
		System.out.println("서비스에서 wc는?" +writer_code);
		return edao.getSenderEmail(writer_code);
	}
}

