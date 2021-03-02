package kh.cocoa.dao;

import kh.cocoa.dto.AttendanceDTO;
import org.apache.ibatis.annotations.Mapper;

import java.sql.Timestamp;
import java.util.List;

@Mapper
public interface AttendanceDAO {
    public int startWork(int emp_code);
    public int outSideWork(int emp_code);
    public Timestamp checkStart(int emp_code);
    public Timestamp checkEnd(int emp_code);
    public int offWork(int emp_code);
    public List<AttendanceDTO> getAttendanceList(int emp_code);
    public List<AttendanceDTO> getAtdTime(int emp_code);
    public List<AttendanceDTO> getMonthAtdTime(int emp_code);
    public int isAtd(int emp_code);

    public String isInWork(int emp_code);
    public int startWork2(int emp_code,String status);
    public int reRegStartTime(int emp_code);
    public String isOutWork(int emp_code);
    public int endWork(int emp_code,int overtime);
    
}
