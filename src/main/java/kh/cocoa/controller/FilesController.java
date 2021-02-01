package kh.cocoa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.cocoa.dto.FilesDTO;
import kh.cocoa.dto.MessageDTO;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;

@RestController
@RequestMapping("/files")
public class FilesController {
	@Autowired 
	private FilesService fservice;
	
	@RequestMapping("/downloadNotificationBoardFiles.files")
	public void downloadHwFiles(FilesDTO dto, HttpServletResponse resp) throws IOException {
		System.out.println("요청된 파일Seq: " + dto.getSeq());
		System.out.println("요청된 파일 SavedName: " + dto.getSavedname());

		String filePath = Configurator.boardFileRoot;
		File targetFile = new File(filePath + "/" + dto.getSavedname());
		// 다음 위치에 있는 파일을 파일 객체로 만든다 -> 정보를 뽑아낼 수 있게 하기 위해서
		String oriName = dto.getOriname();
		oriName = new String(oriName.getBytes("UTF-8"), "ISO-8859-1");
		if (targetFile.exists() && targetFile.isFile()) {
			resp.setContentType("application/octet-stream; charset=utf8");
			// 마치 우리가 html문서라고 명시하고 text문서를 웹브라우저에 전송하게 되면 알아서 해주는 것처럼
			// 지금 text 보내는게 아니라 파일의 내용이니까 utf-8으로 렌더링하라고 전달
			resp.setContentLength((int) targetFile.length());
			resp.setHeader("Content-Disposition", "attachment; filename=\"" +oriName+ "\"");
			// 다운로드 받을 때 컴퓨터에 저장될 이름을 설정
			FileInputStream fis = new FileInputStream(targetFile);
			ServletOutputStream sos = resp.getOutputStream();
			FileCopyUtils.copy(fis, sos);
			fis.close();
			sos.flush();
			sos.close();
		}
	}
	
//=== Messenger =======================================================
	
	@RequestMapping("insertMessengerFile.files")
    public String insertMessageFile(MessageDTO msgdto, MultipartFile file) throws IOException{
    	int resultF = 0;
    	String oriName = "";
    	System.out.println("파일 컨트롤러 insertMessengerFile 도착");
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
    			oriName = file.getOriginalFilename();
    			String uid = UUID.randomUUID().toString().replaceAll("-", "");
    			String savedName = uid + "-" + oriName;
    	    	//파일 dto 인서트
    			FilesDTO fdto = new FilesDTO().builder().oriname(oriName).savedname(savedName).build();
    			resultF = fservice.uploadFilesMsg(fdto); 
    			System.out.println("resultF : "+resultF);
    			//03. 02가 성공하면 지정 경로에 파일 저장
    			if (resultF > 0) {
    				File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
    				FileCopyUtils.copy(file.getBytes(), targetLoc);
    				System.out.println("FilesController insertMessageFile 파일 저장 성공");
    			}
    		}
        }else {
        	System.out.println("FilesController insertMessageFile 에러발생");
        }
    	
    	JsonObject obj = new JsonObject();
        obj.addProperty("resultF", resultF);
        obj.addProperty("oriName", oriName);
        return new Gson().toJson(obj);
    }
	
	@RequestMapping("/uploadMessengerFile.files")
	public void upload( @RequestParam("fileUpload") MultipartFile file ) throws IOException {
		System.out.println("파일컨트롤러 uploadMessengerFile 도착");
		System.out.println("File : "+file);
    	int resultF = 0;
    	String fileRoot = Configurator.messengerFileRoute; //파일 저장할 경로
		File filesPath = new File(fileRoot);
		//폴더 없으면 만들기
		if(!filesPath.exists()) {filesPath.mkdir();}
		
		if(file!=null) {
	    	//01-1.파일에 대한 정보 Files 테이블에 저장
			String oriName = file.getOriginalFilename();
			String uid = UUID.randomUUID().toString().replaceAll("-", "");
			String savedName = uid + "-" + oriName;
			
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
		System.out.println("파일컨트롤러 업로드 resultF : " +resultF);
	}

	//=== Community =======================================================
	@RequestMapping("/downloadMessengerFile.files")
	public void downloadMsgFile(FilesDTO dto, HttpServletResponse resp) throws IOException {
		System.out.println("요청된 파일Seq: " + dto.getSeq());
		System.out.println("요청된 파일 SavedName: " + dto.getSavedname());

		String filePath = Configurator.messengerFileRoute;
		File targetFile = new File(filePath + "/" + dto.getSavedname());
		// 다음 위치에 있는 파일을 파일 객체로 만든다 -> 정보를 뽑아낼 수 있게 하기 위해서
		String oriName = dto.getOriname();
		oriName = new String(oriName.getBytes("UTF-8"), "ISO-8859-1");
		if (targetFile.exists() && targetFile.isFile()) {
			resp.setContentType("application/octet-stream; charset=utf8");
			// 마치 우리가 html문서라고 명시하고 text문서를 웹브라우저에 전송하게 되면 알아서 해주는 것처럼
			// 지금 text 보내는게 아니라 파일의 내용이니까 utf-8으로 렌더링하라고 전달
			resp.setContentLength((int) targetFile.length());
			resp.setHeader("Content-Disposition", "attachment; filename=\"" +oriName+ "\"");
			// 다운로드 받을 때 컴퓨터에 저장될 이름을 설정
			FileInputStream fis = new FileInputStream(targetFile);
			ServletOutputStream sos = resp.getOutputStream();
			FileCopyUtils.copy(fis, sos);
			fis.close();
			sos.flush();
			sos.close();
		}
	}
}
