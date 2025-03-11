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

/**
 *
 * @author LENOVO
 */

    import java.util.Properties;


public class SendMail {
    public static void sendEmail(String to, String subject, String messageText) {
        final String from = "pawfectg3@gmail.com"; // Thay bằng email của bạn
        final String password = "ldof gbqp hurw qrkn"; // Thay bằng mật khẩu ứng dụng của Gmail

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
           Message message = new MimeMessage(session);
message.setFrom(new InternetAddress(from));
message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
message.setSubject("Reset password");

// Nội dung email với HTML
String emailContent = "<h1 style='color: #0078D4;'>Đặt lại mật khẩu thành công</h1>"
        + "<p>Xin chào,</p>"
        + "<p>Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình. Dưới đây là mật khẩu mới của bạn:</p>"
        + "<p><strong style='font-size: 18px; color: red;'>" + messageText + "</strong></p>"
        + "<p>Vui lòng đăng nhập và thay đổi mật khẩu ngay để đảm bảo an toàn cho tài khoản của bạn.</p>"
        + "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này hoặc liên hệ với bộ phận hỗ trợ.</p>"
        + "<p>Trân trọng,</p>"
        + "<p><strong>Đội ngũ hỗ trợ</strong></p>";

message.setContent(emailContent, "text/html; charset=UTF-8");

// Gửi email
Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

