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
        System.out.println(code.size());
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
    public String addsaved(DocumentDTO ddto, @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code, @RequestParam("file") List<MultipartFile> file) throws Exception {
        System.out.println(ddto.getContents());
        int result = docservice.addSaveDocument(ddto);
        int getDoc_code = docservice.getDocCode(ddto.getWriter_code());
        if (!code.get(0).equals("1")) {
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
        return "success";
    }

    @RequestMapping("ajaxadddocument.document")
    public int ajaxadddocument(DocumentDTO ddto, @RequestParam(value = "approver_code", required = true, defaultValue = "1") List<Integer> code, @RequestParam("file") List<MultipartFile> file,String contents) throws Exception {
        System.out.println(contents);
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
        for(int i=0;i<map.size();i=i+3){
            OrderDTO dto = new OrderDTO();
            dto.setOrder_list(map.get(i).get("value"));
            dto.setOrder_count(map.get(i+1).get("value"));
            dto.setOrder_etc(map.get(i+2).get("value"));
            list.add(dto);
        }
        for(int i=0;i<list.size();i++){


        }
        return "";

    }


}
