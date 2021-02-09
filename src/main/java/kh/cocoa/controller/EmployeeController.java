package kh.cocoa.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmployeeService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/membership")
public class EmployeeController {
    @Autowired
    private EmployeeService eservice;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/login")
    public String login(Model model, int code, String password) {
        String result = eservice.login(code, password);
//        if (!result.isEmpty()) {
//            EmployeeDTO loginDTO = eservice.loginInfo(code);
//            session.setAttribute("loginDTO", loginDTO);
//            return "index";
//        }
//        else {
//            return "/membership/login";
//        }
        if (result.equals("T")) {
            EmployeeDTO loginDTO = eservice.loginInfo(code);
            session.setAttribute("loginDTO", loginDTO);
            return "index";
        } else {
            model.addAttribute("result", result);
            //return "/membership/login";
            return "index";
        }
    }

    @RequestMapping(value = "/myInfo")
    public String myInfo() {
        return "/membership/myInfo";
    }

    @RequestMapping(value = "/myInfoModify")
    public String myInfoModify() {
        return "/membership/myInfoModify";
    }

    @RequestMapping(value = "/myInfoModifyDone")
    public String myInfoModifyDone(String password, String gender, String phone, String address, String office_phone) {
        System.out.println("수정중");
        System.out.println(password);
        System.out.println(phone);
        System.out.println(address);
        System.out.println(office_phone);
        EmployeeDTO dto = (EmployeeDTO) session.getAttribute("loginDTO");
        int result = eservice.myInfoModify(password, gender, phone, address, office_phone, dto.getCode());
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
}