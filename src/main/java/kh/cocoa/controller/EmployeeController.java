package kh.cocoa.controller;

import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;
import org.apache.jasper.tagplugins.jstl.Util;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/membership")
public class EmployeeController {
    @Autowired
    private EmployeeService eservice;

    @Autowired
    private FilesService filesService;

    @Autowired
    private HttpSession session;

    @RequestMapping("/login")
    @ResponseBody
    public String login(EmployeeDTO dto) {
        int isWithDraw = eservice.isWithdraw(dto.getCode());
        if(isWithDraw>0){
            return "withdraw";
        }
        String result = eservice.login(dto.getCode(), dto.getPassword());
        if (result.equals("T")) {
            EmployeeDTO loginDTO = eservice.loginInfo(dto.getCode());
            // 의진추가 - 사용자 프로필 이미지 추가하기
            String profile = filesService.getProfile(dto.getCode());
            loginDTO.setProfile(profile);
            session.setAttribute("loginDTO", loginDTO);
        }
        return result;
    }

    @RequestMapping("/myInfo")
    public String testPage(Model model){
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int empCode = loginDTO.getCode();
        EmployeeDTO user = eservice.getEmpInfo(empCode);
        FilesDTO getProfile = filesService.findBeforeProfile(empCode);
        System.out.println(user);
        if(getProfile==null) {
            model.addAttribute("profile","/img/Profile-m.png");
        }else{
            String profileLoc = "/profileFile/" + getProfile.getSavedname();
            model.addAttribute("profile",profileLoc);
        }
        if(user.getGender().contentEquals("M")){
            user.setGender("남자");
        }else{
            user.setGender("여자");
        }
        model.addAttribute("user",user);
        return "/membership/myInfo";
    }

    @RequestMapping(value = "/findId")
    public String findId() {
        return "/membership/findId";
    }

    @RequestMapping(value = "/findPw")
    public String findPw(String email,String code,Model model) {
        model.addAttribute("email",email);
        model.addAttribute("id",code);
        return "/membership/findPw";
    }

    @RequestMapping(value = "/findIdByEmail")
    @ResponseBody
    public String findIdByEmail(String email) throws IOException {
        List<EmployeeDTO> list = new ArrayList<>();
        list= eservice.findIdByEmail(email);
        JSONArray json = new JSONArray(list);
        return json.toString();
    }

    @RequestMapping(value = "/findPwByEmail")
    @ResponseBody
    public String findIdByEmail(String email, int code) {
        return "";
    }

    @RequestMapping(value = "/logout")
    public String logout() {
        session.invalidate();
        return "redirect:/";
    }

    @ExceptionHandler(NullPointerException.class)
    public Object nullex(Exception e) {
        System.err.println(e.getClass());
        return "index";
    }

    @RequestMapping("/toLogin")
    public String toLogin(String code,Model model){
        model.addAttribute("id",code);
        return "index";
    }

    @RequestMapping("/modProfileAJAX")
    @ResponseBody
    public String modProfileAJAX(@RequestParam("file")MultipartFile file, HttpServletResponse resp) throws Exception{
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int empCode = loginDTO.getCode();

        if (!file.getOriginalFilename().contentEquals("")) {
            String fileRoot = Configurator.profileFileRoot;
            File filesPath = new File(fileRoot);
            if (!filesPath.exists()) {
                filesPath.mkdir();
            }

            if (!file.getOriginalFilename().contentEquals("")) {
                String oriName = file.getOriginalFilename();
                String uid = UUID.randomUUID().toString().replaceAll("_", "");
                String savedName = uid+"profile";
                FilesDTO findBeforeProfile = filesService.findBeforeProfile(empCode);
                if(findBeforeProfile==null){
                    int insertFile = filesService.insertProfile(oriName,savedName,empCode);
                    if (insertFile > 0) {
                        String saveLoc = "/profileFile/"+savedName;
                        File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
                        FileCopyUtils.copy(file.getBytes(), targetLoc);
                        return saveLoc;
                    }
                }else{
                    int updateFile = filesService.modProfile(oriName,savedName,empCode);
                    if (updateFile > 0) {
                        String saveLoc = "/profileFile/"+savedName;
                        File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
                        FileCopyUtils.copy(file.getBytes(), targetLoc);
                        return saveLoc;
                    }
                }
            }
        }
        return "false";
    }

    @RequestMapping("/checkPw")
    @ResponseBody
    public int checkPw(@RequestParam("pw") String pw){
        EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");
        int empCode = loginDTO.getCode();
        int checkPw = eservice.getEmpCheckPw(empCode,pw);
        return checkPw;
    }

    @RequestMapping("/modInfoAjax")
    @ResponseBody
    public String modInfoAjax(EmployeeDTO dto){
        dto.setEmail(Configurator.XssReplace(dto.getEmail()));
        dto.setPhone(Configurator.XssReplace(dto.getPhone()));
        dto.setAddress(Configurator.XssReplace(dto.getAddress()));
        dto.setOffice_phone(Configurator.XssReplace(dto.getOffice_phone()));
        int modInfo= eservice.modInfo(dto);

        if(modInfo>0){
            EmployeeDTO empInfo=eservice.getEmpInfo(dto.getCode());

            empInfo.setPassword("");
            if(empInfo.getEmail()==null){
                empInfo.setEmail("");
            }
            else{
                empInfo.setEmail(Configurator.getReXSSFilter(dto.getEmail()));

            }
            if(empInfo.getPhone()==null){
                empInfo.setPhone("");
            }else{
                empInfo.setPhone(Configurator.getReXSSFilter(dto.getPhone()));

            }
            if(empInfo.getOffice_phone()==null){
                empInfo.setOffice_phone("");
            }else{
                empInfo.setOffice_phone(Configurator.getReXSSFilter(dto.getOffice_phone()));

            }
            if(empInfo.getAddress()==null){
                empInfo.setAddress("");
            }else{
                empInfo.setAddress(Configurator.getReXSSFilter(dto.getAddress()));

            }
            JSONObject json = new JSONObject(empInfo);
            return json.toString();
        }
        return "false";
    }

    @RequestMapping("/checkUserEmail")
    @ResponseBody
    public int checkUserEmail(String code, String email){
        int checkUserEmail = eservice.checkUserEmail(Integer.parseInt(code),email);

        return checkUserEmail;
    }

    @RequestMapping("/changePw")
    @ResponseBody
    public int changePw(String password,int code){
        int changePw=eservice.changePw(code,password);
        return changePw;
    }
    @RequestMapping("selectEmployee.employee")
    public NexacroResult selectEmployee() {
        NexacroResult nr = new NexacroResult();

        List<EmployeeDTO> list = eservice.getListWithdrawN();

        nr.addDataSet("out_employee", list);

        return nr;
    }

    @RequestMapping("selectEmployeeLTU.employee")
    public NexacroResult selectEmployeeLTU() {
        NexacroResult nr = new NexacroResult();

        List<EmployeeDTO> list = eservice.getEmpleLTU();

        nr.addDataSet("out_employee", list);

        return nr;
    }


}