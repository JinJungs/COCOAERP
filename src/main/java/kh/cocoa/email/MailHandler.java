package kh.cocoa.email;

import java.io.UnsupportedEncodingException;
 
import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
 
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
 
public class MailHandler {
    
    
    private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;
 
 
    public MailHandler(JavaMailSender mailSender) throws MessagingException {
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }
 
    // Email Title
    public void setSubject(String subject) throws MessagingException {
    	messageHelper.setSubject(subject);
    }
    
    // Email Content(Text)
    public void setText(String htmlContent) throws MessagingException {
    	messageHelper.setText(htmlContent, true);
    }
    
    // Sender Info
    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
    	messageHelper.setFrom(email, name);
    }
    
    // Recipient Info
    public void setTo(String email) throws MessagingException {
    	messageHelper.setTo(email);
    }
    
    public void addInline(String cotentId, DataSource dataSource) throws MessagingException {
    	messageHelper.addInline(cotentId, dataSource);
    }
    
    public void send() {
        try {
            mailSender.send(message);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
}