package kh.cocoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

<<<<<<< HEAD:src/main/java/kh/cocoa/controller/HomeController.java
=======
    @RequestMapping("/test")
    public String test() {
        return "document/c_writeDocument";
    }

    @RequestMapping("/test2")
    public String test2() {
        return "document/c_templateList";
    }
>>>>>>> a2c5e81139bec4d71a1078b22015318a1279e0b3:src/main/java/kh/cocoa/controller/TestController.java
    @RequestMapping("/")
    public String home() {
        return "index";

    }
<<<<<<< HEAD:src/main/java/kh/cocoa/controller/HomeController.java
=======

>>>>>>> a2c5e81139bec4d71a1078b22015318a1279e0b3:src/main/java/kh/cocoa/controller/TestController.java
}