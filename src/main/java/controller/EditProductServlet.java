/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Stream;
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
        try {
            // Lấy productId từ request và kiểm tra hợp lệ
            String productIdParam = request.getParameter("productId");

            if (productIdParam == null || productIdParam.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Product ID không được để trống.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            int productId = -1;
            try {
                productId = Integer.parseInt(productIdParam.trim());
                if (productId <= 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "ID sản phẩm không hợp lệ.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm với ID: " + productId);
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAllCategories();

            if (categories == null || categories.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Không có danh mục nào. Vui lòng tạo ít nhất một danh mục.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            Category selectedCategory = categoryDAO.getCategoryById(product.getCategoryId());
            if (selectedCategory == null) {
                request.getSession().setAttribute("errorMessage", "Danh mục của sản phẩm không tồn tại.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            // Đưa dữ liệu lên request để hiển thị trên trang JSP
            request.setAttribute("selectedCategory", selectedCategory);
            request.setAttribute("categories", categories);
            request.setAttribute("product", product);

            request.getRequestDispatcher("/dashboard/admin/editproduct.jsp").forward(request, response);

        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Lỗi hệ thống khi chỉnh sửa sản phẩm", e);
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Lấy dữ liệu từ request
            String productIdParam = request.getParameter("productId").trim();
            String categoryIdParam = request.getParameter("categoryId").trim();
            String productPriceParam = request.getParameter("productPrice").trim();
            String stockParam = request.getParameter("stock").trim().trim();
            String productName = request.getParameter("productName").trim();
            String productPetType = request.getParameter("productPetType").trim();
            String description = request.getParameter("description").trim();
            String existingImage = request.getParameter("existingImage").trim();

            // Kiểm tra dữ liệu không rỗng
            if (Stream.of(productIdParam, categoryIdParam, productPriceParam, stockParam, productName, productPetType, description)
                    .anyMatch(param -> param == null || param.trim().isEmpty())) {
                request.getSession().setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product?productId=" + productIdParam);
                return;
            }

            // Kiểm tra kiểu dữ liệu hợp lệ
            int productId, categoryId, stock;
            double productPrice;
            try {
                productId = Integer.parseInt(productIdParam.trim());
                categoryId = Integer.parseInt(categoryIdParam.trim());
                productPrice = Double.parseDouble(productPriceParam.trim());
                stock = Integer.parseInt(stockParam.trim());

                // Kiểm tra các giá trị hợp lệ
                if (productId <= 0 || categoryId <= 0 || productPrice <= 0 || productPrice > 50000000 || stock < 0 || stock > 1000) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Giá phải từ 0 đến 50,000,000 và số lượng phải từ 0 đến 1000!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/editproduct?productId=" + productIdParam);
                return;
            }

            if (!productName.matches("^[a-zA-Z0-9\\sÀ-Ỹà-ỹ()\\-,.'’]+$")) {
                throw new IllegalArgumentException("Tên sản phẩm không được chứa ký tự đặc biệt (chỉ cho phép chữ, số, dấu cách, dấu phẩy, dấu gạch ngang, dấu chấm và dấu nháy đơn).");
            }

            boolean productActive = (stock != 0) && Boolean.parseBoolean(request.getParameter("productActive"));

            // Xử lý đường dẫn lưu ảnh
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "products";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Xử lý file ảnh mới
            Part filePart = request.getPart("productImage");
            String newFileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    String extension = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();

                    // Kiểm tra định dạng ảnh hợp lệ
                    if (!extension.matches("\\.(jpg|jpeg|png|gif)$")) {
                        request.getSession().setAttribute("errorMessage", "Định dạng ảnh không hợp lệ! Chỉ chấp nhận JPG, JPEG, PNG, GIF.");
                        response.sendRedirect(request.getContextPath() + "/dashboard/admin/editproduct?productId=" + productIdParam);
                        return;
                    }

                    // Kiểm tra kích thước ảnh (giới hạn 5MB)
                    if (filePart.getSize() > 5 * 1024 * 1024) {
                        request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn! Tối đa 5MB.");
                        response.sendRedirect(request.getContextPath() + "/dashboard/admin/editproduct?productId=" + productIdParam);
                        return;
                    }

                    // Đặt tên file ảnh mới tránh trùng lặp
                    newFileName = UUID.randomUUID().toString() + extension;
                    filePart.write(realPath + File.separator + newFileName);

                    // Xóa ảnh cũ nếu có
                    if (existingImage != null && !existingImage.isEmpty()) {
                        File oldImageFile = new File(realPath + File.separator + existingImage);
                        if (oldImageFile.exists()) {
                            oldImageFile.delete();
                        }
                    }
                }
            }

            // Cập nhật sản phẩm
            Product product = new Product(productId, categoryId, productName, productPetType,
                    productPrice, newFileName != null ? newFileName : existingImage, stock, description, productActive);

            ProductDAO productDAO = new ProductDAO();
            boolean updateSuccess = productDAO.updateProduct(product);

            if (updateSuccess) {
                request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
            }
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");

        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Lỗi hệ thống khi cập nhật sản phẩm", e);
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
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
