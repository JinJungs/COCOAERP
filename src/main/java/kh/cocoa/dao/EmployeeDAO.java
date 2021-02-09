package kh.cocoa.dao;

import kh.cocoa.dto.EmployeeDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EmployeeDAO {

	//----------------- 로그인 -----------------//
	public String login(int code, String password);
	public EmployeeDTO loginInfo(int code);
	public int myInfoModify(String password, String gender, String phone, String address, String office_phone, int code);
	public List<EmployeeDTO> findIdByEmail(String email);
	public String findPwByEmail(String email, int code);
	public int updateTempPw(String password, int code);

	//전체 멤버 호출
	public List<EmployeeDTO> getAllEmployee();
	
	//사용자와 같은 부서멤버 호출 + 재직 중
	public List<EmployeeDTO> getDeptMember(@Param("dept_code") int dept_code);
	
	//사용자와 같은 팀 멤버 호출 + 재직 중
	public List<EmployeeDTO> getTeamMember(@Param("team_code") int team_code);

	//용국

	//조직도 뽑아오는 메서드
	public List<EmployeeDTO> getOrganChart();

	//결재에서 선택한 사람 정보 뽑아오는 메서드 + POS도 봅아오기
	public List<EmployeeDTO> getConfirmEmp(int code);

	//팀코드로 pos꺼내기
	public List<EmployeeDTO> getEmpPos(int code);

	//dto로 받아오기
	public EmployeeDTO getEmpInfo(int code);

	public List<EmployeeDTO> getTeamEmp(int team_code);
	
	/*-------------지영-BugReport-----------*/
	public EmployeeDTO getSenderEmail(int writer_code);

	//팀별 맴버수 뽑아오기
	public int getTeamCount(int team_code);

	//팀별 멤버 정보 뽑아오기
	public List<EmployeeDTO> getTeamEmpList(int team_code);

	//이름 직원명 검색기능
	public List<EmployeeDTO> getEmpNameSearchList(String name);

	//
	public List<EmployeeDTO> getDeptNameSearchList(String name);

	//부서 코드에 속한 모든 emp 정보
	public List<EmployeeDTO> getDeptEmpList(int dept_code);

	//pos_code 순서로 리스트 겟
	public List<EmployeeDTO> getAllEmpListOrderByPos();

	//모든 멤버 카운트 겟
	public int getAllEmpCount();

	public List<EmployeeDTO> getSearchEmpCode(String name);


	//----------------- 채팅 -----------------//
	// 멤버이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByName(String contents);
	// 부서이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByDeptname(String contents);
	// 팀이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByTeamname(String contents);


	//email로 사번받아오기
	public int isEmailExist(String email);

}
