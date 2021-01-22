package kh.cocoa.controller;

import java.io.File;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kh.cocoa.dao.FilesDAO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.statics.Configurator;

@RestController
@RequestMapping("/files")
public class FilesController {
	@Autowired
	HttpSession session;
	
	@Autowired
	private FilesDAO fdao;
	
/*	@RequestMapping("upload.files")
	public String upload(@RequestParam("upload") MultipartFile upload) throws Exception{
		String fileRoot = Configurator.boardFileRoot; // 파일 저장 경로
		String oriName = upload.getOriginalFilename(); // 기존 파일명
		String extension = oriName.substring(oriName.lastIndexOf(".")); // 파일 확장명
		oriName = new String(oriName.getBytes("8859_1"),"UTF8");
	    String savedName = UUID.randomUUID() +extension;
	    InputStream fileStream = upload.getInputStream();
		FilesDTO fdto = new FilesDTO(0, oriName, savedName,null, 0,0,0);
		int result = fdao.uploadFiles(fdto);
		if(result >0) {
	         System.out.println(result);
		}
		 File filesPath = new File(fileRoot); 
	      if(!filesPath.exists()) {filesPath.mkdir();} 
	      File targetLoc = new File(fileRoot + savedName);
	      FileUtils.copyInputStreamToFile(fileStream, targetLoc);
	      fileStream.close();
	      return "Success";
	}*/
}
