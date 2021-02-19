package kh.cocoa.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.Leave_Taken_UsedDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.Leave_Taken_UsedService;

@Controller
@RequestMapping("/ltuN")
public class NexacroLeave_Taken_UsedController {
	
	@Autowired
	private Leave_Taken_UsedService lservice;
	
	@Autowired
	private EmployeeService eservice;
	
	/*넥사크로*/
	@RequestMapping("insertAllLTU.ltuN")
	public String insertAllLTU() {
		//오늘날짜 받아오기
		Date today = new Date(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String year = format.format(today);
		
		//employee 리스트 받아오기
		List<EmployeeDTO> list = eservice.getListWithdrawN();

		//처리
		for(int i=0; i<list.size(); i++) {
			int isExist = lservice.isExist(list.get(i).getCode(), Integer.parseInt(year)); //존재하는지 확인
			if(isExist == 0) {
				//입사일 받아와서 기본 휴가일 수 계산
				Date hire_date = list.get(i).getHire_date(); //입사일
				String hire_year = format.format(hire_date); //입사년도
				int workYear = Integer.parseInt(year) - Integer.parseInt(hire_year);
				int leaveDay = 0;
				
				if(workYear > 0) {	//1년이 넘은경우에 연차부여
					leaveDay = 15 + (workYear-1)/2; //기본 15일 + 3년차이상부터 2년당 1일씩
				}
				lservice.insert(Integer.parseInt(year), list.get(i).getCode(), leaveDay);
			}
		}
		return "redirect:/membership/selectEmployeeLTU.employee";
	}
	
	@RequestMapping("addLeave.ltuN")
	public String addLeave(@ParamDataSet(name="in_ds")List<Leave_Taken_UsedDTO> list) {
		int empCode = 0;
		int leaveDay = 0;
		int year = 0;
		for(int i=0; i<list.size(); i++) {
			empCode = list.get(i).getCode();
			year = list.get(i).getYear();
			
			Leave_Taken_UsedDTO dto = lservice.getLeaveStatus(empCode, Integer.toString(year)); //해당 년도, 사번에 따른 휴가dto
			
			if(dto.getLeave_got() != 0) {
				leaveDay = dto.getLeave_got() + list.get(i).getAddLeave(); //기존 휴가 + 추가 휴가
			}else {
				leaveDay = list.get(i).getAddLeave();
			}
			lservice.plusLeaveGot(year, empCode, leaveDay); //새로 셋팅
		}
		return "redirect:/membership/selectEmployeeLTU.employee";
	}
}
