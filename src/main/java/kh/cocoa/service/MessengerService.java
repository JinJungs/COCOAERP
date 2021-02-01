package kh.cocoa.service;

import kh.cocoa.dao.MessengerDAO;
import kh.cocoa.dto.MessengerViewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessengerService implements MessengerDAO{
	@Autowired
	MessengerDAO mdao;

	//내 사원코드와 비교하여 나와 관련된 채팅방 셀렉트
	@Override
	public List<MessengerViewDTO> myMessengerList(int code){
		return mdao.myMessengerList(code);
	}

}
