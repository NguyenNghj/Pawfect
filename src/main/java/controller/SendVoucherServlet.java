/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomersDAO;
import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import model.Customers;
import model.Voucher;
import util.Email;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class SendVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet SendVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendVoucherServlet at " + request.getContextPath() + "</h1>");
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
        System.out.println("Nice");
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

            // Nhận dữ liệu từ request
            String customerIdsParam = request.getParameter("customerIds");
            String voucherCode = request.getParameter("voucherCode");

            // Kiểm tra trường bắt buộc
            if (customerIdsParam == null || customerIdsParam.trim().isEmpty()
                    || voucherCode == null || voucherCode.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn ít nhất một khách hàng và nhập mã voucher.");
            }

            // Kiểm tra định dạng mã voucher (ví dụ: chỉ chứa chữ cái và số)
            if (!voucherCode.matches("^[a-zA-Z0-9]+$")) {
                throw new IllegalArgumentException("Mã voucher chỉ được chứa chữ cái và số.");
            }

            // Chuyển đổi danh sách customerIds
            List<Integer> customerIds;
            try {
                customerIds = Arrays.stream(customerIdsParam.split(","))
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                if (customerIds.isEmpty()) {
                    throw new IllegalArgumentException("Danh sách khách hàng không hợp lệ.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Danh sách ID khách hàng chứa giá trị không hợp lệ.");
            }

            // Truy vấn voucher
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);
            if (voucher == null) {
                throw new IllegalArgumentException("Không tìm thấy voucher với mã: " + voucherCode);
            }

            // Xử lý giá trị giảm giá
            String discountValue = (voucher.getDiscountAmount() != 0)
                    ? (voucher.getDiscountAmount() + "đ")
                    : (voucher.getDiscountPercentage() + "%");

            if (voucher.getDiscountAmount() <= 0 && voucher.getDiscountPercentage() <= 0) {
                throw new IllegalArgumentException("Giá trị giảm giá không hợp lệ.");
            }

            // Chuẩn bị email
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
            String voucherFrom = sdf.format(voucher.getStartDate());
            String voucherTo = sdf.format(voucher.getEndDate());
            String shopLink = "http://localhost:8080/pawfect";
            String contentEmailTemplate = Email.emailSendVoucher;

            // Lấy danh sách khách hàng
            CustomersDAO customersDAO = new CustomersDAO();
            List<Customers> customers = customersDAO.getCustomersByIds(customerIds);
            if (customers == null || customers.isEmpty()) {
                throw new IllegalArgumentException("Không tìm thấy khách hàng nào trong danh sách.");
            }

            // Gửi email song song
            ExecutorService executor = Executors.newFixedThreadPool(50);
            AtomicInteger successCount = new AtomicInteger(0);

            for (Customers customer : customers) {
                if (customer != null && customer.getEmail() != null && !customer.getEmail().trim().isEmpty()) {
                    executor.submit(() -> {
                        try {
                            String finalContentEmail = String.format(contentEmailTemplate,
                                    customer.getFullName(), voucherCode, discountValue, voucherFrom, voucherTo, shopLink);
                            if (Email.sendEmail(customer.getEmail(), "Ưu đãi khách hàng", finalContentEmail)) {
                                successCount.incrementAndGet();
                            }
                        } catch (Exception ignored) {
                        }
                    });
                }
            }

            // Chờ gửi email hoàn tất
            executor.shutdown();
            executor.awaitTermination(1, TimeUnit.MINUTES);

            // Đặt thông báo thành công
            if (successCount.get() > 0) {
                request.getSession().setAttribute("successMessage", "Đã gửi voucher thành công cho khách hàng.");
            } else {
                throw new IllegalArgumentException("Không gửi được email nào. Vui lòng kiểm tra lại.");
            }

            response.sendRedirect(request.getContextPath() + "/dashboard/staff/viewcustomersforStaff");

        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/staff/viewcustomersforStaff");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/staff/viewcustomersforStaff");
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
