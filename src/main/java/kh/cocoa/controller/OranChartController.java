package kh.cocoa.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/organ")
public class OranChartController {

    @RequestMapping("toOrganChart.organ")
    public String toOrganChart(){
        return "/organChart/organChart";
    }

}
