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
        try {
            // Lấy productId từ request

            int productId = Integer.parseInt(request.getParameter("id"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            // Xử lý lấy thông tin giỏ hàng của người dùng từ cookie
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
                for (CartItem cartItem : cartItems) {
                    totalQuantity += cartItem.getQuantity();
                }
            }
            request.setAttribute("totalQuantity", totalQuantity);

            // Lấy option lọc đánh giá của khách hàng
            String option = request.getParameter("rating");
            List<Feedback> feedbacks;
            List<Feedback> overviewFeedback = FeedbackDAO.getProductFeedbackByProductId(productId);

            switch (option) {
                case "1s":
                    feedbacks = FeedbackDAO.getProductFeedbackByRatingVsProductId(1, productId);
                    break;
                case "2s":
                    feedbacks = FeedbackDAO.getProductFeedbackByRatingVsProductId(2, productId);
                    break;
                case "3s":
                    feedbacks = FeedbackDAO.getProductFeedbackByRatingVsProductId(3, productId);
                    break;
                case "4s":
                    feedbacks = FeedbackDAO.getProductFeedbackByRatingVsProductId(4, productId);
                    break;
                case "5s":
                    feedbacks = FeedbackDAO.getProductFeedbackByRatingVsProductId(5, productId);
                    break;
                case "tc":
                    feedbacks = overviewFeedback;
                    break;
                default:
                    feedbacks = FeedbackDAO.getProductFeedbackByProductIdVsImage(productId);
            }

            // Thống kê đánh giá sao
            int totalFeedback = 0, oneStar = 0, twoStar = 0, threeStar = 0, fourStar = 0, fiveStar = 0, haveImg = 0;
            double totalStar = 0, averageStar = 0;

            for (Feedback feedback : overviewFeedback) {
                totalFeedback++;
                totalStar += feedback.getRating();
                if (feedback.getImagePath() != null) {
                    haveImg++;
                }
                switch (feedback.getRating()) {
                    case 1:
                        oneStar += 1;
                        break;
                    case 2:
                        twoStar += 1;
                        break;
                    case 3:
                        threeStar += 1;
                        break;
                    case 4:
                        fourStar += 1;
                        break;
                    default:
                        fiveStar += 1;
                        break;
                }
            }

            if (totalFeedback > 0) {
                averageStar = totalStar / totalFeedback;
            }

            // Gán thuộc tính cho request để gửi sang JSP
            request.setAttribute("feedbacks", feedbacks);
            request.setAttribute("totalFeedback", totalFeedback);
            request.setAttribute("averageStar", averageStar);
            request.setAttribute("oneStar", oneStar);
            request.setAttribute("twoStar", twoStar);
            request.setAttribute("threeStar", threeStar);
            request.setAttribute("fourStar", fourStar);
            request.setAttribute("fiveStar", fiveStar);
            request.setAttribute("haveImg", haveImg);

            // Lấy danh sách sản phẩm cùng danh mục
            List<Product> productList = productDAO.getAllActiveProductsByCategoryName(product.getCategoryName());
            request.setAttribute("product", product);
            request.setAttribute("productList", productList);

            // Chuyển hướng đến trang chi tiết sản phẩm
            request.getRequestDispatcher("productdetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID sản phẩm hoặc ID khách hàng không hợp lệ!");
            request.getRequestDispatcher("/products").forward(request, response);
        } catch (NullPointerException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ hoặc sản phẩm không tồn tại.");
            request.getRequestDispatcher("/products").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình xử lý.");
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
