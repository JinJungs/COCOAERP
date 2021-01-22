package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/v")
@Controller
public class VController {

    @GetMapping("")
    public String main() {
        return "WEB-INF/views/index.jsp";
    }
}
