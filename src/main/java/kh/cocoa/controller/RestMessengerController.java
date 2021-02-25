package kh.cocoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;

@RestController
@RequestMapping("/restMessenger")
public class RestMessengerController {
	
	@Autowired
	private FilesService fservice;
	
	@RequestMapping("/uploadFile")
	public String upload(@RequestParam("file") MultipartFile file) throws IOException {
		System.out.println("레스트메신저컨트롤러 uploadMessengerFile 도착");
		System.out.println("File : "+file);
		//00-1.JSON 반환할 값 초기화 
    	int resultF = 0;
    	FilesDTO fdto = new FilesDTO();
    	//00-2. 저장 루트 지정
    	String fileRoot = Configurator.messengerFileRoute; 
		File filesPath = new File(fileRoot);
		//00-3. 폴더 없으면 만들기
		if(!filesPath.exists()) {filesPath.mkdir();}
		
		if(file!=null) {
	    	//01-1. 원본이름과 저장할 이름 구하기
			String oriName = file.getOriginalFilename();
			String uid = UUID.randomUUID().toString().replaceAll("-", "");
			String savedName = uid + "-" + oriName;
			//01-2. 파일 dto 세팅하기 
			fdto.setOriname(oriName);
			fdto.setSavedname(savedName);
			//01-3. Files 테이블에 저장
			//selectkey를 이용해 미리 메세지 시퀀스 값을 구해놓았다.
			resultF = fservice.uploadFilesMsg(fdto); 
			
			//03. 01이 성공하면 지정 경로에 파일 저장 
			if (resultF > 0) { 
				File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
				FileCopyUtils.copy(file.getBytes(), targetLoc); 
			}
		}
		System.out.println("레스트메신저컨트롤러 업로드 resultF : " +resultF);
		JsonObject obj = new JsonObject();
	    obj.addProperty("resultF", resultF);
	    obj.addProperty("msg_seq", fdto.getMsg_seq());
	    obj.addProperty("savedname", fdto.getSavedname());
	    return new Gson().toJson(obj);
	}
}
