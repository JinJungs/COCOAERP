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
	private NotificationBoardService nservice;
	@Autowired
	private FilesService fservice;

	//게시판
	@RequestMapping("notificationBoardList.no") 
	public String notificationBoardList(BoardDTO dto,FilesDTO fdto,int menu_seq, String cpage,Model model) { 
		if(cpage==null) {cpage="1";} 

		//게시글 불러오기
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		list = nservice.getNotificationBoardListCpage(cpage,menu_seq);

		//시작 & 끝 페이지 불러오기
		String navi = nservice.getNavi(Integer.parseInt(cpage),menu_seq);
		
		model.addAttribute("navi",navi);
		model.addAttribute("cpage",cpage);
		model.addAttribute("list",list);
		model.addAttribute("menu_seq",menu_seq);

		if(menu_seq==1) { //게시판 seq가 1인 경우 - 회사소식
			return "community/notificationBoardList"; 
		}else if(menu_seq==2) {//게시판 seq가 2인 경우 - 자유게시판
			return "community/cocoaWorksBoardList"; 
		}else if(menu_seq==3) {//게시판 seq가 3인 경우 - 앨범게시판
			if(cpage==null) {cpage="1";} 
			//게시글 불러오기
			List<BoardDTO> albumList = new ArrayList<BoardDTO>();
			albumList = nservice.getAlbumBoardListCpage(cpage,menu_seq);
			System.out.println("앨범게시판 게시글? "+albumList.size());
			//시작 & 끝 페이지 불러오기
			String albumNavi = nservice.getNavi(Integer.parseInt(cpage),menu_seq);
			
			//앨범게시판 이미지 불러오기
			//FilesDTO fdtoImg = fservice.getImage(fdto.getBoard_seq());
			
			//String imgUrl = "/boardRepository/" + fdtoImg.getSavedname();
			model.addAttribute("albumNavi",albumNavi);
			model.addAttribute("albumList",albumList);
			//model.addAttribute("imgUrl",imgUrl);
			
			return "community/albumBoardList";
		}
		return "index";
	}

	//게시글 읽기
	@RequestMapping("notificationBoardRead.no")
	public String notificationBoardRead(String cpage,BoardDTO dto,FilesDTO fdto, Model model) {

		if(cpage==null) {cpage="1";}
		//seq로 게시글 수 확인
		int isExistReadPage = nservice.isExistReadPage(dto.getMenu_seq());
		if(isExistReadPage>0) {
			//게시글에 업로드된 파일 갯수 확인
			int isExistUploadFile = fservice.isExistUploadFile(fdto);

			//게시글에 업로드된 첨부파일 리스트 불러오기
			List<FilesDTO> fileList = fservice.getFilesBySeq(fdto);

			//조회수 올리기
			nservice.notificationBoardViewCount(dto);

			//seq으로 게시글 내용 가져와서 내용 뿌려주기
			BoardDTO bdto = nservice.notificationBoardContentsSelect(dto);

			model.addAttribute("dto",bdto);
			model.addAttribute("cpage",cpage);
			model.addAttribute("seq",dto.getSeq());
			model.addAttribute("fileList", fileList);
			model.addAttribute("fileCount",isExistUploadFile);
		}

		if(dto.getMenu_seq()==1) { //게시판 seq가 1인 경우 - 회사소식
			return "community/notificationBoardRead";
		}else if(dto.getMenu_seq()==2) { //게시판 seq가 2인 경우 - 자유게시판
			return "community/cocoaWorksBoardRead";
		}else if(dto.getMenu_seq()==3) {//게시판 seq가 3인 경우 - 앨범게시판
			return "community/albumBoardRead";
		}
		return "index";
	}

	//게시글 검색
		@GetMapping("notificationBoardSearch.no")
		public String notificationBoardSearch(String cpage, String search,String searchBy,int menu_seq, Model model) {
			if(cpage==null) {cpage = "1";}
			List<BoardDTO> list = nservice.notificationBoardListBySearch(search,searchBy,menu_seq,Integer.parseInt(cpage));
			String navi= nservice.notificationBoardSearchNavi(menu_seq,Integer.parseInt(cpage), searchBy,search);
			model.addAttribute("list", list);
			model.addAttribute("navi", navi);
			model.addAttribute("cpage", cpage);
			model.addAttribute("search", search);
			
			if(menu_seq==1) { //게시판 seq가 1인 경우 - 회사소식
				return "community/notificationBoardList"; 

			}else if(menu_seq==2) {//게시판 seq가 2인 경우 - 자유게시판
				return "community/cocoaWorksBoardList"; 
			}else if(menu_seq==3) {//게시판 seq가 3인 경우 - 앨범게시판
				List<BoardDTO> albumList = nservice.notificationBoardListBySearch(search,searchBy,menu_seq,Integer.parseInt(cpage));
				String albumNavi= nservice.notificationBoardSearchNavi(menu_seq,Integer.parseInt(cpage), searchBy,search);
				model.addAttribute("albumList", albumList);
				model.addAttribute("albumNavi", albumNavi);
				model.addAttribute("cpage", cpage);
				model.addAttribute("search", search);
				return "community/albumBoardList";
			}
			return "index";
		}
	
		//게시글 작성 페이지 이동
		@RequestMapping("notificationBoardCreate.no")
		public String notificationBoardCreate(String cpage,int menu_seq, Model model) {
			if(cpage==null) {cpage="1";}
			model.addAttribute("cpage",cpage);
			model.addAttribute("menu_seq",menu_seq);

			if(menu_seq==1) { //게시판 seq가 1인 경우 - 회사소식
				return "community/notificationBoardCreate";

			}else if(menu_seq==2) {//게시판 seq가 2인 경우 - 자유게시판
				return "community/cocoaWorksBoardCreate"; 
			}else if(menu_seq==3) {//게시판 seq가 3인 경우 - 앨범게시판
				return "community/albumBoardCreate";
			}
			return "index";
		}
		//게시글 작성 완료
		@RequestMapping("notificationBoardCreateDone.no")
		public String notificationBoardCreateDone(BoardDTO bdto, int menu_seq,List<MultipartFile> file,Model model) throws Exception {
			//board & files seq값 동일하게 맞추기
			int noBoard_seq = nservice.noBoardSelectSeq();
			//bdto.setSeq(noBoard_seq); //bdto에 생성된 seq담기
	
			//글 작성 
			int done = nservice.notificationBoardCreateDone(noBoard_seq,bdto,menu_seq);
			if(file!=null) { //파일이 있을 때
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
							FilesDTO fdto = new FilesDTO(0, oriName, savedName,null, noBoard_seq,0,0,0);
	
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
			return "redirect:/noBoard/notificationBoardList.no?menu_seq="+menu_seq;
		}
	
	
		//게시글 수정
		@RequestMapping("notificationBoardModify.no")
		public String notificationBoardModify(int menu_seq,BoardDTO dto,FilesDTO fdto,int cpage,Model model) {
			//seq으로 제목,작성자,날짜,내용 가져오기
			BoardDTO bdto = nservice.notificationBoardContentsSelect(dto);
			//게시글에 업로드된 첨부파일 리스트 불러오기
			List<FilesDTO> fileList = fservice.getFilesBySeq(fdto);
			model.addAttribute("dto",bdto);
			model.addAttribute("cpage",cpage);
			model.addAttribute("seq",dto.getSeq());
			model.addAttribute("fileList", fileList);
			model.addAttribute("menu_seq",menu_seq);
			
			if(dto.getMenu_seq()==1) { //게시판 seq가 1인 경우 - 회사소식
				return "community/notificationBoardModify";

			}else if(dto.getMenu_seq()==2) {//게시판 seq가 2인 경우 - 자유게시판
				return "community/cocoaWorksBoardModify"; 
			}else if(menu_seq==3) {//게시판 seq가 3인 경우 - 앨범게시판
				return "community/albumBoardModify";
			}
			return "index";
		}
		//게시글 수정 완료
		@RequestMapping("notificationBoardModifyDone.no")
		public String notificationBoardModifyDone(int[] delArr,BoardDTO dto,FilesDTO fdto, List<MultipartFile> file,Model model) throws IOException {
			int seq = fdto.getBoard_seq();
			System.out.println("여기서 seq값은? "+seq);
			//수정된 글 업로드
			nservice.notificationBoardContentsModify(dto);
	
			//seq로 게시글 수 확인
			int isExistReadPage = nservice.isExistReadPage(dto.getMenu_seq());
			if(isExistReadPage>0) {
				//게시글에 업로드된 파일 갯수 확인
				int isExistUploadFile = fservice.isExistUploadFile(fdto);
	
				//게시글에 업로드된 첨부파일 리스트 불러오기
				List<FilesDTO> fileList = fservice.getFilesBySeq(fdto);
	
				/*------------------파일 수정--------------*/
				//파일 삭제 - 파일의 seq로 삭제
				if (delArr != null) {
					System.out.println("선택된 갯수? "+delArr.length);
					int fileDelResult = 0;
					for (int i = 0; i < delArr.length; i++) {
						fileDelResult += fservice.deleteNotificationBoardFiles(delArr[i]);
					}
					System.out.println("파일 삭제 :" +fileDelResult);
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
							FilesDTO fdto1 = new FilesDTO(0, oriName, savedName,null, seq,0,0,0);
	
							int result = fservice.uploadFiles(seq,fdto1);
							if (result > 0) {
								File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
								FileCopyUtils.copy(mf.getBytes(), targetLoc);
							}
						}
					}
				}
				model.addAttribute("cpage", 1);
			}
			return "redirect:/noBoard/notificationBoardList.no?menu_seq="+dto.getMenu_seq();
	
		}
	//회사공지 게시글 삭제 (관리자 ONLY)
	@RequestMapping("notificationBoardDelete.no")
	public String notificationBoardDelete(int seq,int menu_seq,int cpage,Model model) {
		//게시글 삭제
		int result = nservice.notificationBoardContentsDel(seq);
		
		//파일 삭제 - 파일의 seq로 삭제
		int fileDelResult = fservice.deleteNotificationBoardFiles(seq);
		
		model.addAttribute("cpage",cpage);
		model.addAttribute("seq",seq);
		model.addAttribute("menu_seq",menu_seq);
		return "redirect:/noBoard/notificationBoardList.no?menu_seq="+menu_seq;
	}
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}
