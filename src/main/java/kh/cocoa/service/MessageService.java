package kh.cocoa.service;

import kh.cocoa.dao.MessageDAO;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.statics.Configurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageService implements MessageDAO {
    @Autowired
    MessageDAO msgdao;

    @Override
    public int insertMessage(MessageDTO msgdto){
        return msgdao.insertMessage(msgdto);
    }

    @Override
    public List<MessageDTO> getMessageList(int msg_seq) {
        return msgdao.getMessageList(msg_seq);
    }

    // 일단 상속
    @Override
    public List<MessageDTO> getMessageListByCpage(int msg_seq, int startRowNum, int endRowNum) {
        return msgdao.getMessageListByCpage(msg_seq,startRowNum, endRowNum);
    }

    // 오버라이딩으로 구현현
    public List<MessageDTO> getMessageListByCpage(int msg_seq, int cpage) {
        int startRowNum = (cpage - 1) * Configurator.recordCountPerPage + 1;
        int endRowNum = startRowNum + Configurator.recordCountPerPage - 1;
        return msgdao.getMessageListByCpage(msg_seq,startRowNum, endRowNum);
    }

    @Override
    public int getMessagePageCount(int emp_code){
        emp_code=1001;
        return msgdao.getMessagePageCount(emp_code);
    }

}
