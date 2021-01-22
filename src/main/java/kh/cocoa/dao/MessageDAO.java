package kh.cocoa.dao;

import kh.cocoa.dto.MessageDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageDAO {
    public int insertMessage(MessageDTO msgdto);
}
