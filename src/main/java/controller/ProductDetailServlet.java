/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.FeedbackDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartItem;
import model.Feedback;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product"})
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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
        String productIdParam = request.getParameter("id");
//        if (productIdParam == null || productIdParam.isEmpty()) {
//            response.sendRedirect("productlist.jsp"); // Chuyển hướng nếu không có ID
//            return;
//        }

        int productId = Integer.parseInt(productIdParam);
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
//
//        if (product == null) {
//            response.sendRedirect("sanpham"); // Chuyển hướng nếu sản phẩm không tồn tại
//            return;
//        }

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

        int totalQuantity = 0;
        if (username != null) {
            int customerId = Integer.parseInt(username);

            List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
            if (!cartItems.isEmpty()) {
                for (CartItem cartItem : cartItems) {
                    totalQuantity += cartItem.getQuantity();
                }
            }
        }
        // Set tong so luong san pham trong gio hang
        request.setAttribute("totalQuantity", totalQuantity);

        List<Feedback> feedbacks = FeedbackDAO.getProductFeedbackByProductId(productId);
        int totalFeedback = 0;
        double totalStar = 0;
        double averageStar = 0;
        for (Feedback feedback : feedbacks) {
            totalFeedback += 1;
            totalStar += feedback.getRating();
        }
        System.out.println("totalFeedback: " + totalFeedback);
        System.out.println("averageStar: " + averageStar);

        averageStar = totalStar / (double) totalFeedback;
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("totalFeedback", totalFeedback);
        if(averageStar >= 1){
            request.setAttribute("averageStar", averageStar);
        } else {
            request.setAttribute("averageStar", (int) averageStar);
        }
        

        // Gửi dữ liệu sản phẩm sang trang JSP
        List<Product> productList = productDAO.getAllActiveProductsByCategoryName(product.getCategoryName());
        request.setAttribute("product", product);
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("productdetail.jsp").forward(request, response);
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
        processRequest(request, response);
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
