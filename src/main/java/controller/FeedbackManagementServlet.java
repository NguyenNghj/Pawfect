/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;
import model.Feedback;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class FeedbackManagementServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "img/feedbacks/";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FeedbackManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackManagementServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        try {
            switch (action) {
                case "view":
                    viewFeedbackList(request, response);
                    break;
                case "isVisible":
                    updateIsVisibleFeedback(request, response);
                    break;
                case "reply":
                    replyFeedback(request, response);
                    break;
                case "feedback":
                    feedbackProduct(request, response);
                    break;
                case "delete":
                    deleteFeedback(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }

    // Hàm tiện ích để lấy chuỗi từ Part
    private String getPartAsString(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        try (InputStream is = part.getInputStream()) {
            byte[] bytes = new byte[(int) part.getSize()];
            is.read(bytes);
            return new String(bytes, StandardCharsets.UTF_8);
        }
    }

    // Hàm lấy giá trị Cookie theo tên
    private String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    // Hàm xử lý upload file
    private String handleFileUpload(HttpServletRequest request, Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            System.out.println("Không có file ảnh được tải lên.");
            return null;
        }

        String fileName = filePart.getSubmittedFileName();
        String uploadPath = request.getServletContext().getRealPath("/");

        // Chuyển đường dẫn từ "target/PawFect-1.0-SNAPSHOT" sang "src/main/webapp"
        uploadPath = uploadPath.replace("target\\PawFect-1.0-SNAPSHOT", "src\\main\\webapp")
                .replace("target/PawFect-1.0-SNAPSHOT", "src/main/webapp");
        System.out.println("uploadPath: " + uploadPath);

        // Kiểm tra nếu file đã tồn tại -> thêm timestamp
        File uploadDir = new File(uploadPath + UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File file = new File(uploadDir, fileName);
        if (file.exists()) {
            String name = fileName.substring(0, fileName.lastIndexOf("."));
            String extension = fileName.substring(fileName.lastIndexOf("."));
            fileName = name + "_" + System.currentTimeMillis() + extension;
        }

        String fullPath = uploadDir + File.separator + fileName;
        filePart.write(fullPath);

        String imagePath = "/" + UPLOAD_DIR + fileName;
        System.out.println("File uploaded: " + imagePath);
        return imagePath;
    }

    private void feedbackProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        try {
            // Lấy customerId từ Cookie
            String customerId = getCookieValue(request, "customerId");
            if (customerId == null) {
                System.out.println("Không tìm thấy customerId!");
                return;
            }

            int intCustomerId = Integer.parseInt(customerId);
            int formatRating = Integer.parseInt(getPartAsString(request.getPart("rating")));
            int formatProductId = Integer.parseInt(getPartAsString(request.getPart("productId")));
            String comment = getPartAsString(request.getPart("comment"));
            String filterRating = request.getParameter("filterRating");

            System.out.println("CustomerId: " + intCustomerId);
            System.out.println("ProductId: " + formatProductId);
            System.out.println("Rating: " + formatRating);
            System.out.println("Comment: " + comment);
            System.out.println("FilterRating: " + filterRating);

            // Xử lý file ảnh (nếu có)
            Part filePart = request.getPart("feedbackImage");
            String imagePath = handleFileUpload(request, filePart);

            // Xử lý đánh giá (giả sử cập nhật thành công)
            boolean update = FeedbackDAO.addFeedback(intCustomerId, formatProductId, formatRating, comment, imagePath);
            if (update) {
                System.out.println("Đánh giá thành công.");
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                // Thêm SweetAlert2 từ CDN
                out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("<script>");
                out.println("Swal.fire({");
                out.println("  title: 'Đang chuyển hướng!',");
                out.println("  text: 'Vui lòng đợi giây lát!',");
                out.println("  icon: 'success',");
                out.println("  timer: 1500,"); // Hiển thị trong 2 giây
                out.println("  timerProgressBar: true,"); // Thanh tiến trình
                out.println("  showConfirmButton: false"); // Ẩn nút OK
                out.println("}).then(() => {");
                out.println("  window.location.href = '/product?id=" + formatProductId + "&rating=" + filterRating + "';");
                out.println("});");
                out.println("</script>");
                out.println("</body></html>");
            } else {
                System.out.println("Đánh giá thất bại!!");
                response.sendRedirect("/product?id=" + formatProductId);
            }
        } catch (ServletException | IOException | NumberFormatException e) {
            System.err.println("Lỗi xử lý đánh giá: " + e.getMessage());
        }

    }
    
    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        System.out.println("FeedbackId: " + feedbackId);
        String status = request.getParameter("status");
        System.out.println("Status: " + status);

        boolean delete = FeedbackDAO.deleteFeedback(feedbackId);
        if (delete) {
            System.out.println("Xoa danh gia thanh cong.");
            response.sendRedirect("feedbackmanagement?action=view" + "&status=" + status);
        } else {
            System.out.println("Xoa danh gia that bai!!");
        }

    }

    private void replyFeedback(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String staffId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("staffId".equals(cookie.getName())) {
                    staffId = cookie.getValue();
                    break;
                }
            }
        }

        System.out.println("StaffId: " + staffId);

        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        System.out.println("FeedbackId: " + feedbackId);
        int intStaffId = Integer.parseInt(staffId);
        String reply = request.getParameter("reply");
        System.out.println("Reply: " + reply);
        String status = request.getParameter("status");

        boolean update = FeedbackDAO.replyFeedback(intStaffId, reply, feedbackId);
        if (update) {
            System.out.println("Phan hoi danh gia thanh cong.");
            response.sendRedirect("feedbackmanagement?action=view" + "&status=" + status);
        } else {
            System.out.println("Phan hoi danh gia that bai!!");
        }

    }

    private void updateIsVisibleFeedback(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        System.out.println("FeedbackId: " + feedbackId);
        String status = request.getParameter("status");
        System.out.println("Status: " + status);

        boolean update = FeedbackDAO.isVisibleFeedback(feedbackId);
        if (update) {
            System.out.println("Thay doi trang thai danh gia thanh cong.");
            response.sendRedirect("feedbackmanagement?action=view" + "&status=" + status);
        } else {
            System.out.println("Thay doi trang thai danh gia that bai!!");
        }

    }

    private void viewFeedbackList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Feedback> feedbacks = null;
        try {
            // int customerId = 1;
            int status = Integer.parseInt(request.getParameter("status"));

            if (status != 0) {
                feedbacks = FeedbackDAO.getProductFeedbackByRating(status);
            } else {
                feedbacks = FeedbackDAO.getAllProductFeedback();
            }

            // switch (status) {
            // case "5s":
            // feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ xác nhận");
            // break;
            // case "4s":
            // feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ lấy hàng");
            // break;
            // case "3s":
            // feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ giao hàng");
            // break;
            // case "2s":
            // feedbacks = FeedbackDAO.getAllOrderByStatus("Hoàn thành");
            // break;
            // case "1s":
            // feedbacks = FeedbackDAO.getAllOrderByStatus("Yêu cầu huỷ...");
            // break;
            // default:
            // feedbacks = FeedbackDAO.getAllProductFeedback();
            // }
            request.setAttribute("feedbackStatus", status);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("/dashboard/staff/feedback.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            System.out.println(e);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
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
