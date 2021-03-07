package kh.cocoa.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService msgservice;
    
    @Autowired
    FilesService fservice;
    
    @Autowired
    EmployeeService eservice;

    @RequestMapping("/")
    public String toChatExam() {
        return "/messenger/chatExam";
    }

    // 메세지 테이블에 insert
    @RequestMapping("insertMessage")
    @ResponseBody
    public String insertMessage(MessageDTO msgdto) throws IOException {
    	System.out.println("인서트 메세지 컨트롤러 도착");
    	int result = 0;
    	
    	//메세지 타입이 TEXT 인지 FILE 이나 IMAGE인지에 따라
    	if(msgdto.getType().contentEquals("TEXT")) {
    		result = msgservice.insertMessage(msgdto); //의진씨한테 확인받기 (원래 코드)
    	}
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
        List<MessageDTO> list = msgservice.getMessageListByCpage(m_seq,cpage);
        for(int i=0; i<list.size();i++){
        	String type = list.get(i).getType();
        	String contents = list.get(i).getContents();
        	//AN_ADD 사람 추가 메세지는 코드로된 메세지 내용을 이름으로 바꿔서 보내준다.
        	if(type.contentEquals("AN_ADD")) {
        		String partyListEdited = contents.substring(1, contents.length()-1);
            	String[] partyListArr = partyListEdited.split(",");
            	contents = "";
            	for(String party : partyListArr) {
            		int addedCode = Integer.parseInt(party);
            		if(contents.isEmpty()) {
            			contents += eservice.getEmpNameByCode(addedCode);
            		}else {
            			contents += " ,";
            			contents += eservice.getEmpNameByCode(addedCode);
            		}
            	}
        	}
        	        	
            param.put("seq",list.get(i).getSeq());
            param.put("contents", contents);
            param.put("emp_code",list.get(i).getEmp_code());
            param.put("write_date",list.get(i).getWrite_date());
            param.put("type",type);
            param.put("savedname",list.get(i).getSavedname());
            param.put("empname",list.get(i).getEmpname());
            

            // 의진 추가 - 참여자의 프로필 이미지 추가하기
            FilesDTO getProfile = fservice.findBeforeProfile(list.get(i).getEmp_code());
            if(getProfile==null) {
                param.put("profile", "/img/Profile-m.png");
            }else{
                String profileLoc = "/profileFile/" + getProfile.getSavedname();
                param.put("profile", profileLoc);
            }
            jArray.put(param);
        }
        return jArray.toString();
    }

    // 채팅창에서 검색한 메세지 찾기
    @RequestMapping("searchMsgInChatRoom")
    @ResponseBody
    public String searchMsgInChatRoom(int m_seq, String contents){
        JSONArray jArray = new JSONArray();
        List<MessageDTO> msgSearchList = msgservice.searchMsgInChatRoom(m_seq, contents);
        for(int i=0; i<msgSearchList.size();i++){
            jArray.put(msgSearchList.get(i).getSeq());
        }
        return jArray.toString();
    }
    

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }
}
