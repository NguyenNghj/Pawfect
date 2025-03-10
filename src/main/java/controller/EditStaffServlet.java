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
import java.text.SimpleDateFormat;
import java.util.List;
import model.Staff;

/**
 *
 * @author ADMIN
 */
public class EditStaffServlet extends HttpServlet {

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
            out.println("<title>Servlet EditStaffServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditStaffServlet at " + request.getContextPath() + "</h1>");
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
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            StaffDAO staffDAO = new StaffDAO();
            Staff staff = staffDAO.getStaffById(staffId);

            if (staff == null) {
                response.sendRedirect("accountStaff.jsp?error=notfound");
                return;
            }

            request.setAttribute("staff", staff);
            request.getRequestDispatcher("editstaff.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("accountStaff.jsp?error=invalidId");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error Soccurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StaffDAO StaffDAO = new StaffDAO(); // Khởi tạo DAO khi Servlet khởi động
     try {
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String roleName = request.getParameter("roleName");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate"); // Lấy ngày sinh
        String image = request.getParameter("image");
        boolean isActive = request.getParameter("isActive") != null;
        String hashPassword = StaffDAO.hashPasswordMD5(password);

        // Debug xem dữ liệu nhận được
        System.out.println("Received birthDate: " + birthDateStr);

        // Xử lý ngày tháng đúng định dạng
        Date birthDate = null;
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = sdf.parse(birthDateStr);
                birthDate = new Date(parsedDate.getTime()); // Chuyển sang java.sql.Date
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Lỗi chuyển đổi birthDate: " + e.getMessage());
                response.sendRedirect("editstaff.jsp?error=invalidDate");
                return;
            }
        }

        // Cập nhật nhân viên
        Staff staff = new Staff(staffId, roleName, hashPassword, fullName, email, phone, address, gender, birthDate, image, isActive);
        boolean updateSuccess = StaffDAO.updateStaff(staff);

        if (updateSuccess) {
            // Cập nhật thành công, load danh sách mới
            List<Staff> staffList = StaffDAO.getAllStaffs();
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("accountStaff.jsp?success=update").forward(request, response);
        } else {
            response.sendRedirect("editstaff.jsp?staffId=" + staffId + "&error=updateFailed");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("editstaff.jsp?error=invalidData");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
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
