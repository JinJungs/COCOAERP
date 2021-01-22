package kh.cocoa.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kh.cocoa.dto.EmployeeDTO;

@Mapper
public interface EmployeeDAO {
	//전체 멤버 호출
	public List<EmployeeDTO> getAllEmployee();
	
	//사용자와 같은 부서멤버 호출 + 재직 중
	public List<EmployeeDTO> getDeptMember(@Param("dept_code") int dept_code);
	
	//사용자와 같은 팀 멤버 호출 + 재직 중
	public List<EmployeeDTO> getTeamMember(@Param("team_code") int team_code);

	//용국

	//조직도 뽑아오는 메서드
	public List<EmployeeDTO> getOrganChart();

	//결재에서 선택한 사람 정보 뽑아오는 메서드
	public List<EmployeeDTO> getConfirmEmp(int code);


}
