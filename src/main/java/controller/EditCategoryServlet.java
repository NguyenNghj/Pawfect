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
import model.Category;

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
            String categoryIdStr = request.getParameter("categoryId").trim();

            // Kiểm tra nếu categoryId bị thiếu hoặc chỉ chứa khoảng trắng
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Thiếu ID danh mục.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");
                return;
            }

            int categoryId;

            try {
                categoryId = Integer.parseInt(categoryIdStr.trim());
                if (categoryId <= 0) {
                    throw new NumberFormatException("ID danh mục phải là số nguyên dương.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ. Vui lòng nhập số nguyên dương.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");
                return;
            }

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

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi không xác định: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");
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
        String categoryIdStr = request.getParameter("categoryId");

        try {
            // Kiểm tra nếu categoryIdStr rỗng hoặc không hợp lệ
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Thiếu ID danh mục.");
            }

            int categoryId;
            try {
                categoryId = Integer.parseInt(categoryIdStr.trim());
                if (categoryId <= 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("ID danh mục không hợp lệ. Vui lòng nhập số nguyên dương.");
            }

            // Lấy và kiểm tra categoryName
            String categoryName = request.getParameter("categoryName");
            if (categoryName == null || (categoryName = categoryName.trim()).isEmpty()) {
                throw new IllegalArgumentException("Tên danh mục không được để trống.");
            }

            if (categoryName.length() > 255) {
                throw new IllegalArgumentException("Tên danh mục không được quá 255 ký tự.");
            }

            // Kiểm tra categoryName chỉ chứa chữ cái và khoảng trắng ở giữa (có hỗ trợ tiếng Việt, không chứa số hay ký tự đặc biệt)
            if (!categoryName.matches("^[a-zA-ZÀ-Ỹà-ỹ]+(\\s[a-zA-ZÀ-Ỹà-ỹ]+)*$")) {
                throw new IllegalArgumentException("Tên danh mục chỉ được chứa chữ cái và khoảng trắng ở giữa!");
            }

            // Kiểm tra danh mục đã tồn tại chưa
            if (categoryDAO.isCategoryExists(categoryName, categoryId)) {
                throw new IllegalArgumentException("Danh mục đã tồn tại! Vui lòng nhập danh mục khác!");
            }

            // Lấy và kiểm tra trạng thái isActive
            String activeStr = request.getParameter("isActive");
            boolean active = "true".equalsIgnoreCase(activeStr) || "on".equalsIgnoreCase(activeStr);

            // Cập nhật danh mục
            boolean updateSuccess = categoryDAO.updateCategory(categoryId, categoryName, active);

            // Nếu danh mục bị vô hiệu hóa, cập nhật trạng thái sản phẩm
            if (updateSuccess && !active) {
                productDAO.updateProductInactiveByCategory(categoryId);
            }

            // Chuyển hướng về trang danh mục sau khi cập nhật thành công
            request.getSession().setAttribute("successMessage", "Cập nhật danh mục thành công.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");

        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/editcategory?categoryId=" + categoryIdStr);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");
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
