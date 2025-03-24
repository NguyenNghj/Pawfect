/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class ProductManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminProductSerlvet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminProductSerlvet at " + request.getContextPath() + "</h1>");
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
            ProductDAO productDAO = new ProductDAO();
            String keyword = request.getParameter("search");
            String priceRange = request.getParameter("priceRange");
            List<Product> products;

            // Lấy danh sách sản phẩm ban đầu
            if (keyword != null && !keyword.trim().isEmpty()) {
                products = productDAO.searchProducts(keyword);
            } else {
                products = productDAO.getAllProducts();
            }

            // Lọc theo khoảng giá nếu có tham số priceRange
            if (priceRange != null && !priceRange.trim().isEmpty() && !"all".equals(priceRange)) {
                products = filterProductsByPrice(products, priceRange);
            }

            // Đưa danh sách sản phẩm đã lọc vào request
            request.setAttribute("productList", products);

            // Chuyển tiếp đến JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard/admin/product.jsp");
            dispatcher.forward(request, response);

        } catch (NullPointerException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi dữ liệu không hợp lệ hoặc thiếu: " + e.getMessage());
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("/dashboard/admin/product.jsp");
            errorDispatcher.forward(request, response);

        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi vào/ra khi xử lý request: " + e.getMessage());
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("/dashboard/admin/product.jsp");
            errorDispatcher.forward(request, response);

        } catch (ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi Servlet khi xử lý request: " + e.getMessage());
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("/dashboard/admin/product.jsp");
            errorDispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định: " + e.getMessage());
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("/dashboard/admin/product.jsp");
            errorDispatcher.forward(request, response);
        }
    }

    private List<Product> filterProductsByPrice(List<Product> productList, String priceRange) {
        List<Product> filteredList = new ArrayList<>();

        for (Product product : productList) {
            double price = product.getProductPrice();
            switch (priceRange) {
                case "under100k":
                    if (price < 100000) {
                        filteredList.add(product);
                    }
                    break;
                case "100kto300k":
                    if (price >= 100000 && price <= 300000) {
                        filteredList.add(product);
                    }
                    break;
                case "over300k":
                    if (price > 300000) {
                        filteredList.add(product);
                    }
                    break;
                default:
                    filteredList.add(product); // Nếu không khớp, thêm tất cả (tương đương "all")
                    break;
            }
        }
        return filteredList;
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
