package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.LeaveDAO;
import kh.cocoa.dto.LeaveDTO;

@Service
public class LeaveService implements LeaveDAO{
	
	@Autowired
	private LeaveDAO dao;
	
	@Override
	public List<LeaveDTO> getLeavelist(int empCode, String yearStart, String yearEnd) {
		return dao.getLeavelist(empCode, yearStart, yearEnd);
	}
	
	@Override
	public void insert(LeaveDTO dto) {
		dao.insert(dto);		
	}
	@Override
	public int getDuration(int empCode, String startDate, String endDate) {
		return dao.getDuration(empCode, startDate, endDate);
	}
	@Override
	public int getTimeSum(int empCode, String startDate, String endDate) {
		return dao.getTimeSum(empCode, startDate, endDate);
	}
}
