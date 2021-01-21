package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BugReportController {
	@GetMapping("/bug")
    public String bug() {
        return "/bugReport/bugReport";
    }
}
