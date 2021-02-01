package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/log")
public class BusinessLogController {
	//업무일지 작성
	@RequestMapping("logCreate.log")
	public String logCreate() {
		return "businessLog/logCreate";
	}
	//업무일지 읽기
	@RequestMapping("logRead.log")
	public String logRead() {
		return "businessLog/logRead";
	}
	//요청 받은 업무일지 읽기
	@RequestMapping("logReqRead.log")
	public String logReqRead() {
		return "businessLog/logReqRead";
	}
	//업무일지 수정 & 임시저장된 문서 수정
	@RequestMapping("logModify.log")
	public String logModify() {
		return "businessLog/logModify";
	}
	//작성중 업무일지 보관함
	@RequestMapping("logTempBoard.log")
	public String logTempBoard() {
		return "businessLog/logTempBoard";
	}
	//업무일지 보관함
	@RequestMapping("logBoard.log")
	public String logBoard() {
		return "businessLog/logBoard";
	}
	//보낸 업무일지 보관함
	@RequestMapping("logSentBoard.log")
	public String logSentBoard() {
		return "businessLog/logSentBoard";
	}
	//확인요청 업무일지 보관함
	@RequestMapping("logReqBoard.log")
	public String logReqBoard() {
		return "businessLog/logReqBoard";
	}

}