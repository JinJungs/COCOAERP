package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.NexacroSearchDTO;


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

	//재직중인 전체 멤버 리스트 - 자신제외
	public List<EmployeeDTO> getAllEmployeeExceptMe(int code);
	
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

	public int getEmpCheckPw(int emp_code,String pw);

	public int modInfo(EmployeeDTO dto);

	public int checkUserEmail(int code, String email);

	public int changePw(int code,String password);

	public int isWithdraw(int code);

	public List<Integer> getAllEmpCode();

	public List<EmployeeDTO> getAllMWEmpCode();


	//----------------- 채팅 -----------------//
	// 멤버이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByName(int code, String contents);
	// 부서이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByDeptname(int code, String contents);
	// 팀이름으로 찾기
	public List<EmployeeDTO> searchEmployeeByTeamname(int code, String contents);


	//email로 사번받아오기
	public int isEmailExist(String email);
	//사번으로 bEmail받아오기
	public String getB_Email(String seq);
	

	//-------------소형-----------------//
	//전체 멤버 호출 코드로 정렬
	public List<EmployeeDTO> getAllEmployeeOrderByCode();
	
	public List<EmployeeDTO> searchEmployee(NexacroSearchDTO dto);
	
	public int addEmployee(List<EmployeeDTO> list);
	
	public int addOneEmployee(EmployeeDTO dto);
	
	public int updateEmployee(List<EmployeeDTO> list);
	
	public String getEmpNameByCode(int code);
	
	public int updateWithdraw(List<EmployeeDTO> dto);
	
	//-------------소형 끝---------------//

	//employee와 leave_taken_used 같이 받아오기
	public List<EmployeeDTO> getEmpleLTU();
	public List<EmployeeDTO> getListWithdrawN();

}
