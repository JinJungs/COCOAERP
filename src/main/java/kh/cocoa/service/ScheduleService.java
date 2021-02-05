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
}
