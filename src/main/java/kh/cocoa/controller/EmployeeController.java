package kh.cocoa.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.sun.deploy.net.HttpResponse;
import com.sun.deploy.net.URLEncoder;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.FilesDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.FilesService;
import kh.cocoa.statics.Configurator;
import org.json.JSONArray;
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

    @RequestMapping(value = "/login")
    public String login(Model model, int code, String password) {
        String result = eservice.login(code, password);
        if (result.equals("T")) {
            EmployeeDTO loginDTO = eservice.loginInfo(code);
            session.setAttribute("loginDTO", loginDTO);
            return "index";
        } else {
            model.addAttribute("result", result);
            return "index";
        }
    }

    @RequestMapping(value = "/myInfo")
    public String myInfo(Model model) {
        EmployeeDTO user = eservice.getEmpInfo(1000);
        FilesDTO getProfile = filesService.findBeforeProfile(1000);
        if(getProfile.getSavedname()!=null) {
            String profileLoc = "/profileFile/" + getProfile.getSavedname();
            System.out.println(profileLoc);
            model.addAttribute("profile",profileLoc);
        }else{
            model.addAttribute("profile","/img/Profile-m");
        }
        if(user.getGender().contentEquals("M")){
            user.setGender("남자");
        }else{
            user.setGender("여자");
        }
        model.addAttribute("user",user);
        return "/membership/myInfo";
    }

    @RequestMapping(value = "/myInfoModify")
    public String myInfoModify(Model model) {
        EmployeeDTO user = eservice.getEmpInfo(1000);
        FilesDTO getProfile = filesService.findBeforeProfile(1000);
        if(getProfile.getSavedname()!=null) {
            String profileLoc = "/profileFile/" + getProfile.getSavedname();
            System.out.println(profileLoc);
            model.addAttribute("profile",profileLoc);
        }else{
            model.addAttribute("profile","/img/Profile-m");
        }
        if(user.getGender().contentEquals("M")){
            user.setGender("남자");
        }else{
            user.setGender("여자");
        }
        model.addAttribute("user",user);
        return "/membership/myInfoMod";

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


        if (!file.getOriginalFilename().contentEquals("")) {
            String fileRoot = Configurator.profileFileRoot;
            File filesPath = new File(fileRoot);
            if (!filesPath.exists()) {
                filesPath.mkdir();
            }

            if (!file.getOriginalFilename().contentEquals("")) {
                String oriName = file.getOriginalFilename();
                System.out.println(oriName);
                String uid = UUID.randomUUID().toString().replaceAll("_", "");
                String savedName = uid+"profile";
                FilesDTO findBeforeProfile = filesService.findBeforeProfile(1000);
                if(findBeforeProfile.getSavedname()==null){
                    int insertFile = filesService.insertProfile(oriName,savedName,1000);
                    if (insertFile > 0) {
                        String saveLoc = "/profileFile/"+savedName;
                        File targetLoc = new File(filesPath.getAbsoluteFile() + "/" + savedName);
                        FileCopyUtils.copy(file.getBytes(), targetLoc);
                        return saveLoc;
                    }
                }else{
                    int updateFile = filesService.modProfile(oriName,savedName,1000);
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

}