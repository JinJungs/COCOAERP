package kh.cocoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.MessengerPartyDAO;
import kh.cocoa.dto.MessengerPartyDTO;
@Service
public class MessengerPartyService implements MessengerPartyDAO {
	@Autowired
	MessengerPartyDAO mpdao;
	
	//채팅방 참가자 추가
	@Override
    public int setMessengerMember(List<MessengerPartyDTO> list) {
		return mpdao.setMessengerMember(list);
	}
	
	//채팅방 나가기
	public int exitMutiRoom(MessengerPartyDTO mparty) {
		return mpdao.exitMutiRoom(mparty);
	}
}
