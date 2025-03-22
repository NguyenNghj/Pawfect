/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.Voucher;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class EditVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet EditVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditVoucherServlet at " + request.getContextPath() + "</h1>");
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
            // Lấy voucherId từ request
            String voucherIdParam = request.getParameter("voucherId");

            // Kiểm tra dữ liệu đầu vào
            if (voucherIdParam == null || voucherIdParam.trim().isEmpty() || !voucherIdParam.trim().matches("\\d+")) {
                throw new IllegalArgumentException("ID mã giảm giá không hợp lệ. Vui lòng nhập số nguyên dương.");
            }

            int voucherId = Integer.parseInt(voucherIdParam.trim());
            if (voucherId <= 0) {
                throw new IllegalArgumentException("ID mã giảm giá phải là số nguyên dương.");
            }

            // Lấy thông tin mã giảm giá từ database
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherById(voucherId);

            // Kiểm tra xem voucher có tồn tại không
            if (voucher == null) {
                throw new IllegalArgumentException("Không tìm thấy mã giảm giá với ID: " + voucherId);
            }

            // Nếu tìm thấy, chuyển dữ liệu sang trang editvoucher.jsp
            request.setAttribute("voucher", voucher);
            request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            // Xử lý lỗi nhập liệu (ID sai định dạng hoặc không tìm thấy voucher)
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/voucher");
        } catch (Exception e) {
            // Ghi log lỗi hệ thống chi tiết hơn
            System.err.println("Lỗi hệ thống khi lấy mã giảm giá (ID: " + request.getParameter("voucherId") + "): " + e.getMessage());
            e.printStackTrace();

            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống, vui lòng thử lại sau.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/voucher");
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
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("voucherId");
        try {
            // Lấy dữ liệu từ request
            String voucherIdParam = request.getParameter("voucherId");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String discountPercentageParam = request.getParameter("discountPercentage");
            String discountAmountParam = request.getParameter("discountAmount");
            String minOrderValueParam = request.getParameter("minOrderValue");
            String maxDiscountParam = request.getParameter("maxDiscount");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            String isActiveParam = request.getParameter("active");

            // Kiểm tra dữ liệu đầu vào
            if (voucherIdParam == null || voucherIdParam.trim().isEmpty()
                    || code == null || code.trim().isEmpty()
                    || minOrderValueParam == null || minOrderValueParam.trim().isEmpty()
                    || maxDiscountParam == null || maxDiscountParam.trim().isEmpty()
                    || startDateParam == null || startDateParam.trim().isEmpty()
                    || endDateParam == null || endDateParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Một số trường dữ liệu bị thiếu hoặc rỗng.");
            }

            // Kiểm tra voucherId có phải số hợp lệ không
            if (!voucherIdParam.matches("\\d+")) {
                throw new IllegalArgumentException("ID mã giảm giá phải là số nguyên dương.");
            }
            int voucherId = Integer.parseInt(voucherIdParam);

            // Kiểm tra giá trị số
            int discountPercentage = 0;
            double discountAmount = 0.0;

            if (discountPercentageParam != null && !discountPercentageParam.trim().isEmpty()) {
                discountPercentage = Integer.parseInt(discountPercentageParam);
                if (discountPercentage <= 0) {
                    throw new IllegalArgumentException("Phần trăm giảm giá phải lớn hơn 0.");
                }
            }

            if (discountAmountParam != null && !discountAmountParam.trim().isEmpty()) {
                discountAmount = Double.parseDouble(discountAmountParam);
                if (discountAmount <= 0 || discountAmount > 5000000) {
                    throw new IllegalArgumentException("Số tiền giảm giá phải lớn hơn 0 và không vượt quá 5.000.000.");
                }
            }

            // Chỉ được nhập một trong hai: discountPercentage hoặc discountAmount
            if (discountPercentage > 0 && discountAmount > 0) {
                throw new IllegalArgumentException("Chỉ được nhập một trong hai: 'Phần trăm giảm giá' hoặc 'Số tiền giảm giá'.");
            }

            double minOrderValue = Double.parseDouble(minOrderValueParam);
            if (minOrderValue <= 0) {
                throw new IllegalArgumentException("Giá trị đơn hàng tối thiểu phải lớn hơn 0.");
            }

            double maxDiscount = Double.parseDouble(maxDiscountParam);
            if (maxDiscount <= 0 || maxDiscount > 5000000) {
                throw new IllegalArgumentException("Giảm giá tối đa phải lớn hơn 0 và không vượt quá 5.000.000.");
            }

            // Kiểm tra và xử lý ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            dateFormat.setLenient(false); // Tránh nhập ngày không hợp lệ

            Timestamp startDate = new Timestamp(dateFormat.parse(startDateParam).getTime());
            Timestamp endDate = new Timestamp(dateFormat.parse(endDateParam).getTime());

            // Kiểm tra logic ngày tháng
            if (startDate.after(endDate)) {
                throw new IllegalArgumentException("Ngày bắt đầu không thể sau ngày kết thúc.");
            }

            // Chuyển đổi trạng thái hoạt động
            boolean isActive = Boolean.parseBoolean(isActiveParam);

            // Kiểm tra mã giảm giá đã tồn tại chưa
            VoucherDAO voucherDAO = new VoucherDAO();
            if (voucherDAO.isCodeExists(code, voucherId)) {
                throw new IllegalArgumentException("Mã giảm giá đã tồn tại.");
            }

            // Tạo đối tượng Voucher và cập nhật vào DB
            Voucher voucher = new Voucher(voucherId, code, description, discountPercentage, discountAmount,
                    minOrderValue, maxDiscount, startDate, endDate, isActive);

            boolean updateSuccess = voucherDAO.updateVoucher(voucher);

            if (updateSuccess) {
                request.getSession().setAttribute("successMessage", "Chỉnh sửa mã giảm giá thành công.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/voucher");
            } else {
                throw new IllegalArgumentException("Cập nhật thất bại. Vui lòng thử lại!");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ! Vui lòng kiểm tra lại.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/editvoucher?voucherId=" + id);
        } catch (ParseException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Ngày tháng không hợp lệ! Định dạng yêu cầu: yyyy-MM-dd'T'HH:mm.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/editvoucher?voucherId=" + id);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/editvoucher?voucherId=" + id);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống trong quá trình xử lý.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/editvoucher?voucherId=" + id);
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
