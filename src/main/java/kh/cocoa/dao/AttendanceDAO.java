package kh.cocoa.dao;

import kh.cocoa.dto.AtdChangeReqDTO;
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
    public AttendanceDTO isAtd(int emp_code);

    public String isInWork(int emp_code);
    public int startWork2(int emp_code,String status);
    public int reRegStartTime(int emp_code);
    public String isOutWork(int emp_code);
    public int endWork(int emp_code,int overtime);

    public AtdChangeReqDTO isReq(int atd_seq);
    public List<AttendanceDTO> getAttendanceList2(int emp_code,String number);
    public List<AttendanceDTO> getSearchAtd(int emp_code, String number, String search, String start_time,int end_time);

    String countStatusLate(int emp_code);

    String countStatusWork(int emp_code);

    int countWorkHour(int emp_code);

    int countWorkMin(int emp_code);

    List<AtdChangeReqDTO> getAtdReqListToMain(int emp_code);

    List<AttendanceDTO> getAtdInfoBySeq(int seq);

    int addChangeReq(AtdChangeReqDTO dto);

    int delChangeReq(int atd_seq);

    int modChangeReq(AtdChangeReqDTO dto);

    List<AtdChangeReqDTO> getReqListToNex();

    int saveAtdReq(AtdChangeReqDTO dto);

    AtdChangeReqDTO getIsReqInfo(int atd_seq);

    int reChangeReq(AtdChangeReqDTO dto);

    int modAtdTime(AtdChangeReqDTO dto);

    int toDayUpdateAtd(int emp_code);

    int updateMWEmpAtd(int seq);
}
