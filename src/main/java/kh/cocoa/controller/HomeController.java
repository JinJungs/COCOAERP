package kh.cocoa.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.ScheduleDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.service.DocumentService;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.ScheduleService;
import kh.cocoa.service.TemplatesService;

@Controller
public class HomeController {

	@Autowired
	private EmployeeService eservice;
	
	@Autowired
	private ScheduleService sservice;
	
	@Autowired
	private DocumentService dservice;
	
	@Autowired
	private TemplatesService tservice;
	
	@Autowired
	private HttpSession session;

    @RequestMapping("/test")
    public String test() {
        return "document/c_writeDocument";
    }

    @RequestMapping("/test2")
    public String test2() {
        return "document/c_templateList";
    }

    @RequestMapping("/")
    public String login() {
        return "/index";
    }
    @RequestMapping("main")
    public String toMain(Model model) {
    	/*1. 전자 결재*/
    	//0. 사번
    			EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
    			int empCode = (Integer)loginDTO.getCode();
    			List<DocumentDTO> getBList =dservice.getAllBeforeConfirmList(empCode); //결재전
    			List<DocumentDTO> getNFList =dservice.getAllNFConfirmList(empCode);
    			List<DocumentDTO> getFList =dservice.getAllNFConfirmList(empCode);
    			List<DocumentDTO> getRList =dservice.getAllRConfirmList(empCode);
    			List<HashMap> hmlist = new ArrayList<>();
    			for(int i=0;i<getBList.size();i++){
    				HashMap<String,Object> map = new HashMap();
    				map.put("seq",getBList.get(i).getSeq());
    				map.put("dept_name",getBList.get(i).getDept_name());
    				map.put("emp_name",getBList.get(i).getEmp_name());
    				map.put("write_date",getBList.get(i).getWrite_date());
    				map.put("title",getBList.get(i).getTitle());
    				map.put("status","결재전");
    				hmlist.add(map);
    			}

    			for(int i=0;i<getNFList.size();i++){
    				HashMap<String,Object> map = new HashMap();
    				map.put("seq",getNFList.get(i).getSeq());
    				map.put("title",getNFList.get(i).getTitle());
    				map.put("dept_name",getNFList.get(i).getDept_name());
    				map.put("emp_name",getNFList.get(i).getEmp_name());
    				map.put("write_date",getNFList.get(i).getWrite_date());
    				map.put("status","진행중");
    				hmlist.add(map);
    			}

    			for(int i=0;i<getFList.size();i++){
    				HashMap<String,Object> map = new HashMap();
    				map.put("seq",getFList.get(i).getSeq());
    				map.put("dept_name",getFList.get(i).getDept_name());
    				map.put("emp_name",getFList.get(i).getEmp_name());
    				map.put("write_date",getFList.get(i).getWrite_date());
    				map.put("title",getFList.get(i).getTitle());
    				map.put("status","결재 완료");
    				hmlist.add(map);
    			}

    			for(int i=0;i<getRList.size();i++){
    				HashMap<String,Object> map = new HashMap();
    				map.put("seq",getRList.get(i).getSeq());
    				map.put("dept_name",getRList.get(i).getDept_name());
    				map.put("emp_name",getRList.get(i).getEmp_name());
    				map.put("write_date",getRList.get(i).getWrite_date());
    				map.put("title",getRList.get(i).getTitle());
    				map.put("status","반려함");
    				hmlist.add(map);
    			}
    			
    			//필요양식만 검색
    			List<String> templateList = new ArrayList<>();
    			List<TemplatesDTO> tempList = tservice.getTemplateList();
    			for(int i=3; i<tempList.size(); i++) {
    				templateList.add(Integer.toString(tempList.get(i).getCode()));
    			}
    			
    			List<DocumentDTO> docList = dservice.getAllDraftDocument(empCode, templateList); //tempList
    			for(int i=0; i<docList.size(); i++) {
    				if(docList.get(i).getStatus().contentEquals("RAISE")) {
    					docList.get(i).setStatus("결재중");
    				}else if(docList.get(i).getStatus().contentEquals("REJECT")) {
    					docList.get(i).setStatus("반려됨");
    				}else if(docList.get(i).getStatus().contentEquals("CONFIRM")) {
    					docList.get(i).setStatus("결재완료");
    				}
    			}

    			model.addAttribute("clist",hmlist);
    			model.addAttribute("docList", docList);
    	
    	/*2. 근태 관리*/
    	
    	
    	/*3. 일정 관리*/
    	Date today = new Date(System.currentTimeMillis());
    	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
    	SimpleDateFormat format2 = new SimpleDateFormat("MM / dd (E)");
    	
    	String todayString = format2.format(today);
    	
    	String todayString2 = format.format(today);
    	String date1 = todayString2 + "00:00:00";
    	String date2 = todayString2 + "23:59:59";
    	List<ScheduleDTO> scheduleList = sservice.selectTodaySchedule(date1, date2);
    	
    	model.addAttribute("todayString", todayString);
    	model.addAttribute("scheduleList", scheduleList);
    	
    	/*4. 회사 공지*/
    	
        return "/testMain";
    }
    
    /*-----------지영 - 버그리포트--------*/
    @GetMapping("/bug")
    public String bug(Model model) {
    	EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		
		//보내는 사람 이메일 입력
		EmployeeDTO sender_email = eservice.getSenderEmail(writer_code);
		model.addAttribute("sender_email",sender_email);
		
		//받는 사람 이메일
		
		String receiver_email = "cocoasemiproject@gmail.com";
		model.addAttribute("receiver_email",receiver_email);
        return "/bugReport/bugReport";
    }

    @RequestMapping("/toNex")
    public String toNex(){
        return "redirect:/index.html";
    }
}