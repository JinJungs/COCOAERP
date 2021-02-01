package kh.cocoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.EmailDAO;
import kh.cocoa.dto.EmailDTO;

@Service
public class EmailService implements EmailDAO{
	@Autowired
	private EmailDAO edao;
	
	@Override
	public void sendEmail(EmailDTO dto) {
		edao.sendEmail(dto);
	}
	
}
