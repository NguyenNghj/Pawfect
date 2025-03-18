/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class EditCategoryServlet extends HttpServlet {

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
            out.println("<title>Servlet EditCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCategoryServlet at " + request.getContextPath() + "</h1>");
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
        CategoryDAO categoryDAO = new CategoryDAO();

        try {
            // Lấy tham số categoryId từ request
            String categoryIdStr = request.getParameter("categoryId");

            // Kiểm tra nếu categoryId bị thiếu hoặc rỗng
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Thiếu ID danh mục.");
                request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
                return;
            }

            int categoryId = Integer.parseInt(categoryIdStr.trim());

            // Lấy thông tin danh mục từ database
            Category category = categoryDAO.getCategoryById(categoryId);
            if (category == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy danh mục có ID: " + categoryId);
                request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
                return;
            }

            // Nếu tìm thấy danh mục, chuyển sang trang chỉnh sửa
            request.setAttribute("category", category);
            request.getRequestDispatcher("/dashboard/admin/editcategory.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ. Vui lòng nhập số nguyên.");
            request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
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
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();
        try {
            // Lấy dữ liệu từ request
            String categoryIdStr = request.getParameter("categoryId");
            String categoryName = request.getParameter("categoryName");
            String activeStr = request.getParameter("isActive");

            // Kiểm tra dữ liệu đầu vào
            if (categoryIdStr == null || categoryIdStr.isEmpty()
                    || categoryName == null || categoryName.trim().isEmpty()
                    || activeStr == null) {
                throw new IllegalArgumentException("Dữ liệu không hợp lệ.");
            }

            // Chuyển đổi dữ liệu
            int categoryId = Integer.parseInt(categoryIdStr);
            boolean active = Boolean.parseBoolean(activeStr);

            // Cập nhật danh mục
            boolean updateSuccess = categoryDAO.updateCategory(categoryId, categoryName, active);

            // Nếu danh mục bị vô hiệu hóa, cập nhật trạng thái sản phẩm
            if (updateSuccess && !active) {
                productDAO.updateProductInactiveByCategory(categoryId);
            }

            // Chuyển hướng về trang danh mục sau khi cập nhật thành công
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");

        } catch (NumberFormatException e) {
            // Lỗi khi chuyển đổi categoryId sang số
            request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ.");
            request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);

        } catch (IllegalArgumentException e) {
            // Lỗi do dữ liệu đầu vào không hợp lệ
            request.getSession().setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/category").forward(request, response);
        }
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
