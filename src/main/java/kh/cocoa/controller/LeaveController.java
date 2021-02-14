package kh.cocoa.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.LeaveDTO;
import kh.cocoa.dto.Leave_Taken_UsedDTO;
import kh.cocoa.service.LeaveService;
import kh.cocoa.service.Leave_Taken_UsedService;
import kh.cocoa.statics.DocumentConfigurator;

@Controller
@RequestMapping("/leave")
public class LeaveController {
	
	@Autowired
	private LeaveService lservice;
	
	@Autowired
	private Leave_Taken_UsedService ltuService;
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("toLeaveMain.leave")
	public String toLeaveMain(String year, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		Date hireDate = loginDTO.getHire_date();
		int empCode = (Integer)loginDTO.getCode();
		
		//year 없으면 현재날짜로 보안코드 작성 필요
		Date today =  new Date(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		if(year == null) {
			year = format.format(today);
		}
		
		//1. 내 휴가정보(기본)
		Leave_Taken_UsedDTO ltuLeaveDTO = ltuService.getLeaveStatus(empCode, year);
		
		//2. 휴가 사용현황
		String yearStart = year + "-01-01";
		String yearEnd = year + "-12-31";
		List<LeaveDTO> leaveList = lservice.getLeavelist(empCode, yearStart, yearEnd);
		
		//3. 휴가 사용 일수
		int ordinaryL = 0; 	//정기휴가
		int sickL = 0;		//병가
		int longSickL = 0;	//보건
		int earlyL = 0;		//조퇴
		int halfL = 0;		//반차
		int familyL = 0;	//경조사
		int childBirthL = 0;//출산
		int etcL = 0;		//기타
		
		for(int i=0; i<leaveList.size(); i++) {
			if(leaveList.get(i).getType().contentEquals("정기")) {
				ordinaryL = ordinaryL + leaveList.get(i).getDuration();
			}else if(leaveList.get(i).getType().contentEquals("병가")) {
				sickL = sickL + leaveList.get(i).getDuration();
			}else if(leaveList.get(i).getType().contentEquals("보건")) {
				longSickL = longSickL + leaveList.get(i).getDuration();
			}else if(leaveList.get(i).getType().contentEquals("조퇴")) {
				earlyL = earlyL + leaveList.get(i).getTime();
			}else if(leaveList.get(i).getType().contentEquals("반차")) {
				halfL = halfL + leaveList.get(i).getTime();
			}else if(leaveList.get(i).getType().contentEquals("경조사")) {
				familyL = familyL + leaveList.get(i).getDuration();
			}else if(leaveList.get(i).getType().contentEquals("출산")) {
				childBirthL = childBirthL + leaveList.get(i).getDuration();
			}else if(leaveList.get(i).getType().contentEquals("기타")) {
				etcL = etcL + leaveList.get(i).getDuration();
			}
			
		}
		//4. 조퇴누적시간(내 휴가정보 부분)
		int timeSum = 0;
		for(int i=0; i<leaveList.size(); i++) {
			//조퇴 누적시간
			if(leaveList.get(i).getTime() != 0) {
				timeSum += leaveList.get(i).getTime();
			}
		}
		
		//5. 년도 list에 담아서 넘기기(select)
		List<Integer> yearList = new ArrayList<>();
		int startYear = Integer.parseInt(format.format(hireDate));
		int endYear = Integer.parseInt(format.format(today));
		System.out.println("startYear " + startYear);
		System.out.println("endYear " + endYear);
		for(int i=startYear; i<endYear+1; i++) {
			yearList.add(i);
		}
		model.addAttribute("hireDate", hireDate);
		model.addAttribute("ltuLeaveDTO", ltuLeaveDTO);
		model.addAttribute("leaveList", leaveList);
		model.addAttribute("timeSum", timeSum);
		model.addAttribute("ordinaryL", ordinaryL);
		model.addAttribute("sickL", sickL);
		model.addAttribute("longSickL", longSickL);
		model.addAttribute("earlyL", earlyL);
		model.addAttribute("halfL", halfL);
		model.addAttribute("familyL", familyL);
		model.addAttribute("childBirthL", childBirthL);
		model.addAttribute("etcL", etcL);
		model.addAttribute("yearList", yearList);
		
		return "/leave/leaveMain";
	}
}
