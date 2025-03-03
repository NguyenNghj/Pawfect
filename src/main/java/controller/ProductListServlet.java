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
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy danh sách danh mục
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Lấy các tham số từ request
        String categoryName = request.getParameter("category");
        String priceFilter = request.getParameter("price");
        String sortFilter = request.getParameter("sort");
        String petTypeFilter = request.getParameter("pettype");

        List<Product> products;

        // Lọc theo danh mục sản phẩm
        if (categoryName != null && !categoryName.isEmpty()) {
            products = productDAO.getAllActiveProductsByCategoryName(categoryName);
        } else {
            products = productDAO.getAllActiveProducts();
        }

        // Lọc theo loại thú cưng nếu có pettype
        if (petTypeFilter != null && !petTypeFilter.isEmpty()) {
            products = productDAO.filterByPetType(products, petTypeFilter);
        }

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

        // Áp dụng bộ lọc giá
        if (priceFilter != null) {
            products = productDAO.filterByPrice(products, priceFilter);
        }

        // Áp dụng bộ lọc sắp xếp
        if (sortFilter != null && !sortFilter.isEmpty()) {
            products = productDAO.sortProducts(products, sortFilter);
        }
        

        // Set danh sách sản phẩm cho request
        request.setAttribute("products", products);

        // Set tong so luong san pham trong gio hang
        request.setAttribute("totalQuantity", totalQuantity);

        // Forward request to JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("productlist.jsp");
        dispatcher.forward(request, response);
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
