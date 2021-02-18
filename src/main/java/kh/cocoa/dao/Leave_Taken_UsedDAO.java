package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.Leave_Taken_UsedDTO;

@Mapper
public interface Leave_Taken_UsedDAO {
	public Leave_Taken_UsedDTO getLeaveStatus(int empCode, String year);
	
	public void updateUsed(int used, String year, int empCode);
	
	public int isExist(int empCode, int year);
	public void insert(int year, int empCode, int leaveCount);
}
