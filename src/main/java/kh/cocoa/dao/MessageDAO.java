package kh.cocoa.dao;

import kh.cocoa.dto.MessageDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MessageDAO {
    public int insertMessage(MessageDTO msgdto);

    public List<MessageDTO> getMessageList(int m_seq);

    // 10개씩 불러오기
    public List<MessageDTO> getMessageListByCpage(int m_seq,int startRowNum, int endRowNum);

    public int getMessagePageCount(int emp_code);

    //파일 업로드를 위한 메세지 시퀀스 미리 뽑기
	public int selectMessageSeq();
//	//파일 업로드용 메세지 인서트
//	public int insertFileMessage(MessageDTO msgdto);

}
