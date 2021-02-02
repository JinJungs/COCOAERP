package kh.cocoa.controller;

import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/membership")
public class EmployeeController {
    @Autowired
    private EmployeeService eservice;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/login")
    public String login(Model model, int code, String password){
        String result = eservice.login(code, password);
//        if (!result.isEmpty()) {
//            EmployeeDTO loginDTO = eservice.loginInfo(code);
//            session.setAttribute("loginDTO", loginDTO);
//            return "index";
//        }
//        else {
//            return "/membership/login";
//        }
        if(result.equals("T")){
            EmployeeDTO loginDTO = eservice.loginInfo(code);
            session.setAttribute("loginDTO", loginDTO);
            return "index";
        }
        else {
            model.addAttribute("result", result);
            return "/membership/login";
        }
    }

    @RequestMapping(value = "/myInfo")
    public String myInfo(){
        return "/membership/myInfo";
    }

    @RequestMapping(value = "/myInfoModify")
    public String myInfoModify(){
        return "/membership/myInfoModify";
    }

    @RequestMapping(value = "/myInfoModifyDone")
    public String myInfoModifyDone(String password, String gender, String phone, String address, String office_phone) {
        System.out.println("수정중");
        System.out.println(password);
        System.out.println(phone);
        System.out.println(address);
        System.out.println(office_phone);
        EmployeeDTO dto = (EmployeeDTO)session.getAttribute("loginDTO");
        int result = eservice.myInfoModify(password, gender, phone, address, office_phone, dto.getCode());
        return "/membership/myInfo";
    }

    @RequestMapping(value = "/findId")
    public String findId() {
        return "/membership/findId";
    }

    @RequestMapping(value = "/findPw")
    public String findPw() {
        return "/membership/findPw";
    }

    @RequestMapping(value = "/findIdByEmail")
    public String findIdByEmail(Model model, String email){
        String result = eservice.findIdByEmail(email);
        if(result != null) {
            int code = Integer.parseInt(result);
            model.addAttribute("code", code);
            return "/membership/findId";
        } else {
            return "/membership/login";
        }
    }
}
