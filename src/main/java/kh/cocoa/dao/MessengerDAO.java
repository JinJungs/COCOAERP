package kh.cocoa.dao;


import kh.cocoa.dto.MessengerViewDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MessengerDAO {
    //내 사원코드와 비교하여 나와 관련된 채팅방 셀렉트
    public List<MessengerViewDTO> myMessengerList(@Param("code") int code);

}
