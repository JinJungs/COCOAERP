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

}
