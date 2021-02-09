package kh.cocoa.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.ScheduleDTO;

@Mapper
public interface ScheduleDAO {
	public void insertSchedule(ScheduleDTO dto, String openTarget);
	
	public List<ScheduleDTO> selectAllSchedule();
	public List<ScheduleDTO> selectCompanySchedule();
	public List<ScheduleDTO> selectDeptSchedule(String dept);
	public List<ScheduleDTO> selectTeamSchedule(String team);
	public List<ScheduleDTO> selectPersonalSchedule(String personal);
}
