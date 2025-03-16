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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
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
        // Lấy dữ liệu từ form
        String customerId = request.getParameter("customerId");
        String voucherCode = request.getParameter("voucherCode");

        // Kiểm tra dữ liệu hợp lệ
        if (customerId == null || customerId.isEmpty() || voucherCode == null || voucherCode.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng chọn khách hàng và voucher.");
            request.getRequestDispatcher("/dashboard/staff/viewcustomersforStaff").forward(request, response);
            return;
        }

        try {
            // Gửi voucher mail code ở đây

            Customers customers;
            // Lay thong tin email cua khach dat hang
            customers = CustomersDAO.getCustomerById(Integer.parseInt(customerId));
            
            // Lay email khach hang
            String customerEmail = customers.getEmail();
            System.out.println("customerEmail: " + customerEmail);
            
            // Lay ten khach hang
            String customerName = customers.getFullName();
            
            // Lay thong tin ma giam gia
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);
            
            // Lay giam gia theo % hoac gia tien de show len email
            double discountPrice = 0;
            if (voucher.getDiscountAmount() != 0) {
                discountPrice = voucher.getDiscountAmount();
            } else {
                discountPrice = voucher.getDiscountPercentage();
            }

            // Dinh dang lai han su dung cua voucher
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
            String voucherFrom = sdf.format(voucher.getStartDate());
            String voucherTo = sdf.format(voucher.getEndDate());

            // Url dan toi PawFect
            String shopLink = "http://localhost:9999/pawfect";

            // Chuyen doi jsp sang String
            String contentEmail = Email.emailSendVoucher;
            String finalContentEmail = String.format(contentEmail, customerName, voucherCode, discountPrice, voucherFrom, voucherTo, shopLink);

            ExecutorService executor = Executors.newFixedThreadPool(10); // Tạo một ExecutorService với 10 luồng         

            // Thay vì trực tiếp gửi email trong thread, chúng ta sử dụng Future để kiểm tra kết quả
            Future<Boolean> future = executor.submit(() -> {
                try {
                    return Email.sendEmail(customerEmail, "Ưu đãi khách hàng", finalContentEmail);
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
            });

            executor.shutdown();

            boolean success = future.get();  // Đợi task hoàn thành và lấy kết quả trả về

            if (success) {
                request.setAttribute("message", "Gửi voucher thành công!");
                response.sendRedirect("/dashboard/staff/viewcustomersforStaff");
            } else {
                request.setAttribute("errorMessage", "Gửi voucher thất bại!");
                request.getRequestDispatcher("/dashboard/staff/viewcustomersforStaff").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/staff/viewcustomersforStaff").forward(request, response);
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
