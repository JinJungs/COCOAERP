package kh.cocoa.controller;

import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.LeaveDTO;
import kh.cocoa.service.DocumentService;
import kh.cocoa.service.LeaveService;
import kh.cocoa.service.Leave_Taken_UsedService;


@Controller
@RequestMapping("/leaveN")
public class NexacroLeaveController {
	
	@Autowired
	private LeaveService lservice;
	@Autowired
	private DocumentService dservice;
	@Autowired
	private Leave_Taken_UsedService ltuService;
	
	@RequestMapping("insert.leaveN")
	public NexacroResult insert(@ParamVariable(name="seq")int seq,
			@ParamVariable(name="type")String type, @ParamVariable(name="startDate")String startDate1,
			@ParamVariable(name="endDate")String endDate1, @ParamVariable(name="time")int time,
			@ParamVariable(name="empCode")int empCode, @ParamVariable(name="check")boolean check) throws Exception{
		NexacroResult nr = new NexacroResult();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        java.sql.Date startDate = new java.sql.Date(format.parse(startDate1).getTime());
        java.sql.Date endDate;
        if(!endDate1.contentEquals("undefined")) {	//endDate없을 때 null 삽입
        	endDate = new java.sql.Date(format.parse(endDate1).getTime());
        }else {
        	endDate = null;
        }
        
		//기타 차감-미차감 여부에 따라서 type 입력(조퇴가 아닐때에만)
        if(!type.contentEquals("조퇴")) {
			if(check) {
				type = "기타(차감)";
			}else {
				type = "기타(미차감)";
			}
        }
		LeaveDTO dto = new LeaveDTO(0, type, startDate, endDate, time, empCode);
		lservice.insert(dto);
		dservice.setProcessY(seq);

		//잔여 휴가일 계산해서 빼기
		//1. 기간 받아오기
		Date today =  new Date(System.currentTimeMillis());
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy");
		String year = format1.format(today);
		String yearStart = year + "-01-01";
		String yearEnd = year + "-12-31";
		int durationSum = lservice.getDuration(empCode, yearStart, yearEnd); //기간 합
		//2. 시간 받아오기
		int timeSum = lservice.getTimeSum(empCode, yearStart, yearEnd);
		durationSum = durationSum + (timeSum / 8);
		//3. 사용날짜 다시 입력해주기
		ltuService.updateUsed(durationSum, year, empCode);
		
		return nr;
	}
}
