package kh.cocoa.service;

import kh.cocoa.dao.MessageDAO;
import kh.cocoa.dto.MessageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService implements MessageDAO {
    @Autowired
    MessageDAO msgdao;

    @Override
    public int insertMessage(MessageDTO msgdto){
        return msgdao.insertMessage(msgdto);
    }

}
