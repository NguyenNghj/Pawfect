/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author LENOVO
 */
public class EmailVerify {
      public static void sendVerificationEmail(String recipientEmail, String verificationCode) throws MessagingException {
        final String fromEmail = "pawfectg3@gmail.com"; // Email của bạn
        final String password = "ldof gbqp hurw qrkn"; // Mật khẩu ứng dụng (App Password)

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message message = new MimeMessage(session);
message.setFrom(new InternetAddress(fromEmail));
message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
message.setSubject("Email Verify");


String emailContent = "<h1 style='color: #0078D4;'>Xác minh địa chỉ email của bạn</h1>"
        + "<p>Để hoàn thành thiết lập tài khoản Pawfect của bạn, chúng tôi chỉ cần đảm bảo địa chỉ email này là của bạn.</p>"
        + "<p>Để xác minh địa chỉ email của bạn, hãy sử dụng mã bảo mật này: "
        + "<strong style='font-size: 18px;'>"+verificationCode+"</strong></p>"
        + "<p>Nếu không yêu cầu mã này thì bạn có thể bỏ qua email này một cách an toàn. "
        + "Có thể ai đó khác đã nhập địa chỉ email của bạn do nhầm lẫn.</p>"
        + "<p>Xin cám ơn,</p>";
       

message.setContent(emailContent, "text/html; charset=UTF-8");

// Gửi email
Transport.send(message);
    }
      
}
