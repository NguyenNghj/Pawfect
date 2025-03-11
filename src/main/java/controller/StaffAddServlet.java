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
        // Lấy dữ liệu từ form
        String roleName = request.getParameter("roleName");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");
        String image = request.getParameter("image");
        String hashPassword = StaffDAO.hashPasswordMD5(password);
        // Xử lý birthDate (kiểm tra null)
        Date birthDate = null;
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            birthDate = Date.valueOf(birthDateStr);
        }
        // Kiểm tra tuổi (phải >= 16)
        java.util.Date currentDate = new java.util.Date();
        int currentYear = currentDate.getYear() + 1900; // Lấy năm hiện tại
        int birthYear = birthDate.toLocalDate().getYear(); // Lấy năm sinh
        int age = currentYear - birthYear; // Tính tuổi
        
        if (age < 16) {
            response.sendRedirect("staffadd.jsp?error=underage");
            return;
        }
    

        // Tạo đối tượng Staff
        Staff staff = new Staff(roleName, hashPassword, fullName, email, phone, address, gender, birthDate, image, true);

        // Gọi DAO để thêm nhân viên vào database
        StaffDAO staffDAO = new StaffDAO();
        boolean isAdded = staffDAO.addStaff(staff);

        if (isAdded) {
            response.sendRedirect("staff?success=1"); // Chuyển hướng nếu thành công
        } else {
            response.sendRedirect("staff?error=1"); // Chuyển hướng nếu thất bại
            System.out.println("thêm nhân viên thất bại");
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
