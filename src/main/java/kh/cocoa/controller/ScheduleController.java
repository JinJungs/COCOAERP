package kh.cocoa.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.EmailDTO;
import kh.cocoa.dto.ScheduleDTO;
import kh.cocoa.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService sservice;
	
	@RequestMapping("toScheduleMain.schedule")
	public String toScheduleMain(Model model) {
		
		List<ScheduleDTO> allSchedule  = sservice.selectAllSchedule();
		List<ScheduleDTO> companySchedule = sservice.selectCompanySchedule();
		List<ScheduleDTO> deptSchedule = sservice.selectDeptSchedule("1");
		List<ScheduleDTO> teamSchedule = sservice.selectTeamSchedule("11");
		List<ScheduleDTO> personalSchedule = sservice.selectPersonalSchedule("1004");

		model.addAttribute("allSchedule", allSchedule);
		model.addAttribute("companySchedule", companySchedule);
		model.addAttribute("deptSchedule", deptSchedule);
		model.addAttribute("teamSchedule", teamSchedule);
		model.addAttribute("personalSchedule", personalSchedule);
		
		return "schedule/scheduleMain";
	}
	
	@RequestMapping("addSchedule.schedule")
	public String addSchedule(ScheduleDTO dto, String openTarget, Date startDate, String startTime, Date endDate, String endTime,  Model model) {
		System.out.println("openTarget : " + openTarget);
		System.out.println("title : " + dto.getTitle());
		System.out.println("startDate : " + startDate);
		System.out.println("startTime : " + startTime);
		System.out.println("endDate : " + endDate);
		System.out.println("endTime : " + endTime);
		System.out.println("contents : " + dto.getContents());
		System.out.println("color : " + dto.getColor());
		
		//글쓴 사람
		dto.setWriter("1004");
		
		//날짜 필요한 형태로 바꾸기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String start = format.format(startDate);
		start = start + " " + startTime + ":00:00";
		Timestamp startTimestamp = Timestamp.valueOf(start);
		String end = format.format(endDate);
		end = end + " " + startTime + ":00:00";
		Timestamp endTimestamp = Timestamp.valueOf(end);
		dto.setStart_time(startTimestamp);
		dto.setEnd_time(endTimestamp);
		
		//공개 범위별 처리
		if(openTarget.contentEquals("personal")) { //개인 일정
			dto.setEmp_code("1004");
			sservice.insertSchedule(dto, "private");
		}else if(openTarget.contentEquals("team")) { //팀 일정
			dto.setTeam_code("11");
			sservice.insertSchedule(dto, "team");
		}else if(openTarget.contentEquals("dept")) { //부서 일정
			dto.setDept_code("1");
			sservice.insertSchedule(dto, "dept");
		}
		
		
		return "redirect:/schedule/toScheduleMain.schedule";
	}
}
