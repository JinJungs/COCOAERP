package kh.cocoa.controller;

import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.security.core.userdetails.User;

@Controller
public class LoginController {
    @GetMapping(value = "")
    public String login(@AuthenticationPrincipal User user){
        if(user != null) {
            if(user.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_VIEW"))) {
                return "index";
            }
        }
        return "redirect:/login";
    }
}
