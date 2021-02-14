package kh.cocoa.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.MessengerDAO;
import kh.cocoa.dto.MessengerDTO;
import kh.cocoa.dto.MessengerPartyDTO;
import kh.cocoa.dto.MessengerViewDTO;

@Service
public class MessengerService implements MessengerDAO{
	@Autowired
	MessengerDAO mdao;

	//내 사원코드와 비교하여 나와 관련된 채팅방 셀렉트
	@Override
	public List<MessengerViewDTO> myMessengerList(int code){
		return mdao.myMessengerList(code);
	}
	//참가자 정보
	@Override
	public MessengerViewDTO getMessengerPartyEmpInfo(int seq, int code){return mdao.getMessengerPartyEmpInfo(seq, code);}
	//다수의 참가자 정보 리스트
	@Override
	public List<MessengerViewDTO> getListMessengerPartyEmpInfo(int seq){return mdao.getListMessengerPartyEmpInfo(seq);}
	
	//1:1채팅 있는지 확인
	@Override
	public int isSingleMessengerRoomExist(int loginEmpCode, int partyEmpCode) {
		return mdao.isSingleMessengerRoomExist(loginEmpCode, partyEmpCode);
	}
	//1:1채팅 시퀀스 받기
	@Override
	public int getSingleMessengerRoom(int loginEmpCode, int partyEmpCode) {
		return mdao.getSingleMessengerRoom(loginEmpCode, partyEmpCode);
	}
	
	//채팅방 생성 후 시퀀스 받기
	@Override
	public int insertMessengerRoomGetSeq(MessengerDTO messenger) {
		return mdao.insertMessengerRoomGetSeq(messenger);
	}
	public MessengerDTO getMessengerInfo(int seq) {
		return mdao.getMessengerInfo(seq);
	}

	//메신저 타입 M으로 바꾸기
	public int updateTypeToM(int seq) {
		return mdao.updateTypeToM(seq);
	};
	
	//채팅방 이름 바꾸기
	public int updateName(int seq, String name) {
		return mdao.updateName(seq, name);
	};
}
