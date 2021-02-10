package kh.cocoa.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.cocoa.dto.EmailDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.ScheduleDTO;
import kh.cocoa.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService sservice;
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("toScheduleMain.schedule")
	public String toScheduleMain(Model model) {
		
		List<ScheduleDTO> allSchedule  = sservice.selectAllSchedule();
		List<ScheduleDTO> companySchedule = sservice.selectCompanySchedule();
		List<ScheduleDTO> deptSchedule = sservice.selectDeptSchedule("1");
		List<ScheduleDTO> teamSchedule = sservice.selectTeamSchedule("11");
		List<ScheduleDTO> personalSchedule = sservice.selectPersonalSchedule("1004");

		Date today = new Date(System.currentTimeMillis());
		
		model.addAttribute("allSchedule", allSchedule);
		model.addAttribute("companySchedule", companySchedule);
		model.addAttribute("deptSchedule", deptSchedule);
		model.addAttribute("teamSchedule", teamSchedule);
		model.addAttribute("personalSchedule", personalSchedule);
		model.addAttribute("today", today);
		
		
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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		//int empCode = (Integer)loginDTO.getCode();
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
		
		//공개 범위별 처리(수정필요)
		if(openTarget.contentEquals("personal")) { //개인 일정
			dto.setEmp_code("1004");
			sservice.insertSchedule(dto, "personal");
		}else if(openTarget.contentEquals("team")) { //팀 일정
			dto.setTeam_code("11");
			sservice.insertSchedule(dto, "team");
		}else if(openTarget.contentEquals("dept")) { //부서 일정
			dto.setDept_code("1");
			sservice.insertSchedule(dto, "dept");
		}
		return "redirect:/schedule/toScheduleMain.schedule";
	}
	
	@RequestMapping("getSchedule.schedule")
	public String getSchedule(String seq, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		//int empCode = (Integer)loginDTO.getCode();
		int empCode = 1004;
		
		ScheduleDTO dto = sservice.getSchedule(seq);
		
		model.addAttribute("dto", dto);
		model.addAttribute("empCode", empCode);
		
		return "/schedule/popUpInfo";
	}
	@RequestMapping("toUpdate.schedule")
	public String toUpdate(String seq, Model model) {
		
		ScheduleDTO dto = sservice.getSchedule(seq);
		
		//날짜 필요한 형태로 바꾸기
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
		//1) 시작 날짜/시간
		Timestamp temp = dto.getStart_time();
		String startDate = format.format(temp);
		startDate = startDate.substring(0, 10);
		temp = dto.getEnd_time();
		String startTime = format.format(temp);
		startTime = startTime.substring(11, 13);
		//2) 마감 날짜/시간
		String endDate = format.format(temp);
		endDate = endDate.substring(0, 10);
		temp = dto.getEnd_time();
		String endTime = format.format(temp);
		endTime = endTime.substring(11, 13);

		//분류(개인, 팀, 부서)
		String openTarget = "";
		if(dto.getEmp_code()!=null) {
			openTarget="personal";
		}else if(dto.getTeam_code()!=null) {
			openTarget="team";
		}else if(dto.getDept_code()!=null) {
			openTarget="dept";
		}
		
		System.out.println("startDate : " + startDate);
		System.out.println("startTime : " + startTime);
		System.out.println("endDate : " + endDate);
		System.out.println("endTime : " + endTime);
		
		
		model.addAttribute("dto", dto);
		model.addAttribute("startDate", startDate);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endDate", endDate);
		model.addAttribute("endTime", endTime);
		model.addAttribute("openTarget", openTarget);
		
		return "/schedule/popUpRevise";
	}
	@RequestMapping("update.schedule")
	public String update(ScheduleDTO dto, String openTarget, Date startDate, String startTime, Date endDate, String endTime) {
		
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
		
		//contents가 null이면 처리 필요할듯?
		
		//공개 범위별 처리
		if(openTarget.contentEquals("personal")) { //개인 일정
			dto.setEmp_code("1004");
			dto.setTeam_code("");
			dto.setDept_code("");
		}else if(openTarget.contentEquals("team")) { //팀 일정
			dto.setEmp_code("");
			dto.setTeam_code("11");
			dto.setDept_code("");
		}else if(openTarget.contentEquals("dept")) { //부서 일정
			dto.setEmp_code("");
			dto.setTeam_code("");
			dto.setDept_code("1");
		}
		sservice.update(dto);
		
		return "redirect:/schedule/getSchedule.schedule?seq="+dto.getSeq();
	}
	@RequestMapping("deleteSchedule.schedule")
	@ResponseBody
	public String delete(String seq) {
		int result = sservice.delete(seq);
		return Integer.toString(result);
	}
}
