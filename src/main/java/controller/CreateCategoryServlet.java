/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;
import model.Category;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class CreateCategoryServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateCategoryServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/dashboard/admin/createcategory.jsp").forward(request, response);
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
        try {
            // Đọc dữ liệu từ request
            String categoryName = request.getParameter("categoryName");

            // Kiểm tra nếu categoryName bị null hoặc rỗng
            if (categoryName == null || (categoryName = categoryName.trim()).isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không được để trống!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/createcategory");
                return;
            }

            // Kiểm tra nếu categoryName chỉ chứa khoảng trắng
            if (categoryName.replaceAll("\\s", "").isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/createcategory");
                return;
            }

            // Kiểm tra độ dài categoryName (giới hạn 255 ký tự)
            if (categoryName.length() > 255) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không được quá 255 ký tự!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/createcategory");
                return;
            }

            // Kiểm tra ký tự đặc biệt (cho phép chữ, số, khoảng trắng, dấu gạch ngang (-), dấu gạch dưới (_), có hỗ trợ tiếng Việt)
            if (!categoryName.matches("^[a-zA-Z0-9\\sÀ-Ỹà-ỹ_-]+$")) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không được chứa kí tự đặc biệt");
                request.getRequestDispatcher("/dashboard/admin/createcategory.jsp").forward(request, response);
                return;
            }

            // Kiểm tra danh mục đã tồn tại chưa
            CategoryDAO categoryDAO = new CategoryDAO();
            if (categoryDAO.isCategoryExists(categoryName)) {
                request.getSession().setAttribute("errorMessage", "Danh mục đã tồn tại! Vui lòng nhập danh mục khác.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/createcategory");
                return;
            }

            // Kiểm tra giá trị của isActive (tránh nhập dữ liệu sai)
            String isActiveParam = request.getParameter("isActive");
            boolean isActive = "true".equalsIgnoreCase(isActiveParam) || "on".equalsIgnoreCase(isActiveParam);

            // Tạo đối tượng Category
            Category category = new Category(categoryName, isActive);

            // Gọi DAO để thêm danh mục
            boolean isCreated = categoryDAO.createCategory(category);

            if (isCreated) {
                request.getSession().setAttribute("successMessage", "Tạo danh mục thành công!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/category");
            } else {
                request.getSession().setAttribute("errorMessage", "Tạo danh mục thất bại! Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/createcategory");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!");
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
