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
import java.util.Comparator;
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
        String searchKeyword = request.getParameter("search");
        String categoryName = request.getParameter("category");
        String priceFilter = request.getParameter("price");
        String sortFilter = request.getParameter("sort");
        String petTypeFilter = request.getParameter("pettype");

        List<Product> products;

        // Nếu có từ khóa tìm kiếm, thực hiện tìm kiếm
        if (searchKeyword != null) {
            products = productDAO.searchActiveProducts(searchKeyword);
        } else if (categoryName != null) {
            // Nếu không tìm kiếm thì lọc theo danh mục
            products = productDAO.getAllActiveProductsByCategoryName(categoryName);
        } else {
            products = productDAO.getAllActiveProducts();
        }

        // Lọc theo loại thú cưng nếu có pettype
        // Lọc theo loại thú cưng nếu có pettype
        if (petTypeFilter != null && !petTypeFilter.isEmpty()) {
            String petTypeName = petTypeFilter.equals("1") ? "Chó" : "Mèo";
            products.removeIf(product -> product.getProductPetType() == null
                    || !petTypeName.equalsIgnoreCase(product.getProductPetType()));
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
            totalQuantity = cartItems.stream().mapToInt(CartItem::getQuantity).sum();
        }

        // Áp dụng bộ lọc giá nếu có
        if (priceFilter != null) {
            products.removeIf(product -> {
                double price = product.getProductPrice();
                switch (priceFilter) {
                    case "1":
                        return price >= 100000;
                    case "2":
                        return price < 100000 || price > 300000;
                    case "3":
                        return price <= 300000;
                    default:
                        break;
                }
                return false; // Mặc định không xóa nếu priceFilter không khớp
            });
        }

        // Áp dụng bộ lọc sắp xếp nếu có
        if (sortFilter != null && !sortFilter.isEmpty()) {
            switch (sortFilter) {
                case "1":
                    // Sắp xếp tăng dần theo giá
                    products.sort(Comparator.comparingDouble(Product::getProductPrice));
                    break;
                case "2":
                    // Sắp xếp giảm dần theo giá
                    products.sort(Comparator.comparingDouble(Product::getProductPrice).reversed());
                    break;
                case "3":
                    // Sắp xếp tăng dần theo tên sản phẩm
                    products.sort(Comparator.comparing(Product::getProductName));
                    break;
                default:
                    break;
            }
        }

        // Set danh sách sản phẩm cho request
        request.setAttribute("products", products);

        // Set tổng số lượng sản phẩm trong giỏ hàng
        request.setAttribute("totalQuantity", totalQuantity);

        // Forward request đến trang JSP
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
