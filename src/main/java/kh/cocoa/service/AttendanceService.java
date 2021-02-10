package kh.cocoa.service;

import kh.cocoa.dao.AttendanceDAO;
import kh.cocoa.dto.AttendanceDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class AttendanceService implements AttendanceDAO {
    @Autowired
    private AttendanceDAO attenDAO;

    @Override
    public int startWork(int emp_code) { return attenDAO.startWork(emp_code); }

    @Override
    public Timestamp checkStart(int emp_code) { return attenDAO.checkStart(emp_code); }

    @Override
    public Timestamp checkEnd(int emp_code) { return attenDAO.checkEnd(emp_code); }

    @Override
    public int outSideWork(int emp_code) { return attenDAO.outSideWork(emp_code); }

    @Override
    public int offWork(int emp_code) { return attenDAO.offWork(emp_code); }

    @Override
    public List<AttendanceDTO> getAttendanceList(int emp_code) { return attenDAO.getAttendanceList(emp_code); }
}
