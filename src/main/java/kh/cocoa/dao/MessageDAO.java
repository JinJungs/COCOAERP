package kh.cocoa.dao;

import kh.cocoa.dto.MessageDTO;
import kh.cocoa.dto.MessageViewDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MessageDAO {
    public int insertMessage(MessageDTO msgdto);

    public List<MessageDTO> getMessageList(int m_seq);

    // 10개씩 불러오기
    public List<MessageDTO> getMessageListByCpage(int m_seq,int startRowNum, int endRowNum);

    public int getMessagePageCount(int emp_code);

    public int insertMessageGotSeq(MessageDTO msgdto);

    // 내용으로 메세지 찾기
    public List<MessageViewDTO> searchMsgByContents(int code, String contents);

    // 채팅창에서 검색한 메세지 찾기
    public List<MessageDTO> searchMsgInChatRoom(int m_seq, String contents);
}
