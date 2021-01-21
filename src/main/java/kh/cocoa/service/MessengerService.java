package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.MessengerDAO;
import kh.cocoa.dto.MessengerDTO;

@Service
public class MessengerService implements MessengerDAO{
	@Autowired
	MessengerDAO mdao;
	
	//내 사원코드와 비교하여 나와 관련된 채팅방 셀렉트
	@Override
	public List<MessengerDTO> myMessengerList(int code){
		return mdao.myMessengerList(code); 
	}
}
