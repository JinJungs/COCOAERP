package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.Leave_Taken_UsedDAO;
import kh.cocoa.dto.Leave_Taken_UsedDTO;


@Service
public class Leave_Taken_UsedService implements Leave_Taken_UsedDAO{
	
	@Autowired
	private Leave_Taken_UsedDAO ldao;
	
	@Override
	public Leave_Taken_UsedDTO getLeaveStatus(int empCode, String year) {
		return ldao.getLeaveStatus(empCode, year);
		
	}
	@Override
	public void updateUsed(int used, String year, int empCode) {
		ldao.updateUsed(used, year, empCode);
	}
	
	@Override
	public int isExist(int empCode, int year) {
		return ldao.isExist(empCode, year);
	}
	@Override
	public void insert(int year, int empCode, int leaveCount) {
		ldao.insert(year, empCode, leaveCount);
	}
}
