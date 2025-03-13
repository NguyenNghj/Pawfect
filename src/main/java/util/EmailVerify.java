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

        String emailContent = "<meta charset=\"UTF-8\">\n"
                + "    <section style=\"max-width: 600px; margin: auto; border: 1px solid #ddd; border-radius: 10px; padding: 20px; font-family: Arial, sans-serif;\">\n"
                + "        <div style=\"text-align: center;\">\n"
                + "            <a href=\"#\" style=\"background: #8C6E63; display: inline-block; text-align: center; padding: 10px; border-radius: 20px;\">\n"
                + "                <img src=\"https://i.imgur.com/pkDU0pK.png\" width=\"100\" alt=\"PAWFECT Logo\" style=\"display: block; border: 0;\" />\n"
                + "            </a>\n"
                + "        </div>\n"
                + "        <main style=\"margin-top: 20px; text-align: center;\">\n"
                + "            <h2 style=\"color: #333;\">Chào bạn,</h2>\n"
                + "            <p style=\"color: #666; font-size: 16px;\">Đây là mã bảo mật của bạn:</p>\n"
                + "            <div style=\"margin-top: 10px;\">\n";

// Nối từng số trong mã bảo mật
        for (char digit : verificationCode.toCharArray()) {
            emailContent += "<span style=\"display: inline-block; margin: 5px; padding: 15px 20px; font-size: 24px; font-weight: bold; border: 2px solid #8C6E63; color: #8C6E63; border-radius: 8px;\">"
                    + digit + "</span>\n";
        }

// Tiếp tục nội dung email
        emailContent += "            </div>\n"
                + "            <p style=\"color: #666; font-size: 14px; margin-top: 20px;\">"
                + "                Đây là mã bảo mật của bạn dùng để đăng ký tài khoản tại PAWFECT, vui lòng không chia sẻ với bất kì ai."
                + "            </p>\n"
                + "            <p style=\"color: #666; font-size: 14px;\">Cảm ơn, <br><strong>PAWFECT</strong></p>\n"
                + "        </main>\n"
                + "        <footer style=\"margin-top: 20px; text-align: center; font-size: 12px; color: #999;\">\n"
                + "            &copy; PAWFECT. Chăm sóc khách hàng.\n"
                + "        </footer>\n"
                + "    </section>\n";

        message.setContent(emailContent, "text/html; charset=UTF-8");

// Gửi email
        Transport.send(message);
    }

}
