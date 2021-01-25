package kh.cocoa.dao;

import kh.cocoa.dto.MessageDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MessageDAO {
    public int insertMessage(MessageDTO msgdto);

    //public List<MessageDTO> myMessageListByCpage(int startRowNum,int endRowNum);

    public List<MessageDTO> myMessageList(int msg_seq);
}
