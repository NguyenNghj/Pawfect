/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import model.Category;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
@MultipartConfig
public class EditProductServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductServlet at " + request.getContextPath() + "</h1>");
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
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        Product product = productDAO.getProductById(productId);
        Category selectedCategory = categoryDAO.getCategoryById(product.getCategoryId());
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("categories", categories);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/dashboard/admin/editproduct.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Nhận dữ liệu từ form
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productPetType = request.getParameter("productPetType");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            String existingImage = request.getParameter("existingImage");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String description = request.getParameter("description");
            boolean productActive = Boolean.parseBoolean(request.getParameter("productActive"));

            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "products";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = existingImage; // Giữ ảnh cũ mặc định
            Part filePart = request.getPart("productImage");
            String newFileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                // Lấy tên file mới
                newFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            }

            // Cập nhật thông tin sản phẩm trước
            Product product = new Product(productId, categoryId, productName, productPetType,
                    productPrice, newFileName != null ? newFileName : existingImage, stock, description, productActive);

            ProductDAO productDAO = new ProductDAO();
            boolean updateSuccess = productDAO.updateProduct(product);

            if (updateSuccess) {
                // Nếu cập nhật thành công, lưu ảnh mới và xóa ảnh cũ (nếu có)
                if (newFileName != null) {
                    filePart.write(realPath + File.separator + newFileName);
                    // Xóa ảnh cũ
                    if (!existingImage.isEmpty()) {
                        File oldImageFile = new File(realPath + File.separator + existingImage);
                        oldImageFile.delete();
                    }
                }
                response.sendRedirect("/dashboard/admin/product?success=1");
            } else {
                response.sendRedirect("/dashboard/admin/editproduct?error=2");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/dashboard/admin/editproduct?error=1");
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
