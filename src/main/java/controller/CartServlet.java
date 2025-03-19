/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.ProductDAO;
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
import model.Product;
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

        
        System.out.println("quantity: " + quantity);
        System.out.println("stock: " + stock);
        
        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        // Kiem tra ton kho cua san pham duoc them vao
        int quantityFromCart = CartDAO.getQuantityOfProduct(customerId, productId);
        // Neu so luong them vuot qua ton kho thi thong bao loi
        if (quantityFromCart + quantity > stock) {
            json.put("status", "error");
            json.put("message", "Vượt quá tồn kho");
            json.put("stock", stock); // Trả về tồn kho để hiển thị thông báo phía client
            json.put("quantityFromCart", quantityFromCart);
            response.getWriter().write(json.toString());
            return;
        }

        // Kiem tra san pham da co trong gio hang hay chua
        boolean checkProdut = CartDAO.checkProductInCart(productId, customerId);
        // Neu co roi thi tang so luong san pham trong gio hang
        if (checkProdut) {
            CartItem cartItem = new CartItem(customerId, productId, quantity);
            CartDAO.increaseProductFromCart(cartItem);
            json.put("status", "success");
            json.put("message", "Add to cart successfully!");
            
            // Neu chua thi them san pham vao gio hang
        } else {
            CartItem cartItem = new CartItem(customerId, productId, quantity);
            CartDAO.addToCart(cartItem);
            json.put("status", "success");
            json.put("message", "Add to cart successfully!");
        }

        int totalQuantity = 0;
        List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
        // Tinh tong so luong san pham trong gio hang sau khi update gio hang de cap nhat lai UI
        for (CartItem cartItem : cartItems) {
            totalQuantity += cartItem.getQuantity();
        }

        json.put("totalQuantity", totalQuantity);

        response.getWriter().write(json.toString());

    }

    private void getCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        // Check nguoi dung dang nhap moi cho vo gio hang
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
            // Tinh tong so luong san pham trong gio hang de hien thi
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }

        // Tinh tong gia trong gio hang de hien thi
        double totalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getAllProducts();
        
        request.setAttribute("products", products);
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

                // Lay tong tien gio hang sau khi remove de cap nhat UI
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

            // Neu user nhan + de tang sl san pham
            if (target.equals("increase")) {
                CartItem cartItem = new CartItem(customerId, productId, 1);
                update = CartDAO.increaseProductFromCart(cartItem);
                if (update) {
                    System.out.println("Tang so luong thanh cong!");

                    json.put("status", "success");
                    json.put("message", "Update cart successfully!");

                    List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);

                    int totalQuantity = 0;
                    if (!cartItems.isEmpty()) {
                        for (CartItem c : cartItems) {
                            totalQuantity += c.getQuantity();
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

                // Neu user nhan - de giam sl san pham
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
