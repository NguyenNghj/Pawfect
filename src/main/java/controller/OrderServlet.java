/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.DiscountOrderDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.ProfileDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.DiscountOrder;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;
import org.json.JSONException;
import org.json.JSONObject;
import util.Email;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class OrderServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
                    viewOrderHistory(request, response);
                    break;
                case "viewdetail":
                    viewOrderDetail(request, response);
                    break;
                case "cancel":
                    cancelOrder(request, response);
                    break;
                case "order":
                    submitOrder(request, response);
                    break;
                default:
                    // listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }

    // Phương thức kiểm tra email hợp lệ
    private boolean isValidEmail(String email) {
        String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    // Phương thức kiểm tra số điện thoại hợp lệ (10-11 chữ số)
    private boolean isValidPhone(String phone) {
        String phoneRegex = "^\\d{10,11}$"; // Chỉ chấp nhận số và có độ dài từ 10-11 chữ số
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    private void submitOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String customerIdStr = getCustomerIdFromCookies(request);
        int customerId = Integer.parseInt(customerIdStr);

        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        try {
            String name = request.getParameter("name").trim();
            String email = request.getParameter("email").trim();
            String address = request.getParameter("address").trim();
            String note = request.getParameter("note").trim();
            String phone = request.getParameter("phone").trim();
            String shippingMethod = request.getParameter("shippingMethod");
            String paymentMethod = request.getParameter("paymentMethod");
            double totalCartPrice = Double.parseDouble(request.getParameter("totalPrice"));
            double salePrice = Double.parseDouble(request.getParameter("salePrice"));
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
//            double shippingCost = Double.parseDouble(request.getParameter("shippingCost"));

            try {
                if (email == null || email.isEmpty()) {
                    throw new IllegalArgumentException("error-data-email-empty");
                }
                if (!isValidEmail(email)) {
                    throw new IllegalArgumentException("error-data-email-valid");
                }

                if (name == null || name.isEmpty()) {
                    throw new IllegalArgumentException("error-data-name-empty");
                }

                if (phone == null || phone.isEmpty()) {
                    throw new IllegalArgumentException("error-data-phone-empty");
                }
                if (!isValidPhone(phone)) {
                    throw new IllegalArgumentException("error-data-phone-valid");
                }

                if (address == null || address.isEmpty()) {
                    throw new IllegalArgumentException("error-data-address-empty");
                }

            } catch (IllegalArgumentException e) {
                System.out.println("Loi du lieu dau vao: " + e.getMessage());
                json.put("status", e.getMessage());
                response.getWriter().write(json.toString());
                return;
            }

            String status = "";
            int shippingMethod_id = 0;
            int paymentMethod_id = 0;

            if (shippingMethod.equals("shipping-hoatoc")) {
                shippingMethod_id = 2;
            } else {
                shippingMethod_id = 1;
            }

            if (paymentMethod.equals("payment-cash")) {
                paymentMethod_id = 1;
                status = "Chờ xác nhận";
            } else {
                paymentMethod_id = 2;
                status = "Chờ lấy hàng";
            }

            int orderId = 0;
            orderId = OrderDAO.insertOrder(customerId, paymentMethod_id, shippingMethod_id, name, phone, address, note, totalCartPrice + salePrice, status);
            // Tao don hang thanh cong
            if (orderId != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("orderId", orderId);
                System.out.println("Them don hang thanh cong.");

                if (voucherId != 0) {
                    DiscountOrderDAO discountOrderDAO = new DiscountOrderDAO();
                    DiscountOrder discountOrder = new DiscountOrder(orderId, voucherId, totalCartPrice);
                    boolean check = discountOrderDAO.addDiscountOrder(discountOrder);
                    if (check) {
                        System.out.println("Them DiscountOrder thanh cong.");
                    } else {
                        System.out.println("Them DiscountOrder that bai!");
                    }
                }

                boolean remove = CartDAO.removeCart(customerId);

                ProductDAO productDAO = new ProductDAO();

                List<OrderItem> orderitems = OrderDAO.getOrderItemsByOrderId(orderId);
                double basicPrice = 0;
                for (OrderItem orderitem : orderitems) {
                    basicPrice += orderitem.getSubtotal();
                    Product product = productDAO.getProductById(orderitem.getProductId());
                    product.setStock(product.getStock() - orderitem.getQuantity());
                    productDAO.updateProduct(product);
                }
                List<Order> orders = OrderDAO.getOrderByOrderId(orderId);

                // Gui data qua email sau khi dat hang
                request.setAttribute("basicPrice", basicPrice);
                request.setAttribute("orderitems", orderitems);
                request.setAttribute("orders", orders);
                String emailContent = Email.renderJSPToString(request, response, "sendemail.jsp");

                ExecutorService executor = Executors.newFixedThreadPool(10); // Tạo một ExecutorService với 10 luồng

                executor.submit(() -> {
                    try {
                        Email.sendEmail("vuquangduc1404@gmail.com", "Xác nhận đơn hàng", emailContent);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                executor.shutdown();

                json.put("status", "success");
                if (remove) {
                    System.out.println("Xoa gio hang thanh cong.");
                    json.put("status", "success");
                } else {
                    System.out.println("Xoa gio hang that bai!!");
                    json.put("status", "error");
                }
            } else {
                System.out.println("Them don hang that bai!!");
                json.put("status", "error");
            }

            response.getWriter().write(json.toString());
        } catch (IOException | NumberFormatException | JSONException e) {
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

            System.out.println("Confirm: " + confirmCancel);

            List<Order> orders = OrderDAO.getOrderByOrderId(orderId);

            if (confirmCancel.equals("Yêu cầu huỷ")) {
                confirmCancel += "...";
                boolean requestCancel = OrderDAO.requestCancelOrder(confirmCancel, reasonCancel, true, orderId);
                if (requestCancel) {
                    System.out.println("Yeu cau huy don hang thanh cong.");

                    String customerName = orders.get(0).getCustomerName();
                    String orderDate = orders.get(0).getOrderDate();
                    String supportLink = "https://example.com/support";

                    String contentEmail = Email.emailRequsetCancel;
                    String finalContentEmail = String.format(contentEmail, customerName, (orderId + 2500000), orderDate, supportLink);

                    ExecutorService executor = Executors.newFixedThreadPool(10); // Tạo một ExecutorService với 10 luồng

                    executor.submit(() -> {
                        try {
//                        Email.sendEmail("vuquangduc1404@gmail.com", "Xác nhận đơn hàng", finalContentEmail);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                    if (actionBack.equals("viewdetail")) {
                        response.sendRedirect("order?action=" + actionBack + "&orderId=" + orderId);
                    } else {
                        response.sendRedirect("order?action=" + actionBack + "&status=" + statusType);
                    }

                } else {
                    System.out.println("Yeu cau huy don hang that bai!!");
                }

            } else {

                boolean cancel = OrderDAO.cancelOrder(confirmCancel, reasonCancel, orderId);
                if (cancel) {
                    System.out.println("Huy don hang thanh cong.");

                    String customerName = orders.get(0).getCustomerName();
                    String orderDate = orders.get(0).getOrderDate();
                    String supportLink = "https://example.com/support";

                    String contentEmail = Email.emailRequsetCancel;
                    String finalContentEmail = String.format(contentEmail, customerName, (orderId + 2500000), orderDate, supportLink);

                    ExecutorService executor = Executors.newFixedThreadPool(10); // Tạo một ExecutorService với 10 luồng

                    executor.submit(() -> {
                        try {
//                        Email.sendEmail("vuquangduc1404@gmail.com", "Xác nhận đơn hàng", finalContentEmail);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                    if (actionBack.equals("viewdetail")) {
                        response.sendRedirect("order?action=" + actionBack + "&orderId=" + orderId);
                    } else {
                        response.sendRedirect("order?action=" + actionBack + "&status=" + statusType);
                    }

                } else {
                    System.out.println("Cancel that bai!!");
                }
            }

        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String customerId = getCustomerIdFromCookies(request);

        ProfileDAO profileDAO = new ProfileDAO();
        User user = profileDAO.getUser(customerId);
        request.setAttribute("customer", user);

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
        request.getRequestDispatcher("orderdetail.jsp").forward(request, response);

    }

    private void viewOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Order> orders = null;

        String customerId = getCustomerIdFromCookies(request);

        ProfileDAO profileDAO = new ProfileDAO();
        User user = profileDAO.getUser(customerId);
        request.setAttribute("customer", user);

        try {
            int intCustomerId = Integer.parseInt(customerId);
            String status = request.getParameter("status");

            switch (status) {
                case "cxn":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Chờ xác nhận");
                    break;
                case "clh":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Chờ lấy hàng");
                    break;
                case "cgh":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Chờ giao hàng");
                    break;
                case "ht":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Hoàn thành");
                    break;
                case "ych":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Yêu cầu huỷ...");
                    break;
                case "dh":
                    orders = OrderDAO.getOrderByCustomerIdVsStatus(intCustomerId, "Đã huỷ");
                    break;
                default:
                    orders = OrderDAO.getOrderByCustomerId(intCustomerId);
            }

            request.setAttribute("orderStatus", status);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orderhistory.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            System.out.println(e);
        }

    }

    public static String getCustomerIdFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
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
