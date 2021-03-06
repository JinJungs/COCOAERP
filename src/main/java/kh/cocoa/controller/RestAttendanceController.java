package kh.cocoa.controller;


import com.sun.org.apache.bcel.internal.generic.RETURN;
import kh.cocoa.dto.AtdChangeReqDTO;
import kh.cocoa.dto.AttendanceDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.AttendanceService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/restattendance")
public class RestAttendanceController {


    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private HttpSession session;

    @RequestMapping("/getAtdTime")
    public String getAtdTime(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> getAtdTime = attendanceService.getAtdTime(loginSession.getCode());
        JSONArray json = new JSONArray(getAtdTime);
        return json.toString();
    }

    @RequestMapping("/isInWork")
    public String isInWork(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        String isInWork=attendanceService.isInWork(loginSession.getCode());
        return isInWork;
    }

    @RequestMapping("/isOutWork")
    public String isOutWork(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        String isOutWork=attendanceService.isOutWork(loginSession.getCode());
        String isInWork=attendanceService.isInWork(loginSession.getCode());
        if(isInWork==null){
            return "nyInWork";
        }
        return isOutWork;
    }

    @RequestMapping("/atdIn")
    public String atdIn(String status){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        if(attendanceService.isInWork(loginSession.getCode())!=null){
            int updateResult = attendanceService.reRegStartTime(loginSession.getCode());
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
            int insertResult = attendanceService.startWork2(loginSession.getCode(),status);
            if(insertResult>0){
                return "insertSuccess";
            }else{
                return "insertFailed";
            }
        }

    }


    @RequestMapping("/atdOut")
    public String atdOut(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        SimpleDateFormat frm = new SimpleDateFormat ( "HH");
        Date time = new Date();
        String getCurTime = frm.format(time);
        String getStartTime =attendanceService.isInWork(loginSession.getCode());
        int overTime=0;
        if(getStartTime!=null){
            int sub = Integer.parseInt(getCurTime)-Integer.parseInt(getStartTime.replaceAll(":","").substring(0,2))-1;
            if(sub>8){
                overTime=sub-8;
            }
        }
        if(attendanceService.isOutWork(loginSession.getCode())!=null){
            int updateResult = attendanceService.endWork(loginSession.getCode(),overTime);
            if(updateResult>0){
                return "updateSuccess";
            }else{
                return "updateFailed";
            }
        }else{

            int insertResult = attendanceService.endWork(loginSession.getCode(),overTime);
            if(insertResult>0){
                return "insertSuccess";
            }else{
                return "insertFailed";
            }
        }
    }

    @RequestMapping("/getMonthAtdTime")
    public String getMonthAtdTime(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> getAtdTime = attendanceService.getMonthAtdTime(loginSession.getCode());
        JSONArray json = new JSONArray(getAtdTime);
        return json.toString();
    }

    @RequestMapping("/getReqInfo")
    public String getReqInfo(int atd_seq){
        AtdChangeReqDTO isReq =attendanceService.isReq(atd_seq);
        if(isReq!=null){
            JSONObject json = new JSONObject(isReq);
            return json.toString();
        }
        return "false";
    }

    @RequestMapping("/getAtdList")
    public String getAtdList(String number){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        List<AttendanceDTO> atdList = attendanceService.getAttendanceList2(loginSession.getCode(),number);
        JSONArray json = new JSONArray(atdList);
        return json.toString();
    }

    @RequestMapping("/search")
    public String search(String number,
                         String search,
                         String start_time,
                         String end_time){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        int parse_end_time = Integer.parseInt(end_time.replaceAll("-",""));
        parse_end_time++;
        List<AttendanceDTO> getSearchAtd = attendanceService.getSearchAtd(loginSession.getCode(),number,search,start_time,parse_end_time);
        JSONArray json = new JSONArray(getSearchAtd);
        return json.toString();
    }

    @RequestMapping("/changeReq")
    public String changeReq(AtdChangeReqDTO dto){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        dto.setEmp_code(loginSession.getCode());
        int addChangeReq=attendanceService.addChangeReq(dto);
        if(addChangeReq>0){
            return "successInsert";
        }else{
            return "failedInsert";
        }

    }

    @RequestMapping("/delChangeReq")
    public String delChangeReq(int atd_seq){
        int delChangeReq=attendanceService.delChangeReq(atd_seq);
        if(delChangeReq>0){
            return "successDelete";
        }else{
            return "failedDelete";
        }
    }

    @RequestMapping("/modChangeReq")
    public String modChangeReq(AtdChangeReqDTO dto){
        int modChangeReq=attendanceService.modChangeReq(dto);
        if(modChangeReq>0){
            return "successUpdate";
        }else{
            return "failedUpdate";
        }
    }

    @RequestMapping("/getIsReqInfo")
    public String getIsReqInfo(int atd_seq){
        AtdChangeReqDTO getIsReqInfo=attendanceService.getIsReqInfo(atd_seq);
        JSONObject json = new JSONObject(getIsReqInfo);
        return json.toString();
    }

    @RequestMapping("/reChangeReq")
    public String reChangeReq(AtdChangeReqDTO dto){
        int reChangeReq=attendanceService.reChangeReq(dto);
        if(reChangeReq>0){
            return "successUpdate";
        }else{
            return "FailedUpdate";
        }
    }

    @RequestMapping("/getIsWork")
    public String getIsWork(){
        EmployeeDTO loginSession = (EmployeeDTO)session.getAttribute("loginDTO");
        AttendanceDTO isAtd =attendanceService.isAtd(loginSession.getCode());
        if(isAtd!=null){
            JSONObject json = new JSONObject(isAtd);
            return json.toString();
        }
        return "nw";

    }


}
