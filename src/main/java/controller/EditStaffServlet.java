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
import java.text.SimpleDateFormat;
import java.util.List;
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        StaffDAO staffDAO = new StaffDAO(); // Khởi tạo DAO

        try {
            // Lấy dữ liệu từ request
            String staffIdParam = request.getParameter("staffId");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String birthDateStr = request.getParameter("birthDate");
            String image = request.getParameter("image");
            String isActiveParam = request.getParameter("isActive");
            String existingImage = request.getParameter("existingImage");

            // Kiểm tra dữ liệu đầu vào có null hoặc rỗng không
            if (staffIdParam == null || staffIdParam.trim().isEmpty()
                    ||  password == null || password.trim().isEmpty()
                    || fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {

                request.getSession().setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
                response.sendRedirect("editstaff.jsp?staffId=" + staffIdParam);
                return;
            }

            // Chuyển đổi dữ liệu số
            int staffId = Integer.parseInt(staffIdParam.trim());
            boolean isActive = "true".equals(isActiveParam);

            // Mã hóa mật khẩu
            String hashedPassword = staffDAO.hashPasswordMD5(password);

            // Xử lý ngày sinh
            Date birthDate = null;
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsedDate = sdf.parse(birthDateStr);
                    birthDate = new Date(parsedDate.getTime()); // Chuyển sang java.sql.Date
                } catch (Exception e) {
                    request.getSession().setAttribute("errorMessage", "Ngày sinh không hợp lệ!");
                    response.sendRedirect("editstaff.jsp?staffId=" + staffId);
                    return;
                }
            }
            // Xử lý đường dẫn lưu ảnh
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator
                    + "webapp" + File.separator + "img" + File.separator + "staff";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Xử lý file ảnh mới
            Part filePart = request.getPart("petHotelImage");
            String newFileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    newFileName = Paths.get(submittedFileName).getFileName().toString();
                }
            }

            // Nếu có ảnh mới, lưu ảnh và cập nhật đường dẫn
            if (newFileName != null) {
                filePart.write(realPath + File.separator + newFileName);

                // Xóa ảnh cũ nếu tồn tại
                if (existingImage != null && !existingImage.isEmpty()) {
                    File oldImageFile = new File(realPath + File.separator + existingImage);
                    if (oldImageFile.exists()) {
                        oldImageFile.delete();
                    }
                }
            }

            // Tạo object Staff
            Staff staff = new Staff(staffId, hashedPassword, fullName, email, phone, address, gender, birthDate, newFileName != null ? newFileName : existingImage, isActive);

            // Cập nhật nhân viên trong database
            boolean updateSuccess = staffDAO.updateStaff(staff);

            if (updateSuccess) {
                request.getSession().setAttribute("successMessage", "Cập nhật nhân viên thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Cập nhật thất bại, vui lòng thử lại!");
            }

            response.sendRedirect(request.getContextPath() + "/dashboard/admin/staff");

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            response.sendRedirect("editstaff.jsp?staffId=" + request.getParameter("staffId"));
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("editstaff.jsp?staffId=" + request.getParameter("staffId"));
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
