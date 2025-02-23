/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class Email {
    // Email: ducquangvu1404@gmail.com
    // Password: arzo kpkq gdhe yiqt

    final static String from = "ducquangvu1404@gmail.com";
    final static String password = "arzo kpkq gdhe yiqt";

    public static boolean sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }

        };

        // Phien lam viec
        Session session = Session.getInstance(props, auth);

        // Gui email
//        final String to = "vuquangduc1404@gmail.com";
        // Tao mot tin nhan
        MimeMessage msg = new MimeMessage(session);
        try {
            // Kieu noi dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // Nguoi gui
            msg.setFrom(new InternetAddress(from));

            // Nguoi nhan
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tieu de email
            msg.setSubject(subject);

            // Quy dinh ngay gui
            msg.setSentDate(new Date());

            // Quy nhan email nhan phan hoi
//            msg.setReplyTo(InternetAddress.parse(from, false));

            // Noi dung
            msg.setContent(content, "text/HTML; charset=UTF-8");

            // Gui email
            Transport.send(msg);
            System.out.println("Gui email thanh cong");
            return true;
        } catch (MessagingException e) {
            System.out.println("Gui email that bai!!");
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {

    }
}
