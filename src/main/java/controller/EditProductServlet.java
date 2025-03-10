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
        try {

            String productIdParam = request.getParameter("productId");
            if (productIdParam == null || productIdParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Product ID không được để trống.");
                request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
                return;
            }

            int productId = Integer.parseInt(productIdParam.trim());

            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            List<Category> categories = categoryDAO.getAllCategories();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                request.setAttribute("errorMessage", "Không tìm thấy sản phẩm với ID: " + productId);
                request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
                return;
            }

            Category selectedCategory = categoryDAO.getCategoryById(product.getCategoryId());
            if (selectedCategory == null) {
                request.setAttribute("errorMessage", "Danh mục của sản phẩm không tồn tại.");
                request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
                return;
            }

            request.setAttribute("selectedCategory", selectedCategory);
            request.setAttribute("categories", categories);
            request.setAttribute("product", product);

            request.getRequestDispatcher("/dashboard/admin/editproduct.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log lỗi
            request.setAttribute("errorMessage", "ID sản phẩm không hợp lệ.");
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
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
            // Nhận dữ liệu từ form, kiểm tra null hoặc rỗng trước khi parse
            String productIdParam = request.getParameter("productId");
            String categoryIdParam = request.getParameter("categoryId");
            String productPriceParam = request.getParameter("productPrice");
            String stockParam = request.getParameter("stock");

            if (productIdParam == null || productIdParam.trim().isEmpty()
                    || categoryIdParam == null || categoryIdParam.trim().isEmpty()
                    || productPriceParam == null || productPriceParam.trim().isEmpty()
                    || stockParam == null || stockParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Một số trường dữ liệu bị thiếu.");
            }

            int productId = Integer.parseInt(productIdParam.trim());
            int categoryId = Integer.parseInt(categoryIdParam.trim());
            double productPrice = Double.parseDouble(productPriceParam.trim());
            int stock = Integer.parseInt(stockParam.trim());

            String productName = request.getParameter("productName");
            String productPetType = request.getParameter("productPetType");
            String description = request.getParameter("description");
            boolean productActive = Boolean.parseBoolean(request.getParameter("productActive"));
            String existingImage = request.getParameter("existingImage");

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
                    newFileName = Paths.get(submittedFileName).getFileName().toString();
                }
            }

            // Cập nhật sản phẩm
            Product product = new Product(productId, categoryId, productName, productPetType,
                    productPrice, newFileName != null ? newFileName : existingImage, stock, description, productActive);

            ProductDAO productDAO = new ProductDAO();
            boolean updateSuccess = productDAO.updateProduct(product);

            if (updateSuccess) {
                if (newFileName != null) {
                    filePart.write(realPath + File.separator + newFileName);
                    if (!existingImage.isEmpty()) {
                        File oldImageFile = new File(realPath + File.separator + existingImage);
                        if (oldImageFile.exists()) {
                            oldImageFile.delete();
                        }
                    }
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
            } else {
                request.setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
                request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi định dạng số! Vui lòng nhập dữ liệu hợp lệ.");
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi cập nhật sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
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
