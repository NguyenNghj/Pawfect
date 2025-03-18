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
        request.getRequestDispatcher("/dashboard/staff/createvoucher.jsp").forward(request, response);
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
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            int discountPercentage = request.getParameter("discountPercentage") != null
                    ? Integer.parseInt(request.getParameter("discountPercentage"))
                    : 0;

            double discountAmount = request.getParameter("discountAmount") != null
                    ? Double.parseDouble(request.getParameter("discountAmount"))
                    : 0.0;
            String minOrderValueParam = request.getParameter("minOrderValue");
            String maxDiscountParam = request.getParameter("maxDiscount");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            String isActiveParam = request.getParameter("active");

            if (minOrderValueParam == null || maxDiscountParam == null
                    || startDateParam == null || endDateParam == null) {
                throw new IllegalArgumentException("Một số trường dữ liệu bị thiếu.");
            }

            double minOrderValue = Double.parseDouble(minOrderValueParam);
            double maxDiscount = Double.parseDouble(maxDiscountParam);

            // Xử lý định dạng ngày tháng từ input (yyyy-MM-ddTHH:mm)
            Timestamp startDate = Timestamp.valueOf(startDateParam.replace("T", " ") + ":00");
            Timestamp endDate = Timestamp.valueOf(endDateParam.replace("T", " ") + ":00");

            boolean isActive = Boolean.parseBoolean(isActiveParam);

            VoucherDAO voucherDAO = new VoucherDAO();

            // Kiểm tra xem mã giảm giá đã tồn tại chưa
            if (voucherDAO.isCodeExists(code)) {
                request.getSession().setAttribute("errorMessage", "Mã giảm giá đã tồn tại!");
                request.getRequestDispatcher("/dashboard/staff/createvoucher.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Voucher
            Voucher voucher = new Voucher(code, description, discountPercentage, discountAmount, minOrderValue, maxDiscount, startDate, endDate, isActive);
            boolean insertSuccess = voucherDAO.createVoucher(voucher);

            if (insertSuccess) {
                response.sendRedirect(request.getContextPath() + "/dashboard/staff/voucher");
            } else {
                throw new Exception();
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ!");
            request.getRequestDispatcher("/dashboard/staff/createvoucher").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", "Định dạng ngày không hợp lệ!");
            request.getRequestDispatcher("/dashboard/staff/createvoucher").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Debug, nên thay bằng logger trong dự án lớn
            request.getSession().setAttribute("errorMessage", "Tạo mã giảm giá thất bại!");
            request.getRequestDispatcher("/dashboard/staff/createvoucher").forward(request, response);
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
