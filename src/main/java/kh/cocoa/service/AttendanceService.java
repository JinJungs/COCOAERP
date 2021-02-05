package kh.cocoa.service;

import kh.cocoa.dao.AttendanceDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService implements AttendanceDAO {
    @Autowired
    private AttendanceDAO attenDAO;

    @Override
    public int startWork(int emp_code) { return attenDAO.startWork(emp_code); }
}
