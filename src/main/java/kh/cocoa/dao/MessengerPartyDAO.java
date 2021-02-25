package kh.cocoa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kh.cocoa.dto.MessengerPartyDTO;

@Mapper
public interface MessengerPartyDAO {

	//채팅방 참가자 추가
	public int setMessengerMember(List<MessengerPartyDTO> list);

	
	// 메신저 나가기
	public int exitMutiRoom(MessengerPartyDTO mparty);

}
