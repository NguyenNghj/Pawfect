/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartItem;
import model.Category;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class ProductListServlet extends HttpServlet {

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
            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            // Lấy danh sách danh mục
            List<Category> categories = categoryDAO.getAllActiveCategories();
            request.setAttribute("categories", categories);

            // Lấy các tham số từ request
            String searchKeyword = request.getParameter("search");
            String categoryName = request.getParameter("category");
            String priceFilter = request.getParameter("price");
            String sortFilter = request.getParameter("sort");
            String petTypeFilter = request.getParameter("pettype");

            // Lấy danh sách sản phẩm theo bộ lọc
            List<Product> products = productDAO.getAllActiveProducts(searchKeyword, categoryName, petTypeFilter, priceFilter, sortFilter);

            // Lấy thông tin người dùng từ cookie
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
                try {
                    int customerId = Integer.parseInt(username);
                    List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
                    totalQuantity = cartItems.stream().mapToInt(CartItem::getQuantity).sum();
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Dữ liệu khách hàng không hợp lệ.");
                }
            }

            // Set danh sách sản phẩm và tổng số lượng giỏ hàng vào request
            request.setAttribute("products", products);
            request.setAttribute("totalQuantity", totalQuantity);

            // Forward request đến trang JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("productlist.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống.");
            request.getRequestDispatcher("/products").forward(request, response);
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
        processRequest(request, response);
    }

}
