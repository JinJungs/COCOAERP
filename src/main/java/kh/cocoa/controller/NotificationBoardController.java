package kh.cocoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.FilesService;
import kh.cocoa.service.NotificationBoardService;
import kh.cocoa.statics.Configurator;

@Controller
@RequestMapping("/noBoard")
public class NotificationBoardController {

	@Autowired
	NotificationBoardService nservice;
	@Autowired
	FilesService fservice;

	//회사공지 게시판
	@RequestMapping("notificationBoardList.no") 
	public String notificationBoardList(String cpage,Model model) { 
		if(cpage==null) {cpage="1";}     
		//게시글 불러오기

		List<BoardDTO> list = new ArrayList<BoardDTO>();
		list = nservice.getNotificationBoardListCpage(cpage);
		
		//시작 & 끝 페이지 불러오기
		String navi = nservice.getNavi(Integer.parseInt(cpage));
		
		model.addAttribute("navi",navi);
		model.addAttribute("cpage",cpage);
		model.addAttribute("list",list);
		return "community/notificationBoardList"; 
	}

	//회사공지 게시글 읽기
	@RequestMapping("notificationBoardRead.no")
	public String notificationBoardRead(String cpage,int seq, Model model) {
		if(cpage==null) {cpage="1";}
		//seq로 게시글 수 확인
		int isExistReadPage = nservice.isExistReadPage(seq);

		if(isExistReadPage>0) {
			//게시글에 업로드된 파일 갯수 확인
			int isExistUploadFile = fservice.isExistUploadFile(seq);

			//게시글에 업로드된 첨부파일 리스트 불러오기
			List<FilesDTO> fileList = fservice.getFilesBySeq(seq);

			//조회수 올리기
			nservice.notificationBoardViewCount(seq);

			//seq으로 게시글 내용 가져와서 내용 뿌려주기
			BoardDTO dto = nservice.notificationBoardContentsSelect(seq);

			model.addAttribute("dto",dto);
			model.addAttribute("cpage",cpage);
			model.addAttribute("seq",seq);
			model.addAttribute("fileList", fileList);
			model.addAttribute("fileCount",isExistUploadFile);
		}
		return "community/notificationBoardRead";
	}

	//회사공지 게시글 검색
	@GetMapping("notificationBoardSearch.no")
	public String notificationBoardSearch(String cpage, String search,String searchBy, Model model) {

		if(cpage==null) {cpage = "1";}
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		list = nservice.notificationBoardListBySearch(Integer.parseInt(cpage), search,searchBy);
		String navi= nservice.notificationBoardSearchNavi(Integer.parseInt(cpage), search,searchBy);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("search", search);
		return "community/notificationBoardList";
	}

	//회사공지 작성 페이지 이동
	@RequestMapping("notificationBoardCreate.no")
	public String notificationBoardCreate(int cpage, Model model) {
		model.addAttribute("cpage",cpage);
		return "community/notificationBoardCreate";
	}
	//회사공지 작성 완료
	@RequestMapping("notificationBoardCreateDone.no")
	public String notificationBoardCreateDone(BoardDTO bdto, List<MultipartFile> file,Model model) throws Exception {
		//board & files seq값 동일하게 맞추기
		int noBoard_seq = nservice.noBoardSelectSeq();
		//bdto.setSeq(noBoard_seq); //bdto에 생성된 seq담기

		//글 작성 
		nservice.notificationBoardCreateDone(noBoard_seq,bdto);
		if(file!=null) { //파일이 있을 때
			System.out.println(file);
			//파일 업로드 할 갯수 확인
			int filesCount = 0;
			for (MultipartFile mf : file) {
				if (!mf.isEmpty()) {
					filesCount += 1;
				}
			}
			//submit을 눌렀을 때, 업로드할 file이 있는 경우만 files에 업로드 (최대 10개)
			if(filesCount<11){
				if (!file.get(0).isEmpty()) { //파일추가 없이 글쓰기 
					String fileRoot = Configurator.boardFileRoot; //파일 저장할 경로
					File filesPath = new File(fileRoot);
					//폴더 없으면 만들기
					if(!filesPath.exists()) {filesPath.mkdir();}


					for (MultipartFile mf : file) {
						String oriName = mf.getOriginalFilename();
						String uid = UUID.randomUUID().toString().replaceAll("-", "");
						String savedName = uid + "-" + oriName;
						// dto에 값을 담아서 db에 전송
						FilesDTO fdto = new FilesDTO(0, oriName, savedName,null, noBoard_seq,0,0);

						int result = fservice.uploadFiles(noBoard_seq,fdto);
						if (result > 0) {
							File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
							FileCopyUtils.copy(mf.getBytes(), targetLoc);
						}
					}
				}
			}
		}
		model.addAttribute("cpage", 1);
		return "redirect:/noBoard/notificationBoardList.no";
	}


	//회사공지 게시글 수정 (관리자 ONLY)
	@RequestMapping("notificationBoardModify.no")
	public String notificationBoardModify(int seq,int cpage,Model model) {

		//seq으로 제목,작성자,날짜,내용 가져오기
		BoardDTO dto = nservice.notificationBoardContentsSelect(seq);
		//게시글에 업로드된 첨부파일 리스트 불러오기
		List<FilesDTO> fileList = fservice.getFilesBySeq(seq);
		model.addAttribute("dto",dto);
		model.addAttribute("cpage",cpage);
		model.addAttribute("seq",seq);
		model.addAttribute("fileList", fileList);

		return "community/notificationBoardModify";
	}
	//회사공지 게시글 수정 완료 (관리자 ONLY)
	@RequestMapping("notificationBoardModifyDone.no")
	public String notificationBoardModifyDone(int seq,int[] delArr,BoardDTO dto, List<MultipartFile> file,Model model) throws IOException {

		//수정된 글 업로드
		nservice.notificationBoardContentsModify(dto);

		//seq로 게시글 수 확인
		int isExistReadPage = nservice.isExistReadPage(seq);
		if(isExistReadPage>0) {
			//게시글에 업로드된 파일 갯수 확인
			int isExistUploadFile = fservice.isExistUploadFile(seq);

			//게시글에 업로드된 첨부파일 리스트 불러오기
			List<FilesDTO> fileList = fservice.getFilesBySeq(seq);

			/*------------------파일 수정--------------*/
			//파일 삭제 - 파일의 seq로 삭제
			if (delArr != null) {
				int fileDelResult = 0;
				for (int i = 0; i < delArr.length; i++) {
					fileDelResult += fservice.deleteNotificationBoardFiles(delArr[i]);
				}
			}
			//파일 추가
			if(file!=null) {

				if (!file.get(0).isEmpty()) { //파일추가 없이 글쓰기 
					String fileRoot = Configurator.boardFileRoot; //파일 저장할 경로
					File filesPath = new File(fileRoot);
					//폴더 없으면 만들기
					if(!filesPath.exists()) {filesPath.mkdir();}
					for (MultipartFile mf : file) {
						String oriName = mf.getOriginalFilename();
						String uid = UUID.randomUUID().toString().replaceAll("-", "");
						String savedName = uid + "-" + oriName;
						// dto에 값을 담아서 db에 전송
						FilesDTO fdto = new FilesDTO(0, oriName, savedName,null, seq,0,0);

						int result = fservice.uploadFiles(seq,fdto);
						if (result > 0) {
							File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
							FileCopyUtils.copy(mf.getBytes(), targetLoc);
						}
					}
				}
			}
			model.addAttribute("cpage", 1);
		}
		return "redirect:/noBoard/notificationBoardList.no";

	}
	//회사공지 게시글 삭제 (관리자 ONLY)
	@RequestMapping("notificationBoardDelete.no")
	public String notificationBoardDelete(int seq,int cpage,Model model) {
		int result = nservice.notificationBoardContentsDel(seq);

		model.addAttribute("cpage",cpage);
		model.addAttribute("seq",seq);
		return "redirect:/noBoard/notificationBoardList.no";
	}
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
