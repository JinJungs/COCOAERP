package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.ScheduleDAO;
import kh.cocoa.dto.ScheduleDTO;

@Service
public class ScheduleService implements ScheduleDAO{
	
	@Autowired
	private ScheduleDAO sdao;
	
	@Override
	public void insertSchedule(ScheduleDTO dto, String openTarget) {
		sdao.insertSchedule(dto, openTarget);	
	}
	
	@Override
	public List<ScheduleDTO> selectAllSchedule() {
		return sdao.selectAllSchedule();
	}
	@Override
	public List<ScheduleDTO> selectCompanySchedule() {
		return sdao.selectCompanySchedule();
	}
	@Override
	public List<ScheduleDTO> selectDeptSchedule(String dept) {
		return sdao.selectDeptSchedule(dept);
	}
	@Override
	public List<ScheduleDTO> selectTeamSchedule(String team) {
		return sdao.selectTeamSchedule(team);
	}
	@Override
	public List<ScheduleDTO> selectPersonalSchedule(String personal) {
		return sdao.selectPersonalSchedule(personal);
	}
	
	@Override
	public ScheduleDTO getSchedule(String seq) {
		return sdao.getSchedule(seq);
	}
	@Override
	public void update(ScheduleDTO dto) {
		sdao.update(dto);
	}
	@Override
	public int delete(String seq) {
		return sdao.delete(seq);
	}
	
	@Override
	public List<ScheduleDTO> selectTodaySchedule(String date1, String date2) {
		return sdao.selectTodaySchedule(date1, date2);
	}

	@Override
	public List<ScheduleDTO> selectListNex() {
		return sdao.selectListNex();
	}

	@Override
	public List<ScheduleDTO> selectListByDateNex(String str_start, String str_end) {
		return sdao.selectListByDateNex(str_start, str_end);
	}

	@Override
	public void insertScheduleNex(String title, String contents, String start_time, String end_time,String color, String writer) {
		sdao.insertScheduleNex(title, contents, start_time, end_time, color, writer);
	}

	@Override
	public int deleteScheduleNex(List<ScheduleDTO> list) {
		return sdao.deleteScheduleNex(list);
	}

	@Override
	public int updateScheduleNex(ScheduleDTO dto) {
		return sdao.updateScheduleNex(dto);
	}
}
