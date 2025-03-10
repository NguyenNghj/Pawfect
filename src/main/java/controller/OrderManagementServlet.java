/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DiscountOrderDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import model.DiscountOrder;
import model.Order;
import model.OrderItem;
import util.Email;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class OrderManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManagementServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "view":
                    viewOrderList(request, response);
                    break;
                case "viewdetail":
                    viewOrderDetail(request, response);
                    break;
                case "cancel":
                    cancelOrder(request, response);
                    break;
                case "approval":
                    approvalOrder(request, response);
                    break;
                case "search":
                    searchOrder(request, response);
                    break;
                default:
                    // listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }

    private void searchOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String status = request.getParameter("status");
        String searchContent = request.getParameter("searchContent").trim();

        System.out.println("searchContent: " + searchContent);

        List<Order> orders = OrderDAO.searchOrder(searchContent);

        request.setAttribute("orderStatus", status);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/dashboard/staff/order.jsp").forward(request, response);
    }

    private void approvalOrder(HttpServletRequest request, HttpServletResponse response)
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

        try {
            int intStaffId = Integer.parseInt(staffId);
            System.out.println("intStaffId: " + intStaffId);
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            System.out.println("orderId: " + orderId);
            String updateStatus = request.getParameter("updateStatus").trim();
            String statusType = request.getParameter("statusType");
            String actionBack = request.getParameter("actionBack");
            String reasonCancel = request.getParameter("reasonCancel").trim();
            System.out.println("reasonCancel: " + reasonCancel);

            System.out.println("updateStatus: " + updateStatus);

            boolean update = false;
            // Truong hop neu huy don hang
            if (reasonCancel != null && !reasonCancel.equals("")) {
                update = OrderDAO.approvalOrder(updateStatus, intStaffId, reasonCancel, null, orderId);
                System.out.println("Truong hop neu huy don hang!");
                // Con lai
            } else {
                // Neu duyet hoan thanh don hang thi add thoi gian hoan thanh don
                if (updateStatus.equals("Hoàn thành")) {
                    update = OrderDAO.approvalOrder(updateStatus, intStaffId, null, Timestamp.from(Instant.now()), orderId);
                } else {
                    update = OrderDAO.approvalOrder(updateStatus, intStaffId, null, null, orderId);
                }
            }

            if (update) {
                System.out.println("Cap nhat trang thai don hang thanh cong.");

                if (actionBack.equals("viewdetail")) {
                    response.sendRedirect("ordermanagement?action=" + actionBack + "&orderId=" + orderId);
                } else {
                    response.sendRedirect("ordermanagement?action=" + actionBack + "&status=" + statusType);
                }
            } else {
                System.out.println("Cap nhat trang thai don hang that bai!");
            }

        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String confirmCancel = request.getParameter("confirmCancel");
            String statusType = request.getParameter("statusType");
            String actionBack = request.getParameter("actionBack");
            String reasonCancel = request.getParameter("reasonCancel");

            boolean cancel = OrderDAO.cancelOrder(confirmCancel, reasonCancel, orderId);
            if (cancel) {
                System.out.println("Huy don hang thanh cong.");

                List<Order> orders = OrderDAO.getOrderByOrderId(orderId);
                String customerName = orders.get(0).getCustomerName();
                String orderDate = orders.get(0).getOrderDate();
                String supportLink = "https://example.com/support";

                String contentEmail = Email.emailCancelByStaff;
                String finalContentEmail = String.format(contentEmail, customerName, reasonCancel, (orderId + 2500000), orderDate, supportLink);

                ExecutorService executor = Executors.newFixedThreadPool(10); // Tạo một ExecutorService với 10 luồng

                executor.submit(() -> {
                    try {
                        Email.sendEmail("vuquangduc1404@gmail.com", "Thông báo huỷ đơn hàng", finalContentEmail);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });
                if (actionBack.equals("viewdetail")) {
                    response.sendRedirect("ordermanagement?action=" + actionBack + "&orderId=" + orderId);
                } else {
                    response.sendRedirect("ordermanagement?action=" + actionBack + "&status=" + statusType);
                }

            } else {
                System.out.println("Cancel that bai!!");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        List<OrderItem> orderitems = OrderDAO.getOrderItemsByOrderId(orderId);
        double basicPrice = 0;
        for (OrderItem orderitem : orderitems) {
            basicPrice += orderitem.getSubtotal();
        }
        List<Order> orders = OrderDAO.getOrderByOrderId(orderId);

        request.setAttribute("basicPrice", basicPrice);
        request.setAttribute("orderitems", orderitems);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/dashboard/staff/orderDetail.jsp").forward(request, response);

    }

    private void viewOrderList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Order> orders = null;
        try {
            String status = request.getParameter("status");

            switch (status) {
                case "cxn":
                    orders = OrderDAO.getAllOrderByStatus("Chờ xác nhận");
                    break;
                case "clh":
                    orders = OrderDAO.getAllOrderByStatus("Chờ lấy hàng");
                    break;
                case "cgh":
                    orders = OrderDAO.getAllOrderByStatus("Chờ giao hàng");
                    break;
                case "ht":
                    orders = OrderDAO.getAllOrderByStatus("Hoàn thành");
                    break;
                case "ych":
                    orders = OrderDAO.getAllOrderByStatus("Yêu cầu huỷ...");
                    break;
                case "dh":
                    orders = OrderDAO.getAllOrderByStatus("Đã huỷ");
                    break;
                default:
                    orders = OrderDAO.getAllOrder();
            }

            request.setAttribute("orderStatus", status);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/dashboard/staff/order.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            System.out.println(e);
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
