package kh.cocoa.dao;


import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;

import kh.cocoa.dto.MessengerDTO;
import kh.cocoa.dto.MessengerPartyDTO;
import kh.cocoa.dto.MessengerViewDTO;

@Mapper
public interface MessengerDAO {
    //내 사원코드와 비교하여 나와 관련된 채팅방 셀렉트
    public List<MessengerViewDTO> myMessengerList(@Param("code") int code);

    public MessengerViewDTO getMessengerPartyEmpInfo(int seq, int code);
    
    public List<MessengerViewDTO> getListMessengerPartyEmpInfo(int seq);
//=============================  
    //1:1 채팅방 있는지 확인
    public int isSingleMessengerRoomExist(int loginEmpCode, int partyEmpCode);
    //1:1 채팅방 시퀀스 불러오기 
    public int getSingleMessengerRoom(int loginEmpCode, int partyEmpCode);
    
    //채팅방 생성 후 시퀀스 받기
    @Options(useGeneratedKeys=true, keyProperty = "id") 
    public int insertMessengerRoomGetSeq(MessengerDTO messenger);

	public MessengerDTO getMessengerInfo(int seq);

//==========================
	//메신저 타입 M으로 바꾸기
	public int updateTypeToM(int seq);
	
	//채팅방 이름 바꾸기
	public int updateName(int seq, String name);

}
