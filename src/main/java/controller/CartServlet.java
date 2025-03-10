/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.CartItem;
import org.json.JSONObject;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
                    getCart(request, response);
                    break;
                case "remove":
                    removeProductFromCart(request, response);
                    break;
                case "update":
                    updateProductFromCart(request, response);
                    break;
                case "add":
                    addToCart(request, response);
                    break;
//                case "count":
//                    countQuantityFromCart(request, response);
//                    break;
                default:
//                    listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }

//    private void countQuantityFromCart(HttpServletRequest request, HttpServletResponse response)
//            throws SQLException, IOException, ServletException {
//        int customerId = Integer.parseInt(request.getParameter("customerId"));
//        
//        JSONObject json = new JSONObject();
//        response.setContentType("application/json");
//        
//        int totalQuantity = 0;
//        List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
//        for (CartItem cartItem : cartItems) {
//            totalQuantity += cartItem.getQuantity();
//        }
//
//        json.put("totalQuantity", totalQuantity);
//        
//        response.getWriter().write(json.toString());
//
//    }
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        int quantityFromCart = CartDAO.getQuantityOfProduct(customerId, productId);
        if (quantityFromCart + quantity > stock) {
            json.put("status", "error");
            json.put("message", "Vượt quá tồn kho");
            json.put("stock", stock); // Trả về tồn kho để hiển thị thông báo phía client
            json.put("quantityFromCart", quantityFromCart);
            response.getWriter().write(json.toString());
            return;
        }

        boolean checkProdut = CartDAO.checkProductInCart(productId, customerId);
        if (checkProdut) {
            CartDAO.increaseProductFromCart(quantity, productId, customerId);
            json.put("status", "success");
            json.put("message", "Add to cart successfully!");
        } else {
            CartDAO.addToCart(customerId, productId, quantity);
            json.put("status", "success");
            json.put("message", "Add to cart successfully!");
        }

        int totalQuantity = 0;
        List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
        for (CartItem cartItem : cartItems) {
            totalQuantity += cartItem.getQuantity();
        }

        json.put("totalQuantity", totalQuantity);

        response.getWriter().write(json.toString());

    }

    private void getCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String username = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    username = cookie.getValue();
                    break;
                }
            }
        }

        int customerId = Integer.parseInt(username);

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
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private void removeProductFromCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        boolean remove = false;

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            remove = CartDAO.removeProductFromCart(productId, customerId);
            if (remove) {

                JSONObject json = new JSONObject();
                response.setContentType("application/json");

                json.put("status", "success");
                json.put("message", "Remove from cart successfully!");
                json.put("removed", true);

                List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);

                int totalQuantity = 0;
                if (!cartItems.isEmpty()) {
                    for (CartItem cartItem : cartItems) {
                        totalQuantity += cartItem.getQuantity();
                    }
                }
                json.put("totalQuantity", totalQuantity);

                double newTotalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);
                json.put("totalCartPrice", newTotalCartPrice);

                response.getWriter().write(json.toString());

                System.out.println("Xoa san pham ra gio hang thanh cong!");
            } else {
                System.out.println("Xoa san pham ra gio hang that bai!!");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    private void updateProductFromCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        boolean update = false;
        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            // Lay yeu cau Tang hoac Giam so luong san pham
            String target = request.getParameter("target");
//            int stock = Integer.parseInt(request.getParameter("stock"));
//            int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//            int quantityFromCart = CartDAO.getQuantityOfProduct(customerId, productId);
//            if (quantityFromCart + quantity > stock) {
//                json.put("status", "error");
//                json.put("message", "Vượt quá tồn kho");
//                json.put("stock", stock); // Trả về tồn kho để hiển thị thông báo phía client
//                json.put("quantityFromCart", quantityFromCart);
//                response.getWriter().write(json.toString());
//                return;
//            }

            // Tang so luong san pham
            if (target.equals("increase")) {
                update = CartDAO.increaseProductFromCart(1, productId, customerId);
                if (update) {
                    System.out.println("Tang so luong thanh cong!");

                    json.put("status", "success");
                    json.put("message", "Update cart successfully!");

                    List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);

                    int totalQuantity = 0;
                    if (!cartItems.isEmpty()) {
                        for (CartItem cartItem : cartItems) {
                            totalQuantity += cartItem.getQuantity();
                        }
                    }
                    json.put("totalQuantity", totalQuantity);

                    int newQuantity = CartDAO.getQuantityOfProduct(customerId, productId);
                    json.put("quantity", newQuantity);

                    double newTotalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);
                    json.put("totalCartPrice", newTotalCartPrice);

                    double newSubtotal = CartDAO.getSubtotalOfProduct(customerId, productId);
                    json.put("subtotal", newSubtotal);

                    response.getWriter().write(json.toString());
                } else {
                    System.out.println("Tang so luong that bai!!");
                }

                // Giam so luong san pham
            } else if (target.equals("decrease")) {
                update = CartDAO.decreseProductFromCart(productId, customerId);
                if (update) {
                    System.out.println("Giam so luong thanh cong!");

                    json.put("status", "success");
                    json.put("message", "Update cart successfully!");

                    List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);

                    int totalQuantity = 0;
                    if (!cartItems.isEmpty()) {
                        for (CartItem cartItem : cartItems) {
                            totalQuantity += cartItem.getQuantity();
                        }
                    }
                    json.put("totalQuantity", totalQuantity);

                    int newQuantity = CartDAO.getQuantityOfProduct(customerId, productId);
                    json.put("quantity", newQuantity);

                    double newSubtotal = CartDAO.getSubtotalOfProduct(customerId, productId);
                    json.put("subtotal", newSubtotal);

                    double newTotalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);
                    json.put("totalCartPrice", newTotalCartPrice);

                    // Check xem so luong san pham do co = 0 hay khong
                    // Neu so luong = 0 thi xoa san pham ra gio hang
                    if (newQuantity == 0) {
                        CartDAO.removeProductFromCart(productId, customerId);
                        json.put("removed", true);
                    }
                    response.getWriter().write(json.toString());

                } else {
                    System.out.println("Giam so luong that bai!!");
                }
            }
        } catch (NumberFormatException e) {
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
