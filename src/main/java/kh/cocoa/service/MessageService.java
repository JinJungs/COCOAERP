package kh.cocoa.service;

import kh.cocoa.dao.MessageDAO;
import kh.cocoa.dto.MessageDTO;
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

//    public List<MessageDTO> myMessageListByCpage(int cpage){
//        int startRowNum = (cpage-1)* Configurator.recordCountPerPage +1;
//        int endRowNum = startRowNum + Configurator.recordCountPerPage -1;
//        return msgdao.myMessageListByCpage(startRowNum,endRowNum);
//    }

    @Override
    public List<MessageDTO> myMessageList(int msg_seq) {
        return msgdao.myMessageList(msg_seq);
    }

}
