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
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import java.util.Properties;

/**
 *
 * @author Admin
 */
public class Email {
    // Email: ducquangvu1404@gmail.com
    // Password: arzo kpkq gdhe yiqt

    final static String from = "pawfectg3@gmail.com";
    final static String password = "ldof gbqp hurw qrkn";

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
            msg.addHeader("Content-type", "text/html; charset=UTF-8");

            // Nguoi gui
            msg.setFrom(from);

            // Nguoi nhan
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tieu de email
            msg.setSubject(subject, "UTF-8");

            // Quy dinh ngay gui
            msg.setSentDate(new Date());

            // Quy nhan email nhan phan hoi
//            msg.setReplyTo(InternetAddress.parse(from, false));
            // Noi dung
            msg.setContent(content, "text/html; charset=UTF-8");

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

    // Chuyển JSP thành chuỗi HTML
    public static String renderJSPToString(HttpServletRequest request, HttpServletResponse response, String jspPath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        HttpServletResponseWrapper responseWrapper = new HttpServletResponseWrapper(response) {
            public PrintWriter getWriter() {
                return writer;
            }
        };
        dispatcher.include(request, responseWrapper);
        return stringWriter.toString();
    }

    public static String emailRequsetCancel = "<!DOCTYPE html>\n"
            + "<html lang=\"vi\">\n"
            + "<head>\n"
            + "    <meta charset=\"UTF-8\">\n"
            + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
            + "    <title>Thông báo huỷ đơn hàng</title>\n"
            + "    <style>\n"
            + "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }\n"
            + "        .container { max-width: 600px; margin: 20px auto; background: #ffffff; padding: 20px;\n"
            + "                     border-radius: 8px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }\n"
            + "        .header { background-color: #d9534f; color: #ffffff; padding: 15px; text-align: center;\n"
            + "                  font-size: 20px; font-weight: bold; border-radius: 8px 8px 0 0; }\n"
            + "        .content { padding: 20px; color: #333; line-height: 1.6; }\n"
            + "        .order-details { background: #f9f9f9; padding: 15px; border-radius: 5px; margin: 15px 0; }\n"
            + "        .button { display: block; width: 200px; text-align: center; background-color: #d0ebff;\n"
            + "                   color: #ffffff; text-decoration: none; padding: 10px; border-radius: 5px;\n"
            + "                   margin: 20px auto; font-weight: bold; }\n"
            + "        .footer { text-align: center; padding: 10px; font-size: 14px; color: #777; }\n"
            + "    </style>\n"
            + "</head>\n"
            + "<body>\n"
            + "    <div class=\"container\">\n"
            + "        <div class=\"header\">Thông báo huỷ đơn hàng</div>\n"
            + "        <div class=\"content\">\n"
            + "            <p>Xin chào <strong>%s</strong>,</p>\n"
            + "            <p>Chúng tôi rất tiếc thông báo rằng đơn hàng của bạn đã bị huỷ theo yêu cầu.</p>\n"
            + "            <div class=\"order-details\">\n"
            + "                <p><strong>Mã đơn hàng:</strong> #%s</p>\n"
            + "                <p><strong>Ngày đặt hàng:</strong> %s</p>\n"
            + "                <p><strong>Trạng thái:</strong> <span style=\"color: #D2042D\">Đã huỷ</span></p>\n"
            + "            </div>\n"
            + "            <p>Nếu bạn có bất kỳ thắc mắc nào, vui lòng liên hệ bộ phận hỗ trợ khách hàng của chúng tôi.</p>\n"
            + "            <a href=\"%s\" class=\"button\">Liên hệ hỗ trợ</a>\n"
            + "        </div>\n"
            + "        <div class=\"footer\">\n"
            + "            <p>© 2025 PawFect. Mọi quyền được bảo lưu.</p>\n"
            + "        </div>\n"
            + "    </div>\n"
            + "</body>\n"
            + "</html>";

    public static String emailCancel = "<!DOCTYPE html>\n"
            + "<html lang=\"vi\">\n"
            + "<head>\n"
            + "    <meta charset=\"UTF-8\">\n"
            + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
            + "    <title>Thông báo huỷ đơn hàng</title>\n"
            + "    <style>\n"
            + "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }\n"
            + "        .container { max-width: 600px; margin: 20px auto; background: #ffffff; padding: 20px;\n"
            + "                     border-radius: 8px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }\n"
            + "        .header { background-color: #d9534f; color: #ffffff; padding: 15px; text-align: center;\n"
            + "                  font-size: 20px; font-weight: bold; border-radius: 8px 8px 0 0; }\n"
            + "        .content { padding: 20px; color: #333; line-height: 1.6; }\n"
            + "        .order-details { background: #f9f9f9; padding: 15px; border-radius: 5px; margin: 15px 0; }\n"
            + "        .reason { font-weight: bold; color: #d9534f; }\n"
            + "        .button { display: block; width: 200px; text-align: center; background-color: #d9534f;\n"
            + "                   color: #ffffff; text-decoration: none; padding: 10px; border-radius: 5px;\n"
            + "                   margin: 20px auto; font-weight: bold; }\n"
            + "        .footer { text-align: center; padding: 10px; font-size: 14px; color: #777; }\n"
            + "    </style>\n"
            + "</head>\n"
            + "<body>\n"
            + "    <div class=\"container\">\n"
            + "        <div class=\"header\">Thông báo huỷ đơn hàng</div>\n"
            + "        <div class=\"content\">\n"
            + "            <p>Xin chào <strong>%s</strong>,</p>\n"
            + "            <p>Chúng tôi xin thông báo rằng đơn hàng của bạn đã bị huỷ.</p>\n"
            + "            <p class=\"reason\">Lý do huỷ: <em>%s</em></p>\n"
            + "            <div class=\"order-details\">\n"
            + "                <p><strong>Mã đơn hàng:</strong> #%s</p>\n"
            + "                <p><strong>Ngày đặt hàng:</strong> %s</p>\n"
            + "                <p><strong>Trạng thái:</strong> <span style=\"color: #D2042D\">Đã huỷ</span></p>\n"
            + "            </div>\n"
            + "            <p>Nếu bạn có bất kỳ thắc mắc nào, vui lòng liên hệ bộ phận hỗ trợ khách hàng của chúng tôi.</p>\n"
            + "            <a href=\"%s\" class=\"button\">Liên hệ hỗ trợ</a>\n"
            + "        </div>\n"
            + "        <div class=\"footer\">\n"
            + "            <p>© 2025 PawFect. Mọi quyền được bảo lưu.</p>\n"
            + "        </div>\n"
            + "    </div>\n"
            + "</body>\n"
            + "</html>";

    public static String emailSendVoucher = "<!DOCTYPE html>\n"
            + "<html lang=\"vi\">\n"
            + "<head>\n"
            + "    <meta charset=\"UTF-8\">\n"
            + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
            + "    <title>Mã giảm giá đặc biệt dành cho bạn</title>\n"
            + "    <style>\n"
            + "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }\n"
            + "        .container { max-width: 600px; margin: 20px auto; background: #ffffff; padding: 20px;\n"
            + "                     border-radius: 8px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }\n"
            + "        .header { background-color: #4CAF50; color: #ffffff; padding: 15px; text-align: center;\n"
            + "                  font-size: 20px; font-weight: bold; border-radius: 8px 8px 0 0; }\n"
            + "        .content { padding: 20px; color: #333; line-height: 1.6; }\n"
            + "        .voucher-details { background: #f9f9f9; padding: 15px; border-radius: 5px; margin: 15px 0; }\n"
            + "        .voucher-code { font-weight: bold; color: #4CAF50; font-size: 24px; text-align: center; \n"
            + "                        padding: 10px; background: #e8f5e9; border: 2px dashed #4CAF50; \n"
            + "                        border-radius: 5px; margin: 15px 0; letter-spacing: 2px; }\n"
            + "        .validity { font-weight: bold; color: #FF9800; text-align: center; }\n"
            + "        .button { display: block; width: 200px; text-align: center; background-color: #4CAF50;\n"
            + "                   color: #ffffff; text-decoration: none; padding: 10px; border-radius: 5px;\n"
            + "                   margin: 20px auto; font-weight: bold; }\n"
            + "        .footer { text-align: center; padding: 10px; font-size: 14px; color: #777; }\n"
            + "    </style>\n"
            + "</head>\n"
            + "<body>\n"
            + "    <div class=\"container\">\n"
            + "        <div class=\"header\">Mã giảm giá đặc biệt dành cho bạn</div>\n"
            + "        <div class=\"content\">\n"
            + "            <p>Xin chào <strong>%s</strong>,</p>\n"
            + "            <p>Cảm ơn bạn đã luôn đồng hành cùng chúng tôi. Chúng tôi xin gửi tặng bạn mã giảm giá sau:</p>\n"
            + "            <div class=\"voucher-code\">%s</div>\n"
            + "            <div class=\"voucher-details\">\n"
            + "                <p><strong>Giá trị:</strong> Giảm %s trên tổng giá trị đơn hàng</p>\n"
            + "                <p class=\"validity\"><strong>Hiệu lực từ:</strong> %s <strong>đến</strong> %s</p>\n"
            + "            </div>\n"
            + "            <p>Hãy sử dụng mã này khi thanh toán để nhận ưu đãi. Chúc bạn có trải nghiệm mua sắm tuyệt vời!</p>\n"
            + "            <a href=\"%s\" class=\"button\">Mua sắm ngay</a>\n"
            + "        </div>\n"
            + "        <div class=\"footer\">\n"
            + "            <p>© 2025 PawFect. Mọi quyền được bảo lưu.</p>\n"
            + "        </div>\n"
            + "    </div>\n"
            + "</body>\n"
            + "</html>";

    public static void main(String[] args) {

    }
}
