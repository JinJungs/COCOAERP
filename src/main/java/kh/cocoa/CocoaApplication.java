package kh.cocoa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@SpringBootApplication
public class CocoaApplication extends SpringBootServletInitializer {
    @Bean
    public ServerEndpointExporter serverEndpointExporter() { return new ServerEndpointExporter(); }

    public static void main(String[] args) {
        SpringApplication.run(CocoaApplication.class, args);
    }

 /*   @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(CocoaApplication.class);
    }*/


}
