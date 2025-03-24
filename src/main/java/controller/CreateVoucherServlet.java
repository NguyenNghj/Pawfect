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
public class CreateVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet AddVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddVoucherServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/dashboard/admin/createvoucher.jsp").forward(request, response);
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
            request.setCharacterEncoding("UTF-8");

            // Nhận dữ liệu từ form
            String code = request.getParameter("code").trim();
            String description = request.getParameter("description").trim();
            String discountPercentageParam = request.getParameter("discountPercentage");
            String discountAmountParam = request.getParameter("discountAmount");
            String minOrderValueParam = request.getParameter("minOrderValue");
            String maxDiscountParam = request.getParameter("maxDiscount");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            String isActiveParam = request.getParameter("active");

            // Kiểm tra trường bắt buộc
            if (code == null || code.trim().isEmpty()
                    || minOrderValueParam == null || minOrderValueParam.trim().isEmpty()
                    || maxDiscountParam == null || maxDiscountParam.trim().isEmpty()
                    || startDateParam == null || startDateParam.trim().isEmpty()
                    || endDateParam == null || endDateParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Một số trường dữ liệu bị thiếu hoặc rỗng.");
            }

            if (!code.matches("^[a-zA-Z0-9-_]+$")) {
                throw new IllegalArgumentException("Mã giảm giá chỉ được chứa chữ cái, số, dấu gạch ngang (-) và gạch dưới (_).");
            }

            // Kiểm tra giá trị số
            int discountPercentage = 0;
            double discountAmount = 0.0;

            if (discountPercentageParam != null && !discountPercentageParam.trim().isEmpty()) {
                discountPercentage = Integer.parseInt(discountPercentageParam);
                if (discountPercentage <= 0 || discountPercentage > 100) {
                    throw new IllegalArgumentException("Phần trăm giảm giá phải từ 1 đến 100.");
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

            // Nếu nhập số tiền giảm giá, maxDiscount không thể nhỏ hơn discountAmount
            if (discountAmount > 0 && maxDiscount < discountAmount) {
                throw new IllegalArgumentException("Giảm giá tối đa không thể nhỏ hơn số tiền giảm giá.");
            }

            // Nếu nhập phần trăm giảm giá, đảm bảo maxDiscount đủ lớn
            if (discountPercentage > 0 && maxDiscount < (minOrderValue * discountPercentage / 100)) {
                throw new IllegalArgumentException("Giảm giá tối đa không được nhỏ hơn số tiền giảm từ phần trăm.");
            }

            // Kiểm tra và xử lý ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            dateFormat.setLenient(false);

            Timestamp startDate = new Timestamp(dateFormat.parse(startDateParam).getTime());
            Timestamp endDate = new Timestamp(dateFormat.parse(endDateParam).getTime());

            // Kiểm tra logic ngày tháng
            if (startDate.after(endDate)) {
                throw new IllegalArgumentException("Ngày bắt đầu không thể sau ngày kết thúc.");
            }

            // Xử lý trạng thái active
            boolean isActive = Boolean.parseBoolean(isActiveParam);

            // Kiểm tra xem mã giảm giá đã tồn tại chưa
            VoucherDAO voucherDAO = new VoucherDAO();
            if (voucherDAO.isCodeExists(code)) {
                throw new IllegalArgumentException("Mã giảm giá đã tồn tại!");
            }

            // Tạo đối tượng Voucher
            Voucher voucher = new Voucher(code, description, discountPercentage, discountAmount, minOrderValue, maxDiscount, startDate, endDate, isActive);
            boolean insertSuccess = voucherDAO.createVoucher(voucher);

            if (insertSuccess) {
                request.getSession().setAttribute("successMessage", "Tạo mã giảm giá thành công.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/voucher");
            } else {
                throw new Exception("Không thể tạo mã giảm giá, vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ! Vui lòng kiểm tra lại.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createvoucher");
        } catch (ParseException e) {
            request.getSession().setAttribute("errorMessage", "Định dạng ngày không hợp lệ! Định dạng yêu cầu: yyyy-MM-dd'T'HH:mm.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createvoucher");
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createvoucher");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createvoucher");
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
