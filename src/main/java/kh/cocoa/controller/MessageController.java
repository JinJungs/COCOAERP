package kh.cocoa.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.MessageService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService msgservice;

    @RequestMapping("/")
    public String toChatExam() {
        return "/messenger/chatExam";
    }

    // 메세지 테이블에 insert
    @RequestMapping("insertMessage")
    @ResponseBody
    public String insertMessage(MessageDTO msgdto) {
        int result = msgservice.insertMessage(msgdto);
        JsonObject obj = new JsonObject();
        obj.addProperty("result", result);
        return new Gson().toJson(obj);
    }
    // 메세지 목록 불러오기
    @RequestMapping("getMessageListByCpage")
    @ResponseBody
    public String getMessageList(int m_seq,int cpage){
        System.out.println("m_seq: " +m_seq);
        JSONArray jArray = new JSONArray();
        HashMap<String,Object> param = new HashMap<>();
        //List<MessageDTO> list = msgservice.getMessageList(m_seq);
        List<MessageDTO> list = msgservice.getMessageListByCpage(m_seq,cpage);
        for(int i=0; i<list.size();i++){
            param.put("contents",list.get(i).getContents());
            param.put("emp_code",list.get(i).getEmp_code());
            param.put("write_date",list.get(i).getWrite_date());
            jArray.put(param);
        }
        return jArray.toString();
    }
    
    //STOMP 테스트용 메세지
    @RequestMapping("chatTest")
    public String chatTest() {
    	return "/messenger/chatTest";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }
}
