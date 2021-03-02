package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.LeaveDTO;


@Mapper
public interface LeaveDAO {
	public List<LeaveDTO> getLeavelist(int empCode, String yearStart, String yearEnd);
	
	public void insert(LeaveDTO dto);
	public int getDuration(int empCode, String startDate, String endDate);
	public int getTimeSum(int empCode, String startDate, String endDate);
}
