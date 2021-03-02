package kh.cocoa.controller;


import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.service.AttendanceService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/restattendance")
public class RestAttendanceController {


    @Autowired
    private AttendanceService attendanceService;

    @RequestMapping("/getAtdTime")
    public String getAtdTime(){
        List<AttendanceDTO> getAtdTime = attendanceService.getAtdTime(1000);
        JSONArray json = new JSONArray(getAtdTime);
        return json.toString();
    }

    @RequestMapping("/isInWork")
    public String isInWork(){
        String isInWork=attendanceService.isInWork(1000);
        return isInWork;
    }

    @RequestMapping("/isOutWork")
    public String isOutWork(){
        String isOutWork=attendanceService.isOutWork(1000);
        String isInWork=attendanceService.isInWork(1000);
        if(isInWork==null){
            return "nyInWork";
        }
        return isOutWork;
    }

    @RequestMapping("/atdIn")
    public String atdIn(String status){
        System.out.println(status);
        if(attendanceService.isInWork(1000)!=null){
            System.out.println("여기넘어오나 ..");
            int updateResult = attendanceService.reRegStartTime(1000);
            if(updateResult>0){
                return "updateSuccess";
            }else{
                return "updateFailed";
            }
        }else{
            SimpleDateFormat frm = new SimpleDateFormat ( "HHMM");
            Date time = new Date();
            String getCurTime = frm.format(time);
            if(Integer.parseInt(getCurTime)>930){
                status="late";
            }else{
                if(status!=null){
                    status="out";
                }else{
                    status="in";
                }
            }
            int insertResult = attendanceService.startWork2(1000,status);
            if(insertResult>0){
                return "insertSuccess";
            }else{
                return "insertFailed";
            }
        }

    }


    @RequestMapping("/atdOut")
    public String atdOut(){
        SimpleDateFormat frm = new SimpleDateFormat ( "HH");
        Date time = new Date();
        String getCurTime = frm.format(time);
        String getStartTime =attendanceService.isInWork(1000);
        int overTime=0;
        if(getStartTime!=null){
            int sub = Integer.parseInt(getCurTime)-Integer.parseInt(getStartTime.replaceAll(":","").substring(0,2))-1;
            System.out.println(sub);
            if(sub>8){
                overTime=sub-8;
            }
        }
        if(attendanceService.isOutWork(1000)!=null){
            int updateResult = attendanceService.endWork(1000,overTime);
            if(updateResult>0){
                return "updateSuccess";
            }else{
                return "updateFailed";
            }
        }else{

            int insertResult = attendanceService.endWork(1000,overTime);
            if(insertResult>0){
                return "insertSuccess";
            }else{
                return "insertFailed";
            }
        }
    }

    @RequestMapping("/getMonthAtdTime")
    public String getMonthAtdTime(){
        List<AttendanceDTO> getAtdTime = attendanceService.getMonthAtdTime(1000);
        JSONArray json = new JSONArray(getAtdTime);
        return json.toString();
    }
}
