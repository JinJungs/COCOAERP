package kh.cocoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.MessageService;
import kh.cocoa.statics.Configurator;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService msgservice;
    
    @Autowired
    FilesService fservice;

    @RequestMapping("/")
    public String toChatExam() {
        return "/messenger/chatExam";
    }
    
    // 메세지 테이블 + 파일 테이블 + 파일 저장
/*    @RequestMapping("insertMessageFile")
    @ResponseBody
    public String insertMessageFile(MessageDTO msgdto, MultipartFile file) throws IOException{
    	int result = 0;
    	int resultF = 0;
    	System.out.println("메세지 컨트롤러 메세지+파일인서트 도착");
    	System.out.println("File"+file);
    	System.out.println("MSG DTO : " + msgdto);
    	if(msgdto.getType().contentEquals("FILE")||msgdto.getType().contentEquals("IMAGE")) {
        	System.out.println("메세지 컨트롤러 메세지+파일인서트 파트 도착");
    		//00. 파일 저장 관련 설정
    		String fileRoot = Configurator.messengerFileRoute; //파일 저장할 경로
    		File filesPath = new File(fileRoot);
    		//폴더 없으면 만들기
    		if(!filesPath.exists()) {filesPath.mkdir();}

    		if(file!=null) {
    	    	//01-1.파일에 대한 정보 Files 테이블에 저장
    			String oriName = file.getOriginalFilename();
    			String uid = UUID.randomUUID().toString().replaceAll("-", "");
    			String savedName = uid + "-" + oriName;
    			
    			//01-2.메세지 시퀀스 미리 뽑기
    	    	int message_seq = msgservice.selectMessageSeq();
    	    	System.out.println("미리 뽑은 message_seq : "+ message_seq);
    	    	//파일 dto 인서트
    			FilesDTO fdto = new FilesDTO().builder().oriname(oriName).savedname(savedName).msg_seq(message_seq).build();
    			resultF = fservice.uploadFilesMsg(fdto); 
    			System.out.println("resultF : "+resultF);
    			//03. 02가 성공하면 지정 경로에 파일 저장
    			if (resultF > 0) {
    				File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
    				FileCopyUtils.copy(file.getBytes(), targetLoc);
    			}
    			//04. 메세지 테이블에 파일 전송 메세지 저장
    			result = msgservice.insertMessage(msgdto);
    			System.out.println("result : "+result);
    		}
        }else {
        	System.out.println("MessageController insertMessage 에러발생 : 타입");
        }
    	
    	JsonObject obj = new JsonObject();
        obj.addProperty("result", result);
        obj.addProperty("resultF", resultF);
        return new Gson().toJson(obj);
    }
    */
    
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
