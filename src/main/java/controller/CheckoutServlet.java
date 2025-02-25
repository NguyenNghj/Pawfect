/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import jakarta.servlet.http.HttpSession;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import model.CartItem;
import model.Order;
import model.OrderItem;
import org.json.JSONException;
import org.json.JSONObject;
import util.Email;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
                    viewCheckout(request, response);
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

    private void submitOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = 1;

        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            String phone = request.getParameter("phone");
            String shippingMethod = request.getParameter("shippingMethod");
            String paymentMethod = request.getParameter("paymentMethod");
            double totalCartPrice = Double.parseDouble(request.getParameter("totalPrice"));
//            double shippingCost = Double.parseDouble(request.getParameter("shippingCost"));

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
            orderId = OrderDAO.insertOrder(customerId, paymentMethod_id, shippingMethod_id, name, phone, address, note, totalCartPrice, status);
            if (orderId != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("orderId", orderId);
                System.out.println("Them don hang thanh cong.");
                boolean remove = CartDAO.removeCart(customerId);

                List<OrderItem> orderitems = OrderDAO.getOrderItemsByOrderId(orderId);
                double basicPrice = 0;
                for (OrderItem orderitem : orderitems) {
                    basicPrice += orderitem.getSubtotal();
                }
                List<Order> orders = OrderDAO.getOrderByOrderId(orderId);

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

    private void viewCheckout(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = 1;

        List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);

        int totalQuantity = 0;
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }

        double totalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalCartPrice", totalCartPrice);
        request.setAttribute("totalQuantity", totalQuantity);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
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
