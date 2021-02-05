package kh.cocoa.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendanceDAO {
    public int startWork(int emp_code);
}
