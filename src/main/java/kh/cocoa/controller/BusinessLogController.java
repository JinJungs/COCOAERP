package kh.cocoa.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kh.cocoa.dto.BoardDTO;
import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.BusinessLogService;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;

@Controller
@RequestMapping("/log")
public class BusinessLogController {

	@Autowired
	private BusinessLogService bservice;

	@Autowired
	private FilesService fservice;

	@Autowired
	private HttpSession session;

	//업무일지 작성 페이지로 이동
	@RequestMapping("logCreate.log")
	public String logCreate() {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");

		int writer_code = (Integer)loginDTO.getCode();

		return "businessLog/logCreate";
	}
	//업무일지 임시보관 작성 완료
	@RequestMapping("logTempSave.log")
	public String logTempSave(DocumentDTO ddto,String selectBy,List<MultipartFile> file) throws Exception {
		System.out.println("업무일지 임시보관 컨트롤러 도착");
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		ddto.setWriter_code(writer_code);
		//문서저장에 필요한 dept_code
		int dept_code = (Integer)loginDTO.getDept_code();
		ddto.setDept_code(dept_code);

		//업무일지 seq & files doc_seq 맞추기
		int logDoc_seq= bservice.logDocSelectSeq();

		//임시 문서 저장
		int tempSavedLog = bservice.tempSavedLog(logDoc_seq,ddto,selectBy);
		//파일 업로드
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
						FilesDTO fdto = new FilesDTO(0, oriName, savedName,null,0,logDoc_seq,0,0);

						int result = fservice.uploadFilesBusinessLog(logDoc_seq,fdto);
						if (result > 0) {
							File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
							FileCopyUtils.copy(mf.getBytes(), targetLoc);
						}
					}
				}
			}
		}
		return "businessLog/logCreate"; //경로 바꿔줘야함
	}
	//업무일지 작성 완료
	@RequestMapping("logCreateDone.log")
	public String logCreateDone(DocumentDTO ddto,String selectBy,List<MultipartFile> file) throws Exception {
		System.out.println(ddto.getReport_end());
		System.out.println("업무일지 작성 컨트롤러 도착");
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		ddto.setWriter_code(writer_code);
		//문서저장에 필요한 dept_code
		int dept_code = (Integer)loginDTO.getDept_code();
		ddto.setDept_code(dept_code);

		if(selectBy.contentEquals("daily")) {
			System.out.println("일일인 경우");
			ddto.setReport_end(null);
			System.out.println("변경후 :"+ddto.getReport_end());
		}

		//업무일지 seq & files doc_seq 맞추기
		int logDoc_seq= bservice.logDocSelectSeq();

		//업무일지 종류에 따라 문서 저장
		int createLog = bservice.createLog(logDoc_seq,ddto,selectBy);
		System.out.println("결과는?" +createLog);

		//파일 업로드
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
						FilesDTO fdto = new FilesDTO(0, oriName, savedName,null,0,logDoc_seq,0,0);

						int result = fservice.uploadFilesBusinessLog(logDoc_seq,fdto);
						if (result > 0) {
							File targetLoc = new File(filesPath.getAbsolutePath() + "/" + savedName);
							FileCopyUtils.copy(mf.getBytes(), targetLoc);
						}
					}
				}
			}
		}
		return "businessLog/logCreate"; //경로 바꿔줘야함
	}
	//업무일지 읽기
	@RequestMapping("logRead.log")
	public String logRead(int seq,Model model, String status, DocumentDTO ddto, FilesDTO fdto) {
		System.out.println("읽기 페이지 도착");
		System.out.println("여기서 seq?"+seq);
		
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");

		int writer_code = (Integer)loginDTO.getCode();
		System.out.println(writer_code);
		//로그인한 정보의 code를 DocumentDTO writer_code에 넣어주기
		ddto.setWriter_code(writer_code);
		
		//업무일지 자료 가져오기
		List<BoardDTO> logRead = bservice.getLogBySeq(seq);
		System.out.println("자료 가져오기 성공?" +logRead);

		//게시글에 업로드된 파일 갯수 확인
		int getLogUploadFileCount = fservice.getLogUploadFileCount(fdto);

		//업로드된 파일 가져오기
		List<FilesDTO> fileList = fservice.getLogFilesBySeq(seq,fdto);
		System.out.println("파일가져오기 성공?"+fileList.size());
		
		//수정버튼 - 작성자인 경우만 보임
		//int checkWriter = bservice.checkWriter(ddto);

		model.addAttribute("status",status);
		//model.addAttribute("checkWriter",checkWriter);
		model.addAttribute("lr",logRead);
		model.addAttribute("fileList",fileList);
		model.addAttribute("fileCount",getLogUploadFileCount);
		return "businessLog/logRead";
	}
	//요청 받은 업무일지 읽기
	@RequestMapping("logReqRead.log")
	public String logReqRead() {
		return "businessLog/logReqRead";
	}
	//업무일지 수정 & 임시저장된 문서 수정
	@RequestMapping("logModify.log")
	public String logModify(int seq,DocumentDTO dto,FilesDTO fdto, Model model) {
		System.out.println("수정 페이지" +seq);

		//업무일지 자료 가져오기
		DocumentDTO logRead = bservice.getLogBySeqMod(seq,dto);
		System.out.println("자료 가져오기 성공?" +logRead);

		//업로드된 파일 가져오기
		List<FilesDTO> fileList = fservice.getLogFilesBySeq(seq,fdto);
		System.out.println("파일가져오기 성공?"+fileList);
		model.addAttribute("lr",logRead);
		model.addAttribute("fileList",fileList);
		
		return "businessLog/logModify";
	}
	//보관함 (임시저장 / 업무일지 / 확인요청)
	@RequestMapping("logBoard.log")
	public String logTempBoard(String status,Model model) {
		EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
		int writer_code = (Integer)loginDTO.getCode();
		System.out.println(writer_code);
		System.out.println("보관함 종류 : "+status);
		//글 전체 리스트
		List<BoardDTO> logAllList = bservice.getLogAllList(status);
		//일일 리스트 불러오기 
		List<BoardDTO> dailyList = bservice.dailyList(status);
		//주간 리스트 불러오기
		List<BoardDTO> weeklyList = bservice.weeklyList(status);
		//월별 리스트 불러오기
		List<BoardDTO> monthlyList = bservice.monthlyList(status);

		model.addAttribute("status",status);
		model.addAttribute("logAllList",logAllList);
		model.addAttribute("dailyList",dailyList);
		model.addAttribute("weeklyList",weeklyList);
		model.addAttribute("monthlyList",monthlyList);
		return "businessLog/logBoard";
	}
	
	//보낸 업무일지 보관함 	
	@RequestMapping("logSentBoard.log")
	public String logSentBoard(Model model) {
		//전체
		List<BoardDTO> sentLogAllList = bservice.sentLogAllList();
		//일일
		List<BoardDTO> sentLogDailyList = bservice.sentLogDailyList();
		//주간
		List<BoardDTO> sentLogWeeklyList = bservice.sentLogWeeklyList();
		//월별
		List<BoardDTO> sentLogMonthlyList = bservice.sentLogMonthlyList();

		model.addAttribute("logAllList",sentLogAllList);
		model.addAttribute("dailyList",sentLogDailyList);
		model.addAttribute("weeklyList",sentLogWeeklyList);
		model.addAttribute("monthlyList",sentLogMonthlyList);
		return "businessLog/logSentBoard";
	}
}