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
        try {
            // Lấy voucherId từ request và kiểm tra hợp lệ
            String voucherIdParam = request.getParameter("voucherId");
            if (voucherIdParam == null || voucherIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Mã giảm giá không được để trống.");
            }

            int voucherId = Integer.parseInt(voucherIdParam);
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherById(voucherId);

            if (voucher == null) {
                throw new NullPointerException("Không tìm thấy mã giảm giá với ID: " + voucherId);
            }

            request.setAttribute("voucher", voucher);
            request.getRequestDispatcher("/dashboard/admin/editvoucher.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Id mã giảm giá không hợp lệ!");
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
        } catch (NullPointerException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không tìm thấy mã giảm giá!");
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
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
        try {
            // Kiểm tra dữ liệu đầu vào
            String voucherIdParam = request.getParameter("voucherId");
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

            if (voucherIdParam == null || minOrderValueParam == null
                    || maxDiscountParam == null || startDateParam == null || endDateParam == null) {
                throw new IllegalArgumentException("Một số trường dữ liệu bị thiếu.");
            }

            int voucherId = Integer.parseInt(voucherIdParam);
            double minOrderValue = Double.parseDouble(minOrderValueParam);
            double maxDiscount = Double.parseDouble(maxDiscountParam);

            // Xử lý định dạng ngày tháng từ input (yyyy-MM-ddTHH:mm)
            Timestamp startDate = Timestamp.valueOf(startDateParam.replace("T", " ") + ":00");
            Timestamp endDate = Timestamp.valueOf(endDateParam.replace("T", " ") + ":00");

            boolean isActive = Boolean.parseBoolean(isActiveParam);

            VoucherDAO voucherDAO = new VoucherDAO();

            // Kiểm tra mã giảm giá đã tồn tại hay chưa
            if (voucherDAO.isCodeExists(code, voucherId)) {
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
                request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log lỗi nếu cần
            request.setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ. Vui lòng kiểm tra lại!");
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);

        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống trong quá trình xử lý.");
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi không xác định.");
            request.getRequestDispatcher("/dashboard/admin/voucher").forward(request, response);
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
