package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.LeaveDTO;


@Mapper
public interface LeaveDAO {
	public List<LeaveDTO> getLeavelist(int empCode, String yearStart, String yearEnd);
}
