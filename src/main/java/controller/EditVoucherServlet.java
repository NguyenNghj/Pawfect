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
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        VoucherDAO voucherDAO = new VoucherDAO();
        Voucher voucher = voucherDAO.getVoucherById(voucherId);
        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
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
        try {
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            int discountPercentage = Integer.parseInt(request.getParameter("discountPercentage"));
            double discountAmount = Double.parseDouble(request.getParameter("discountAmount"));
            double minOrderValue = Double.parseDouble(request.getParameter("minOrderValue"));
            double maxDiscount = Double.parseDouble(request.getParameter("maxDiscount"));
            Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate").replace("T", " ") + ":00");
            Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate").replace("T", " ") + ":00");
            boolean isActive = Boolean.parseBoolean(request.getParameter("active"));

            VoucherDAO voucherDAO = new VoucherDAO();

            // Kiểm tra mã giảm giá đã tồn tại hay chưa
            if (voucherDAO.isCodeExists(code)) {
                request.setAttribute("errorMessage", "Mã giảm giá đã tồn tại!");
                request.setAttribute("voucher", new Voucher(voucherId, code, description, discountPercentage, discountAmount, minOrderValue, maxDiscount, startDate, endDate, isActive));
                request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
                return;
            }

            Voucher voucher = new Voucher(voucherId, code, description, discountPercentage, discountAmount, minOrderValue, maxDiscount, startDate, endDate, isActive);
            boolean updateSuccess = voucherDAO.updateVoucher(voucher);

            if (updateSuccess) {
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/voucher");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thất bại. Vui lòng thử lại!");
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ. Vui lòng kiểm tra lại!");
            request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ!");
            request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);
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
