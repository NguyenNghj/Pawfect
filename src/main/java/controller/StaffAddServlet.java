/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import model.Staff;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB trước khi lưu vào disk
        maxFileSize = 1024 * 1024 * 10, // Tối đa 10MB
        maxRequestSize = 1024 * 1024 * 50 // Tổng request tối đa 50MB
)
/**
 *
 * @author ADMIN
 */
public class StaffAddServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StaffAddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffAddServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("staffadd.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Lấy dữ liệu từ form
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName").trim();
            String email = request.getParameter("email").trim();
            String phone = request.getParameter("phone").trim();
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String birthDateStr = request.getParameter("birthDate");
            String image = null; // Xử lý upload ảnh

            if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || phone.isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

            if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                request.setAttribute("errorMessage", "Email không hợp lệ!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }
// Kiểm tra tên (chỉ cho phép chữ cái và dấu cách, không chứa khoảng trắng thừa)
            if (!fullName.matches("^[\\p{L}]+(?: [\\p{L}]+)*$")) {
                request.setAttribute("errorMessage", "Tên không hợp lệ! Chỉ chứa chữ cái và dấu cách, không có số hoặc ký tự đặc biệt.");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

// Kiểm tra độ dài tối thiểu 2 ký tự và tối đa 50 ký tự
            if (fullName.length() < 2 || fullName.length() > 50) {
                request.setAttribute("errorMessage", "Tên phải có từ 2 đến 50 ký tự!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

// Kiểm tra địa chỉ (chỉ cho phép chữ, số, dấu cách, dấu phẩy, dấu chấm và gạch ngang)
            if (!address.matches("^[\\p{L}0-9 ,.-]+$")) {
                request.setAttribute("errorMessage", "Địa chỉ không hợp lệ!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }
            // Kiểm tra độ dài tối thiểu
            if (password.length() < 6) {
                request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

// Kiểm tra mật khẩu có ít nhất 1 chữ cái, 1 số, 1 ký tự đặc biệt
            String passwordPattern = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{6,}$";

            if (!password.matches(passwordPattern)) {
                request.setAttribute("errorMessage", "Mật khẩu phải chứa ít nhất 1 chữ cái, 1 số và 1 ký tự đặc biệt!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }StaffDAO staffDAO = new StaffDAO();

            if (staffDAO.isEmailOrPhoneExists(email, phone)) {
    request.setAttribute("errorMessage", "Email hoặc số điện thoại đã tồn tại, vui lòng nhập thông tin khác!");
    request.getRequestDispatcher("staffadd.jsp").forward(request, response);
    return;
}

            if (!phone.matches("^[0-9]{10}$")) {
                request.setAttribute("errorMessage", "Số điện thoại phải gồm 10 chữ số không có kí tự đặt biệt hoặc chữ!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }
            
            // Xử lý ngày sinh và kiểm tra tuổi >= 16
            Date birthDate = null;
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                birthDate = Date.valueOf(birthDateStr);

                LocalDate birthLocalDate = birthDate.toLocalDate();
                int age = Period.between(birthLocalDate, LocalDate.now()).getYears();

                if (age < 18) {
                    request.setAttribute("errorMessage", "Nhân viên phải từ 18 tuổi trở lên!");
                    request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                    return;
                }
                if (age > 60) {
                    request.setAttribute("errorMessage", "Nhân viên phải từ 60 tuổi trở xuống!");
                    request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Vui lòng nhập ngày sinh!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

            // Kiểm tra dữ liệu đầu vào
            if (password == null || password.trim().isEmpty()
                    || fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {

                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
                request.getRequestDispatcher("staffadd.jsp").forward(request, response);
                return;
            }

            // Mã hóa mật khẩu
            String hashPassword = StaffDAO.hashPasswordMD5(password);

            // Xử lý ngày sinh
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                birthDate = Date.valueOf(birthDateStr);
            }

            // Xử lý upload ảnh
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "staff";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = "default.jpg"; // Ảnh mặc định nếu không có ảnh tải lên
            Part filePart = request.getPart("staffImage");

            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(realPath + File.separator + fileName);
            }
            image = fileName;

            // Tạo đối tượng Staff
            Staff staff = new Staff(hashPassword, fullName, email, phone, address, gender, birthDate, image, true);

            // Gọi DAO để thêm nhân viên vào database
            boolean isAdded = staffDAO.addStaff(staff);

            if (isAdded) {
                request.getSession().setAttribute("successMessage", "Thêm nhân viên thành công!");
                response.sendRedirect("staff");
            } else {
                throw new Exception("Thêm nhân viên thất bại!");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("staffadd.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống khi xử lý tệp ảnh.");
            request.getRequestDispatcher("staffadd.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Thêm nhân viên thất bại! Lỗi: " + e.getMessage());
            request.getRequestDispatcher("staffadd.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
