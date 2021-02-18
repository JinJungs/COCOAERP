package kh.cocoa.service;

import java.sql.Date;
import java.util.*;

import kh.cocoa.dto.TemplatesDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.cocoa.dao.DocumentDAO;
import kh.cocoa.dto.DocumentDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.statics.DocumentConfigurator;

@Service
public class DocumentService implements DocumentDAO {

	@Autowired
	private DocumentDAO ddao;

	//임시저장한 문서
	@Override
	public List<DocumentDTO> getSearchTemporaryList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchTemporaryList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}

	//상신한 문서
	@Override
	public List<DocumentDTO> getSearchRaiseList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRaiseList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}

	//승인된 문서
	@Override
	public List<DocumentDTO> getSearchApprovalList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchApprovalList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}

	//반려된 문서
	@Override
	public List<DocumentDTO> getSearchRejectList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchRejectList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}

	//회수한 문서
	@Override
	public List<DocumentDTO> getSearchReturnList(int empCode, Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		endDate = plusOneDate(endDate); //end에 하루 더하기
		return ddao.getSearchReturnList(empCode, startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}

	//=================페이지네이션
	public String getSearchNavi(int empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status) {
		endDate = plusOneDate(endDate);
		int recordTotalCount = getSearchBoardCount(empCode, startDate, endDate, templateList, searchText, cpage, status);
		int pageTotalCount = recordTotalCount / DocumentConfigurator.recordCountPerPage;
		if (recordTotalCount % DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage - 1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}
		
		endDate = minusOneDate(endDate);
		//templateList 를 template로 넘기기
		String template = "";
		if(templateList.size()>1) {
			template = "0";
		}else {
			template = templateList.get(0);
		}
		
		StringBuilder sb = new StringBuilder();
		//temporary
		if (status.contentEquals("TEMP")) {
			if (needPrev) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage=" + (startNavi - 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage=" + i + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/d_searchTemporary.document?cpage=" + (endNavi + 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
			}
		}
		//raise
		else if (status.contentEquals("RAISE")) {
			if (needPrev) {
				sb.append("<a href=/document/d_searchRaise.document?cpage=" + (startNavi - 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/d_searchRaise.document?cpage=" + i + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/d_searchRaise.document?cpage=" + (endNavi + 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
			}
		}
		//confirm
		else if (status.contentEquals("CONFIRM")) {
			if (needPrev) {
				sb.append("<a href=/document/d_searchApproval.document?cpage=" + (startNavi - 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/d_searchApproval.document?cpage=" + i + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/d_searchApproval.document?cpage=" + (endNavi + 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
			}
		}
		//reject
		else if (status.contentEquals("REJECT")) {
			if (needPrev) {
				sb.append("<a href=/document/d_searchReject.document?cpage=" + (startNavi - 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/d_searchReject.document?cpage=" + i + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/d_searchReject.document?cpage=" + (endNavi + 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
			}
		}
		//return
		else if (status.contentEquals("RETURN")) {
			if (needPrev) {
				sb.append("<a href=/document/d_searchReturn.document?cpage=" + (startNavi - 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/d_searchReturn.document?cpage=" + i + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/d_searchReturn.document?cpage=" + (endNavi + 1) + "&status=" + status + "&template=" + template + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
			}
		}
		return sb.toString();
	}

	@Override
	public int getSearchBoardCount(int empCode, Date startDate, Date endDate, List<String> templateList, String searchText, int cpage, String status) {
		return ddao.getSearchBoardCount(empCode, startDate, endDate, templateList, searchText, cpage, status);
	}

	@Override
	public DocumentDTO getDocument(String seq) {
		return ddao.getDocument(seq);
	}
	@Override
	public String getStatusBySeq(String seq) {
		return ddao.getStatusBySeq(seq);
	}
	@Override
	public String getTemp_codeBySeq(String seq) {
		return ddao.getTemp_codeBySeq(seq);
	}
	//=====수정, 재상신================================
	@Override
	public int tempToUpdate(DocumentDTO dto, String temp_code, String submitType) {
		return ddao.tempToUpdate(dto, temp_code, submitType);
	}
	//================================================
	
	@Override
	public int ReturnDoc(String seq) {
		return ddao.ReturnDoc(seq);
	}
	
	@Override
	public List<DocumentDTO> getAllConfirmDoc(Date startDate, Date endDate, List<String> templateList, String searchOption, String searchText, int startRowNum, int endRowNum) {
		return ddao.getAllConfirmDoc(startDate, endDate, templateList, searchOption, searchText, startRowNum, endRowNum);
	}
	@Override
	public int getAllDocCount(Date startDate, Date endDate, List<String> templateList, String searchText, String searchOption,int cpage) {
		return ddao.getAllDocCount(startDate, endDate, templateList, searchOption, searchText, cpage);
	}
	//문서대장 페이지네이션
	public String getAllDocNavi(Date startDate, Date endDate, List<String> templateList,String searchOption, String searchText, int cpage) {
		endDate = plusOneDate(endDate);
		int recordTotalCount = getAllDocCount(startDate, endDate, templateList, searchOption, searchText, cpage);
		
		System.out.println("총 글개수 : " + recordTotalCount);
		
		int pageTotalCount = recordTotalCount / DocumentConfigurator.recordCountPerPage;
		if (recordTotalCount % DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage - 1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}
		
		endDate = minusOneDate(endDate);
		//templateList 를 template로 넘기기
		String template = "";
		if(templateList.size()>1) {
			template = "0";
		}else {
			template = templateList.get(0);
		}
		
		StringBuilder sb = new StringBuilder();
		if (needPrev) {
			sb.append("<a href=/document/allConfirmDoc.document?cpage=" + (startNavi - 1)  + "&template=" + template + "&searchOption=" + searchOption + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "><    </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href=/document/allConfirmDoc.document?cpage=" + i + "&template=" + template + "&searchOption=" + searchOption + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + "> " + i + " </a>");
		}
		if (needNext) {
			sb.append("<a href=/document/allConfirmDoc.document?cpage=" + (endNavi + 1) + "&template=" + template + "&searchOption=" + searchOption + "&startDate=" + startDate + "&endDate=" + endDate + "&searchText=" + searchText + ">   > </a>");
		}
		return sb.toString();
	}
	@Override
	public List<DocumentDTO> getAllDraftDocument(int empCode, List<String> templateList) {
		return ddao.getAllDraftDocument(empCode, templateList);
	}
	//+@
	//날짜 하루 더해주는 메서드(endDate에 이용)
	public Date plusOneDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		return new Date(cal.getTimeInMillis());
	}
	//날짜 하루 빼주는메서드(endDate에 이용)
		public Date minusOneDate(Date date) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, -1);
			return new Date(cal.getTimeInMillis());
		}
	//날짜 한달 빼주는 메서드(endDate에 이용)
		public Date minusOneMonth(Date date) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.MONTH, -1);
			return new Date(cal.getTimeInMillis());
		}
	//날짜 두개 비교해서 바꿔주는 메서드
	public List<Date> reInputDates(Date startDate, Date endDate) {
		if (endDate.before(startDate)) {
			Date temp = endDate;
			endDate = startDate;
			startDate = temp;
		}
		List<Date> list = new ArrayList<>();
		list.add(startDate);
		list.add(endDate);
		return list;
	}

	@Override
	public List<DocumentDTO> getLeaveListConfirmed() {
		return ddao.getLeaveListConfirmed();
	}
	@Override
	public void setProcessY(int seq) {
		ddao.setProcessY(seq);
		
	}
	@Override
	public void setProcessN(int seq) {
		ddao.setProcessN(seq);
	}
	
	//용국


	@Override
	public int addDocument(DocumentDTO dto) {
		return ddao.addDocument(dto);
	}

	@Override
	public int getDocCode(int writer_code) {
		return ddao.getDocCode(writer_code);
	}

	@Override
	public int addSaveDocument(DocumentDTO dto) {
		return ddao.addSaveDocument(dto);
	}

	@Override
	public List<DocumentDTO> getBeforeConfirmList(int approver_code,int startRowNum,int endRowNum) {
		return ddao.getBeforeConfirmList(approver_code,startRowNum,endRowNum);
	}

	@Override
	public List<DocumentDTO> getNFConfirmList(int approver_code,int startRowNum,int endRowNum) {
		return ddao.getNFConfirmList(approver_code,startRowNum,endRowNum);
	}

	@Override
	public List<DocumentDTO> getFConfirmList(int approver_code, int startRowNum, int endRowNum) {
		return ddao.getFConfirmList(approver_code,startRowNum,endRowNum);
	}

	@Override
	public List<DocumentDTO> getRConfirmList(int approver_code, int startRowNum, int endRowNum) {
		return ddao.getRConfirmList(approver_code,startRowNum,endRowNum);
	}

	@Override
	public List<DocumentDTO> searchConfirmDocument(Map map) {
		return ddao.searchConfirmDocument(map);
	}

	@Override
	public List<DocumentDTO> searchNFDocument(Map map) {
		return ddao.searchNFDocument(map);
	}

	@Override
	public List<DocumentDTO> searchFDocument(Map map) {
		return ddao.searchFDocument(map);
	}

	@Override
	public List<DocumentDTO> searchRDocument(Map map) {
		return ddao.searchRDocument(map);
	}


	public DocumentDTO getSearchNavi(Map map, int cpage, String status) {
		int recordTotalCount = 0;
		if (status.contentEquals("BD")) {
			recordTotalCount = searchBDCount(map);
		}
		else if (status.contentEquals("NFD")){
			recordTotalCount =searchNFCount(map);
		}
		else if(status.contentEquals("F")){
			recordTotalCount = searchFCount(map);
		}else{
			recordTotalCount = searchRCount(map);
		}

		int pageTotalCount = recordTotalCount / DocumentConfigurator.recordCountPerPage;
		if (recordTotalCount % DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage - 1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		DocumentDTO ddto = new DocumentDTO();
		ddto.setStartNavi(startNavi);
		ddto.setEndNavi(endNavi);
		ddto.setNeedNext(needNext);
		ddto.setNeedNext(needPrev);
		return ddto;
	}

	public String getNavi(int approver_code, int cpage, String status) {
		int recordTotalCount = 0;
		if (status.contentEquals("BD")) {
			recordTotalCount = getBDCount(approver_code);
		}else if (status.contentEquals("NFD")){
			recordTotalCount = getNFCount(approver_code);
		}
		else if(status.contentEquals("F")){
			recordTotalCount = getFCount(approver_code);
		}
		else{
			recordTotalCount = getRCount(approver_code);
		}

		int pageTotalCount = recordTotalCount / DocumentConfigurator.recordCountPerPage;
		if (recordTotalCount % DocumentConfigurator.recordCountPerPage != 0) {
			pageTotalCount++;
		}
		//보안코드
		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}

		int startNavi = (cpage - 1) / DocumentConfigurator.naviCountPerPage * DocumentConfigurator.naviCountPerPage + 1;
		int endNavi = startNavi + DocumentConfigurator.naviCountPerPage - 1;
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();
		if (status.contentEquals("BD")) {
			if (needPrev) {
				sb.append("<a href=/document/toBDocument.document?cpage=" + (startNavi - 1) + "><  </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/toBDocument.document?cpage=" + i + "> "+i+" </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/toBDocument.document?cpage=" + (endNavi + 1) + "> </a>");
			}
		}
		//raise
		else if (status.contentEquals("NFD")) {

			if (needPrev) {
				sb.append("<a href=/document/toNFDocument.document?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/toNFDocument.document?cpage=" + i +"> "+i+" </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/toNFDocument.document?cpage=" + (endNavi + 1) + ">> </a>");
			}
		}
		//confirm
		else if (status.contentEquals("FD")) {
			if (needPrev) {
				sb.append("<a href=/document/toFDocument.document?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/toFDocument.document?cpage=" + i + "> "+i+" </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/toFDocument.document?cpage=" + (endNavi + 1) + ">> </a>");
			}
		}
		//reject
		else {
			if (needPrev) {
				sb.append("<a href=/document/toRDocument.document?cpage=" + (startNavi - 1) + "><    </a>");
			}
			for (int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href=/document/toRDocument.document?cpage=" + i +"> "+i+" </a>");
			}
			if (needNext) {
				sb.append("<a href=/document/toRDocument.document?cpage=" + (endNavi + 1) + "> </a>");
			}
		}
		return sb.toString();
	}


	@Override
	public int getBDCount ( int approver_code){
		return ddao.getBDCount(approver_code);
	}

	@Override
	public int searchBDCount (Map map){
		return ddao.searchBDCount(map);
	}

	@Override
	public int getNFCount ( int approver_code){
		return ddao.getNFCount(approver_code);
	}

	@Override
	public int searchNFCount (Map map){
		return ddao.searchNFCount(map);
	}

	@Override
	public int getFCount ( int approver_code){
		return ddao.getFCount(approver_code);
	}

	@Override
	public int searchFCount (Map map){
		return ddao.searchFCount(map);
	}

	@Override
	public int getRCount ( int approver_code){
		return ddao.getRCount(approver_code);
	}

	@Override
	public int searchRCount (Map map){
		return ddao.searchRCount(map);
	}

	@Override
	public DocumentDTO getModDocument(int seq) {
		return ddao.getModDocument(seq);
	}

	@Override
	public int modDocument(DocumentDTO dto) {
		return ddao.modDocument(dto);
	}

	@Override
	public int modAddDocument(DocumentDTO dto) {
		return ddao.modAddDocument(dto);
	}

	@Override
	public int getAuthBD(int seq, int approver_code) {
		return ddao.getAuthBD(seq,approver_code);
	}

	@Override
	public int confirm(int seq,int approver_code) {
		return ddao.confirm(seq,approver_code);
	}

	@Override
	public int returnD(int seq,int approver_code) {
		return ddao.returnD(seq,approver_code);
	}

	@Override
	public int getIsLast(int seq) {
		return ddao.getIsLast(seq);
	}

	@Override
	public int addIsConfirm(int seq, int approver_code,String comments)
	{
		return ddao.addIsConfirm(seq,approver_code,comments);
	}

	@Override
	public int addRIsConfirm(int seq, int approver_code,String comments) {
		return ddao.addRIsConfirm(seq,approver_code,comments);
	}

	@Override
	public int canRetrun(int seq) {
		return ddao.canRetrun(seq);
	}

	@Override
	public List<DocumentDTO> getAllBeforeConfirmList(int approver_code) {
		return ddao.getAllBeforeConfirmList(approver_code);
	}

	@Override
	public List<DocumentDTO> getAllNFConfirmList(int approver_code) {
		return ddao.getAllNFConfirmList(approver_code);
	}

	@Override
	public List<DocumentDTO> getAllFConfirmList(int approver_code) {
		return ddao.getAllFConfirmList(approver_code);
	}

	@Override
	public List<DocumentDTO> getAllRConfirmList(int approver_code) {
		return ddao.getAllRConfirmList(approver_code);
	}
}




