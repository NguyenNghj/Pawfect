/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Date;
import model.Staff;

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
        try {
            request.getRequestDispatcher("/dashboard/admin/staffadd.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi để debug
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải trang thêm nhân viên.");
            request.getRequestDispatcher("/dashboard/admin/staffadd.jsp").forward(request, response);
        }
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
        try {
            // Nhận dữ liệu từ form
            String roleName = request.getParameter("roleName");
            String fullName = request.getParameter("fullName");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String birthDateStr = request.getParameter("birthDate");

            // Kiểm tra dữ liệu đầu vào
            if (roleName == null || fullName == null || password == null || email == null || phone == null) {
                throw new IllegalArgumentException("Thiếu thông tin bắt buộc.");
            }

            // Hash mật khẩu
            String hashPassword = StaffDAO.hashPasswordMD5(password);

            // Xử lý ngày sinh
            Date birthDate = (birthDateStr != null && !birthDateStr.isEmpty()) ? Date.valueOf(birthDateStr) : null;

            // Xử lý ảnh tải lên
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "staffs";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = "default.jpg"; // Ảnh mặc định nếu không có ảnh được tải lên
            Part filePart = request.getPart("staffImage");

            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(realPath + File.separator + fileName);
            }

            // Debug log
            System.out.println("=== DỮ LIỆU STAFF NHẬN ĐƯỢC ===");
            System.out.println("Role: " + roleName);
            System.out.println("Full Name: " + fullName);
            System.out.println("Email: " + email);
            System.out.println("Phone: " + phone);
            System.out.println("Address: " + address);
            System.out.println("Gender: " + gender);
            System.out.println("Birth Date: " + birthDate);
            System.out.println("Image File: " + fileName);
            System.out.println("==============================");

            // Tạo đối tượng Staff
            Staff staff = new Staff(roleName, hashPassword, fullName, email, phone, address, gender, birthDate, fileName, true);

            // Gọi DAO để thêm nhân viên vào database
            StaffDAO staffDAO = new StaffDAO();
            boolean createSuccess = staffDAO.addStaff(staff);

            if (createSuccess) {
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/staff?success=1");
            } else {
                throw new Exception("Lỗi khi thêm nhân viên vào database.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/dashboard/admin/staff").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống khi xử lý tệp ảnh.");
            request.getRequestDispatcher("/dashboard/admin/staff").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Tạo nhân viên thất bại! " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/staff").forward(request, response);
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
