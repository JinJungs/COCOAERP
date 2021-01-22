package kh.cocoa.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@Autowired
	private HttpSession session;

	//회사공지 게시판
	@RequestMapping("notificationBoardList.no") 
	public String notificationBoardList(String cpage,Model model) { 
		if(cpage==null) {cpage="1";}     
		//게시글 불러오기
		List<BoardDTO> list = nservice.getNotificationBoardListCpage(cpage);
		//System.out.println(list.get(0).getSeq());
		//시작 & 끝 페이지 불러오기
		String navi = nservice.getNavi(Integer.parseInt(cpage));

		model.addAttribute("navi",navi);
		model.addAttribute("cpage",cpage);
		model.addAttribute("list",list);
		return "/community/notificationBoardList"; 
	}

	//회사공지 게시글 읽기
	@RequestMapping("notificationBoardRead.no")
	public String notificationBoardRead(int cpage,int seq, Model model) {
		System.out.println("게시글 읽기 컨트롤러 도착");
		//seq으로 게시글 내용 가져와서 내용 뿌려주기
		BoardDTO dto = nservice.notificationBoardContentsSelect(seq);
		System.out.println("게시글 내용은? "+dto);

		//조회수 올리기
		System.out.println("seq 값은 ?"+seq);
		nservice.notificationBoardViewCount(seq);

		model.addAttribute("dto",dto);
		//작성자 뿌려주기(model만들어야함)

		model.addAttribute("cpage",cpage);
		model.addAttribute("seq",seq);		
		return "community/notificationBoardRead";
	}
	//회사공지 게시글 검색
	@GetMapping("notificationBoardSearch.no")
	public String notificationBoardSearch(String cpage, String search,String searchBy, Model model) {
		System.out.println("searchBy 는?"+ searchBy);
		System.out.println("search 는?" + search);	

		if(cpage==null) {cpage = "1";}
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		list = nservice.notificationBoardListBySearch(Integer.parseInt(cpage), search,searchBy);
		System.out.println("여기서 list는?"+list);
		String navi= nservice.notificationBoardSearchNavi(Integer.parseInt(cpage), search,searchBy);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("cpage", cpage);
		model.addAttribute("search", search);
		return "/community/notificationBoardList";
	}

	//회사공지 작성 페이지 이동
	@RequestMapping("notificationBoardCreate.no")
	public String notificationBoardCreate(int cpage, Model model) {
		System.out.println("글작성 컨트롤러");
		model.addAttribute("cpage",cpage);
		return "community/notificationBoardCreate";
	}
	//회사공지 작성 완료
	@RequestMapping("notificationBoardCreateDone.no")
	public String notificationBoardCreateDone(BoardDTO bdto,List<MultipartFile> file,Model model) throws Exception {
		System.out.println("글작성 완료 컨트롤러");
		//파일 업로드 할 갯수 확인
		int filesCount = 0;
		for (MultipartFile mf : file) {
			if (!mf.isEmpty()) {
				filesCount += 1;
			}
		}
		//board & files seq값 동일하게 맞추기
		int noBoard_seq = nservice.noBoardSelectSeq();
		//bdto.setSeq(noBoard_seq); //bdto에 생성된 seq담기
		//글 작성 
		nservice.notificationBoardCreateDone(noBoard_seq,bdto);

		//submit을 눌렀을 때, 업로드할 file이 있는 경우만 files에 업로드 (최대 10개)
		if(filesCount<11){
			if(!file.get(0).isEmpty()) {
				String fileRoot = Configurator.boardFileRoot; //파일 저장할 경로
				File filesPath = new File(fileRoot);
				//폴더 없으면 만들기
				if(!filesPath.exists()) {filesPath.mkdir();}

				int result = 0;
				for (MultipartFile mf : file) {
					String oriName = mf.getOriginalFilename();
					String uid = UUID.randomUUID().toString().replaceAll("-", "");
					String savedName = uid + "-" + oriName;
					// dto에 값을 담아서 db에 전송
					FilesDTO fdto = new FilesDTO(0, oriName, savedName,null, noBoard_seq,0,0);
					System.out.println(fdto.getOriname() + fdto.getSavedname() + fdto.getBoard_seq());
					result = fservice.uploadFiles(noBoard_seq,fdto);
					if (result > 0) {
						File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
						FileCopyUtils.copy(mf.getBytes(), targetLoc);
					}
				}
			}
		}
		model.addAttribute("cpage", 1);
		return "redirect:/noBoard/notificationBoardList.no";
	}
	//회사공지 게시글 수정 (관리자 ONLY)
	@RequestMapping("notificationBoardModify.no")
	public String notificationBoardModify(BoardDTO dto,int seq,int cpage,Model model) {
		System.out.println("게시글 수정 컨트롤러");
		//seq으로 제목,작성자,날짜,내용 가져오기
		BoardDTO bdto = nservice.notificationBoardContentsSelect(seq);

		model.addAttribute("bdto",bdto);
		model.addAttribute("cpage",cpage);
		model.addAttribute("seq",seq);
		return "community/notificationBoardModify";
	}
	//회사공지 게시글 수정 완료 (관리자 ONLY)
	@RequestMapping("notificationBoardModifyDone.no")
	public String notificationBoardModifyDone(BoardDTO dto,int seq,int cpage,Model model) {
		System.out.println("게시글 수정 완료 컨트롤러");
		System.out.println(seq);
		//변경할 글 업뎃
		nservice.notificationBoardContentsModify(dto);
		model.addAttribute("cpage",cpage);
		return "redirect:/noBoard/notificationBoardList.no";

	}
	//회사공지 게시글 삭제 (관리자 ONLY)
	@RequestMapping("notificationBoardDelete.no")
	public String notificationBoardDelete(int seq,int cpage,Model model) {
		System.out.println("게시글 삭제 컨트롤러");
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
