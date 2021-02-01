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
		
    	int resultF = 0;
    	String savedName ="";
    	String fileRoot = Configurator.messengerFileRoute; //파일 저장할 경로
		File filesPath = new File(fileRoot);
		//폴더 없으면 만들기
		if(!filesPath.exists()) {filesPath.mkdir();}
		
		if(file!=null) {
	    	//01-1.파일에 대한 정보 Files 테이블에 저장
			String oriName = file.getOriginalFilename();
			String uid = UUID.randomUUID().toString().replaceAll("-", "");
			savedName = uid + "-" + oriName;
			System.out.println("RestMessengerController 파일이 널이 아님 ");
			System.out.println("oriName : "+oriName);
			
			
			 //파일 dto 인서트 
			FilesDTO fdto = new FilesDTO().builder().oriname(oriName).savedname(savedName).build(); 
			resultF = fservice.uploadFilesMsg(fdto); 
			System.out.println("resultF : "+resultF);
			 //03. 02가 성공하면 지정 경로에 파일 저장 
			if (resultF > 0) { 
				File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
				FileCopyUtils.copy(file.getBytes(), targetLoc); 
			}
		}
		System.out.println("레스트메신저컨트롤러 업로드 resultF : " +resultF);
		System.out.println("레스트메신저커느롤러 파일 savedName : "+ savedName);
		JsonObject obj = new JsonObject();
	    obj.addProperty("resultF", resultF);
	    obj.addProperty("savedName", savedName);
	    return new Gson().toJson(obj);
	}
}
