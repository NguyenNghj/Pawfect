/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.FeedbackDAO;
import dao.OrderDAO;
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

            // Lấy customerId từ Cookie
            String username = getCookieValue(request, "customerId");
            if (username == null) {
                System.out.println("Không tìm thấy customerId!");
                username = "0";
            } 

            int totalQuantity = 0;
            int customerId = Integer.parseInt(username);

            // Lay tong so san pham trong gio hang
            List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
            if (!cartItems.isEmpty()) {
                for (CartItem cartItem : cartItems) {
                    totalQuantity += cartItem.getQuantity();
                }
            }

            // Set tong so luong san pham trong gio hang
            request.setAttribute("totalQuantity", totalQuantity);

            // Lay orderId don hang da hoan thanh gan nhat co san pham do
            int orderId = OrderDAO.getLastCompleteOrder(customerId, productId);
            // Neu lay duoc -> Du dieu kien da mua roi moi duoc feedback
            if (orderId != 0) {
                request.setAttribute("orderExist", true);
                // Kiem tra khach hang da feedback san pham trong don hang do hay chua        
                int countOfFeedback = FeedbackDAO.checkOrderFeedback(customerId, productId, orderId);
                System.out.println("countOfFeedback: " + countOfFeedback);

                // Neu kq tra ve > 0 thi da feedback roi -> Ko cho feedback nua
                if (countOfFeedback > 0) {
                    request.setAttribute("feedbackExist", true);
                    // Nguoc lai neu = 0 thi cho feedback
                } else {
                    request.setAttribute("feedbackExist", false);
                }
            } else {
                System.out.println("Khach hang chua mua san pham nay!");
                request.setAttribute("orderExist", false);
            }

            // Lay option loc feedback cua khach hang chon
            String option = request.getParameter("rating");
            // Dung de in ra list danh gia kem dieu kien (1s, 2s,...)
            List<Feedback> feedbacks = null;
            // Dung de tinh tong so danh gia, va tinh trung binh tong sao cua 1 san pham
            List<Feedback> overviewFeedback = FeedbackDAO.getProductFeedbackByProductId(productId);
            switch (option) {
                case "tc":
                    feedbacks = FeedbackDAO.getProductFeedbackByProductId(productId);
                    break;
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

    // Hàm lấy giá trị Cookie theo tên
    private String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

}
