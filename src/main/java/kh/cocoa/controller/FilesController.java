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
import org.springframework.web.bind.annotation.ExceptionHandler;
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

		String filePath = Configurator.boardFileRootC;
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
		
	//=== Community =======================================================
	
	
/* <a href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>*/
	//=== Message ========================================
	@RequestMapping("/downloadMessengerFile.files")
	public void downloadMsgFile(FilesDTO dto, HttpServletResponse resp) throws IOException {
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
	
    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }
}
