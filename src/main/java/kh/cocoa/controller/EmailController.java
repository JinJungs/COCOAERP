package kh.cocoa.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

//import kh.cocoa.service.EmailServices;

@Controller
@RequestMapping("/email")
public class EmailController {
	
//	EmailServices eservice;  
	@Autowired
	JavaMailSender mailSender; 


	@Autowired
	private HttpServletRequest request;

	@RequestMapping("emailSend.email")
	public String emailSend(String receiver_email) {
		
		String setfrom = request.getParameter("email"); //보내는 사람 (Employee에서 Email&B_Email)
		String tomail = request.getParameter("receiver_email"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
		String contents = request.getParameter("contents");


		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(contents); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		return "bugReport/bugReportView"; //추우 메인 홈페이지로 변경해야함      
	}
	/*-----------------------예외처리-----------------------*/
	@ExceptionHandler
	public String exceptionhandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
