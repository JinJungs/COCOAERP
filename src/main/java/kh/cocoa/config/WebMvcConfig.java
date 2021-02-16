package kh.cocoa.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    @Order(Ordered.HIGHEST_PRECEDENCE + 2)
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/messengerFile/**")
                .addResourceLocations("file:///C:/messengerRepository/"); //리눅스 root에서 시작하는 폴더 경로

        //지영
        registry.addResourceHandler("/boardRepository/**")
		.addResourceLocations("file:///C:/boardRepository/");

        registry.addResourceHandler("/profileFile/**")
                .addResourceLocations("file:///C:/profileRepository/"); //리눅스 root에서 시작하는 폴더 경로

        registry.addResourceHandler("/_resource_/**").addResourceLocations("classpath:/static/sample/_resource_/");
        registry.addResourceHandler("/FrameBase/**").addResourceLocations("classpath:/static/sample/FrameBase/");
        registry.addResourceHandler("/nexacro17lib/**").addResourceLocations("classpath:/static/sample/nexacro17lib/");
        registry.addResourceHandler("/Test/**").addResourceLocations("classpath:/static/sample/Test/");
        registry.addResourceHandler("/frame/**").addResourceLocations("classpath:/static/sample/frame/");
        registry.addResourceHandler("/Base/**").addResourceLocations("classpath:/static/sample/Base/");
        registry.addResourceHandler("/*.json").addResourceLocations("classpath:/static/sample/");
        registry.addResourceHandler("/*.html").addResourceLocations("classpath:/static/sample/");
        registry.addResourceHandler("/*.js").addResourceLocations("classpath:/static/sample/");



    }

    @Override
    @Order(Ordered.HIGHEST_PRECEDENCE + 1)
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.html");
    }



}
