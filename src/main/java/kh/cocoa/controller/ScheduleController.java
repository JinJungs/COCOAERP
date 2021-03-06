package kh.cocoa.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		
		List<ScheduleDTO> allSchedule  = sservice.selectAllSchedule();
		List<ScheduleDTO> companySchedule = sservice.selectCompanySchedule();
		List<ScheduleDTO> deptSchedule = sservice.selectDeptSchedule(Integer.toString(loginDTO.getDept_code()));
		List<ScheduleDTO> teamSchedule = sservice.selectTeamSchedule(Integer.toString(loginDTO.getTeam_code()));
		List<ScheduleDTO> personalSchedule = sservice.selectPersonalSchedule(Integer.toString(loginDTO.getCode()));

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
		
		//글쓴 사람 
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String empCode = Integer.toString(loginDTO.getCode());
		dto.setWriter(empCode);
		
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
			dto.setEmp_code(empCode);
			sservice.insertSchedule(dto, "personal");
		}else if(openTarget.contentEquals("team")) { //팀 일정
			dto.setTeam_code(Integer.toString(loginDTO.getTeam_code()));
			sservice.insertSchedule(dto, "team");
		}else if(openTarget.contentEquals("dept")) { //부서 일정
			dto.setDept_code(Integer.toString(loginDTO.getDept_code()));
			sservice.insertSchedule(dto, "dept");
		}
		return "redirect:/schedule/toScheduleMain.schedule";
	}
	
	@RequestMapping("getSchedule.schedule")
	public String getSchedule(String seq, String didUpdate, String status, Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String empCode = Integer.toString(loginDTO.getCode());
		
		if(status == null) {
			status = " ";
		}
		if(status.contentEquals("main")) {
			empCode="";
		}
		
		ScheduleDTO dto = sservice.getSchedule(seq);
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 | HH시");
		String startTime = format.format(dto.getStart_time());
		String endTime = format.format(dto.getEnd_time());
		
		model.addAttribute("dto", dto);
		model.addAttribute("empCode", empCode);
		model.addAttribute("didUpdate", didUpdate);	
		model.addAttribute("startTime", startTime);	
		model.addAttribute("endTime", endTime);	
		
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
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		
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
			dto.setEmp_code(Integer.toString(loginDTO.getCode()));
			dto.setTeam_code("");
			dto.setDept_code("");
		}else if(openTarget.contentEquals("team")) { //팀 일정
			dto.setEmp_code("");
			dto.setTeam_code(Integer.toString(loginDTO.getTeam_code()));
			dto.setDept_code("");
		}else if(openTarget.contentEquals("dept")) { //부서 일정
			dto.setEmp_code("");
			dto.setTeam_code("");
			dto.setDept_code(Integer.toString(loginDTO.getDept_code()));
		}
		sservice.update(dto);
		
		String didUpdate = "true";	
		
		return "redirect:/schedule/getSchedule.schedule?seq=" + dto.getSeq() + "&didUpdate=" + didUpdate;
	}
	@RequestMapping("deleteSchedule.schedule")
	@ResponseBody
	public String delete(String seq) {
		int result = sservice.delete(seq);
		return Integer.toString(result);
	}

	// 넥사크로
	@RequestMapping("/getList.nex")
	public NexacroResult getList(){
		NexacroResult nr = new NexacroResult();
		List<ScheduleDTO> list = sservice.selectListNex();
		nr.addDataSet("out_ds", list);
		return nr;
	}

	@RequestMapping("/searchByDate.nex")
	public NexacroResult searchByDate(@ParamVariable(name="sch_start")String sch_start, @ParamVariable(name="sch_end")String sch_end) {
		NexacroResult nr = new NexacroResult();
//		String str_start = dateFormat(sch_start);
//		String str_end = dateFormat(sch_end);
		System.out.println(sch_start);
		System.out.println(sch_end);
		List<ScheduleDTO> list = sservice.selectListByDateNex(sch_start, sch_end);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setChk("0");
		}
		System.out.println(list);
		nr.addDataSet("out_ds", list);
		return nr;
	}

	@RequestMapping("/createSchedule.nex")
	public NexacroResult createSchedule(@ParamVariable(name="title")String title, @ParamVariable(name="start")String start,@ParamVariable(name="end")String end,@ParamVariable(name="color")String color,@ParamVariable(name="contents")String contents) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		String empCode = Integer.toString(loginDTO.getCode());

		sservice.insertScheduleNex(title, contents, start, end, color, empCode);

		return new NexacroResult();
	}

	@RequestMapping("/deleteSchedule.nex")
	public NexacroResult deleteSchedule(@ParamVariable(name="seq")String seq){
		System.out.println(seq);
		return new NexacroResult();
	}

	// Date -> String
	public String dateFormat(java.util.Date input){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String output = format.format(input);
		return output;
	}
}
