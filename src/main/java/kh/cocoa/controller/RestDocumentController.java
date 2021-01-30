package kh.cocoa.controller;

import com.google.gson.JsonArray;
import com.sun.org.apache.bcel.internal.generic.ANEWARRAY;
import kh.cocoa.dto.*;
import kh.cocoa.service.*;
import kh.cocoa.statics.Configurator;
import kh.cocoa.statics.DocumentConfigurator;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/restdocument")
public class RestDocumentController {

    @Autowired
    private TeamService tservice;

    @Autowired
    private DepartmentsService dservice;

    @Autowired
    private EmployeeService eservice;

    @Autowired
    private ConfirmService cservice;

    @Autowired
    private DocumentService docservice;

    @Autowired
    private FilesService fservice;

    @Autowired
    private OrderService oservice;


    @RequestMapping("getteamlist.document")
    public String getTeamList(int code) {
        List<TeamDTO> getTeamList = new ArrayList<>();
        getTeamList = tservice.getTeamList(code);
        JSONArray json = new JSONArray(getTeamList);

        return json.toString();
    }

    @RequestMapping("getemplist.document")
    public String getEmpList(int code) {
        List<EmployeeDTO> getEmpPosList = new ArrayList<>();
        getEmpPosList = eservice.getEmpPos(code);
        JSONArray json = new JSONArray(getEmpPosList);

        return json.toString();
    }


    @RequestMapping("addconfirmlist.document")
    public String addConfirmList(int code) {
        List<EmployeeDTO> list = eservice.getConfirmEmp(code);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("addmainconfirmlist.document")
    public String addMainConfirmList(@RequestParam(value = "code", required = true) List<Integer> code) {

        List<EmployeeDTO> getConfirmInfo = new ArrayList<>();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        for (int i = 0; i < code.size(); i++) {
            getConfirmInfo = eservice.getConfirmEmp(code.get(i));
            HashMap<String, Object> map = new HashMap<>();
            map.put("code", code.get(i));
            map.put("emp_name", getConfirmInfo.get(0).getName());
            map.put("dept_name", getConfirmInfo.get(0).getDeptname());
            map.put("pos_name", getConfirmInfo.get(0).getPosname());
            hmlist.add(map);
        }
        JSONArray json = new JSONArray(hmlist);
        return json.toString();
    }

    @RequestMapping("addsave.document")
    public int addsaved(DocumentDTO ddto, @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code, @RequestParam("file") List<MultipartFile> file) throws Exception {
        int result = docservice.addSaveDocument(ddto);
        int getDoc_code = docservice.getDocCode(ddto.getWriter_code());
        if (code.get(0)!=1) {
            for (int i = 0; i < code.size(); i++) {
                int addConfirm = cservice.addConfirm(code.get(i), i + 1, getDoc_code);
            }
            if (!file.get(0).getOriginalFilename().contentEquals("")) {
                String fileRoot = Configurator.boardFileRootC;
                File filesPath = new File(fileRoot);
                if (!filesPath.exists()) {
                    filesPath.mkdir();
                }
                for (MultipartFile mf : file) {
                    if (!mf.getOriginalFilename().contentEquals("")) {
                        String oriName = mf.getOriginalFilename();
                        String uid = UUID.randomUUID().toString().replaceAll("_", "");
                        String savedName = uid + "_" + oriName;
                        int insertFile = fservice.documentInsertFile(oriName, savedName, getDoc_code);
                        if (insertFile > 0) {
                            File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
                            FileCopyUtils.copy(mf.getBytes(), targetLoc);
                        }
                    }
                }
            }

        }
        return getDoc_code;
    }

    @RequestMapping("ajaxadddocument.document")
    public int ajaxadddocument(DocumentDTO ddto, @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code, @RequestParam("file") List<MultipartFile> file) throws Exception {

        int result = docservice.addDocument(ddto);
        int getDoc_code = docservice.getDocCode(ddto.getWriter_code());

        for (int i = 0; i < code.size(); i++) {
            int addConfirm = cservice.addConfirm(code.get(i), i + 1, getDoc_code);
        }

        if (!file.get(0).getOriginalFilename().contentEquals("")) {
            String fileRoot = Configurator.boardFileRootC;
            File filesPath = new File(fileRoot);
            if (!filesPath.exists()) {
                filesPath.mkdir();
            }
            for (MultipartFile mf : file) {
                if (!mf.getOriginalFilename().contentEquals("")) {
                    String oriName = mf.getOriginalFilename();
                    String uid = UUID.randomUUID().toString().replaceAll("_", "");
                    String savedName = uid + "_" + oriName;
                    int insertFile = fservice.documentInsertFile(oriName, savedName, getDoc_code);
                    if (insertFile > 0) {
                        File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
                        FileCopyUtils.copy(mf.getBytes(), targetLoc);
                    }
                }
            }
        }
        return getDoc_code;

    }


    @RequestMapping("addorder.document")
    public String addOrder(@RequestBody List<Map<String,String>> map) throws Exception{
        List<OrderDTO> list = new ArrayList<>();

        for(int i=1;i<map.size();i=i+3){
            OrderDTO dto = new OrderDTO();
            dto.setDoc_seq(Integer.parseInt(map.get(0).get("value")));
            dto.setOrder_list(map.get(i).get("value"));
            dto.setOrder_count(Integer.parseInt(map.get(i+1).get("value")));
            dto.setOrder_etc(map.get(i+2).get("value"));
            list.add(dto);
        }

        for(int i=0;i<list.size();i++){
           int result= oservice.addOrder(list.get(i).getOrder_list(),list.get(i).getOrder_count(),list.get(i).getOrder_etc(),list.get(i).getDoc_seq());
        }

        return "success";

    }

    @RequestMapping("searchdocument.document")
    public String searchDocument(@RequestBody List<Map<String,String>> map) throws ParseException {
        int approver_code=Integer.parseInt(map.get(0).get("value"));
        String startDate = map.get(1).get("value");
        String endDate = map.get(2).get("value");
        String temp_name =map.get(3).get("value");
        String searchOption =map.get(4).get("value");
        String searchText =map.get(5).get("value");
        String cpage =map.get(6).get("value");
        if(temp_name.contentEquals("사무용품")){
            temp_name="사무용품 신청서";
        }
        int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
        int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

        Map<String,Object> hm = new HashMap<>();
        hm.put("approver_code",approver_code);
        hm.put("startDate",startDate);
        hm.put("endDate",endDate);
        hm.put("temp_name",temp_name);
        hm.put("searchOption",searchOption);
        hm.put("searchText",searchText);
        hm.put("startRowNum",startRowNum);
        hm.put("endRowNum",endRowNum);
        DocumentDTO navi = docservice.getSearchNavi(hm,Integer.parseInt(cpage),"BD");
        List<DocumentDTO> list = docservice.searchConfirmDocument(hm);
        list.add(navi);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("searchNFdocument.document")
    public String searchNFDocument(@RequestBody List<Map<String,String>> map ){
        int approver_code=Integer.parseInt(map.get(0).get("value"));
        String startDate = map.get(1).get("value");
        String endDate = map.get(2).get("value");
        String temp_name =map.get(3).get("value");
        String searchOption =map.get(4).get("value");
        String searchText =map.get(5).get("value");
        String cpage =map.get(6).get("value");
        if(temp_name.contentEquals("사무용품")){
            temp_name="사무용품 신청서";
        }
        int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
        int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

        Map<String,Object> hm = new HashMap<>();
        hm.put("approver_code",approver_code);
        hm.put("startDate",startDate);
        hm.put("endDate",endDate);
        hm.put("temp_name",temp_name);
        hm.put("searchOption",searchOption);
        hm.put("searchText",searchText);
        hm.put("startRowNum",startRowNum);
        hm.put("endRowNum",endRowNum);
        DocumentDTO navi= docservice.getSearchNavi(hm,Integer.parseInt(cpage),"NFD");
        List<DocumentDTO> list = docservice.searchNFDocument(hm);
        list.add(navi);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("searchFdocument.document")
    public String searchFDocument(@RequestBody List<Map<String,String>> map ){
        int approver_code=Integer.parseInt(map.get(0).get("value"));
        String startDate = map.get(1).get("value");
        String endDate = map.get(2).get("value");
        String temp_name =map.get(3).get("value");
        String searchOption =map.get(4).get("value");
        String searchText =map.get(5).get("value");
        String cpage =map.get(6).get("value");
        if(temp_name.contentEquals("사무용품")){
            temp_name="사무용품 신청서";
        }
        int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
        int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;

        Map<String,Object> hm = new HashMap<>();
        hm.put("approver_code",approver_code);
        hm.put("startDate",startDate);
        hm.put("endDate",endDate);
        hm.put("temp_name",temp_name);
        hm.put("searchOption",searchOption);
        hm.put("searchText",searchText);
        hm.put("startRowNum",startRowNum);
        hm.put("endRowNum",endRowNum);
        DocumentDTO navi= docservice.getSearchNavi(hm,Integer.parseInt(cpage),"FD");
        List<DocumentDTO> list = docservice.searchFDocument(hm);
        list.add(navi);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("searchRdocument.document")
    public String searchRDocument(@RequestBody List<Map<String,String>> map ){
        int approver_code=Integer.parseInt(map.get(0).get("value"));
        String startDate = map.get(1).get("value");
        String endDate = map.get(2).get("value");
        String temp_name =map.get(3).get("value");
        String searchOption =map.get(4).get("value");
        String searchText =map.get(5).get("value");
        String cpage =map.get(6).get("value");
        if(temp_name.contentEquals("사무용품")){
            temp_name="사무용품 신청서";
        }
        int startRowNum = (Integer.parseInt(cpage) - 1) * DocumentConfigurator.recordCountPerPage + 1;
        int endRowNum = startRowNum + DocumentConfigurator.recordCountPerPage - 1;


        Map<String,Object> hm = new HashMap<>();
        hm.put("approver_code",approver_code);
        hm.put("startDate",startDate);
        hm.put("endDate",endDate);
        hm.put("temp_name",temp_name);
        hm.put("searchOption",searchOption);
        hm.put("searchText",searchText);
        hm.put("startRowNum",startRowNum);
        hm.put("endRowNum",endRowNum);
        DocumentDTO navi= docservice.getSearchNavi(hm,Integer.parseInt(cpage),"RD");
        List<DocumentDTO> list = docservice.searchRDocument(hm);
        list.add(navi);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping("loadconfirmlist.document")
    public String loadConfirmList( @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code){
        List<EmployeeDTO> getConfirmInfo = new ArrayList<>();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        for (int i = 0; i < code.size(); i++) {
            getConfirmInfo = eservice.getConfirmEmp(code.get(i));
            HashMap<String, Object> map = new HashMap<>();
            map.put("code", code.get(i));
            map.put("emp_name", getConfirmInfo.get(0).getName());
            map.put("dept_name", getConfirmInfo.get(0).getDeptname());
            map.put("pos_name", getConfirmInfo.get(0).getPosname());
            hmlist.add(map);
        }
        JSONArray json = new JSONArray(hmlist);
        return json.toString();
    }


}

