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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
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
public class CreateProductServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateProductServlet at " + request.getContextPath() + "</h1>");
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
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAllCategories();

            if (categories == null || categories.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Không có danh mục nào. Vui lòng tạo ít nhất một danh mục.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }

            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/dashboard/admin/createproduct.jsp").forward(request, response);
        } catch (Exception e) {
            // Ghi log lỗi thay vì chỉ in ra console
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Lỗi khi tải danh mục sản phẩm", e);

            // Chuyển hướng thay vì forward để tránh lỗi hiển thị
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh mục sản phẩm.");
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
            // Nhận dữ liệu từ form
            String productName = request.getParameter("productName");
            String categoryIdStr = request.getParameter("categoryId");
            String productPetType = request.getParameter("productPetType");
            String productPriceStr = request.getParameter("productPrice");
            String stockStr = request.getParameter("stock");
            String description = request.getParameter("description");

            // Kiểm tra rỗng
            if (Stream.of(productName, categoryIdStr, productPetType, productPriceStr, stockStr, description)
                    .anyMatch(param -> param == null || param.trim().isEmpty())) {
                throw new IllegalArgumentException("Vui lòng điền đầy đủ thông tin sản phẩm.");
            }

            // Kiểm tra tên sản phẩm không chứa ký tự đặc biệt (cho phép dấu cách)
            if (!productName.matches("^[a-zA-Z0-9\\sÀ-Ỹà-ỹ()]+$")) {
                throw new IllegalArgumentException("Tên sản phẩm không được chứa ký tự đặc biệt (chỉ cho phép chữ, số và dấu cách).");
            }

            // Kiểm tra kiểu dữ liệu
            int categoryId;
            double productPrice;
            int stock;

            try {
                categoryId = Integer.parseInt(categoryIdStr);
                productPrice = Double.parseDouble(productPriceStr);
                stock = Integer.parseInt(stockStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Giá và số lượng phải là số hợp lệ.");
            }

            // Kiểm tra giá trị hợp lệ
            if (categoryId <= 0) {
                throw new IllegalArgumentException("Danh mục không hợp lệ.");
            }
            if (productPrice <= 0 || productPrice > 50000000) {
                throw new IllegalArgumentException("Giá sản phẩm phải trong khoảng 0 - 50,000,000.");
            }
            if (stock < 0 || stock > 200) {
                throw new IllegalArgumentException("Số lượng sản phẩm phải trong khoảng 0 - 200.");
            }

            boolean productActive = stock > 0 && Boolean.parseBoolean(request.getParameter("productActive"));

            // Xử lý ảnh tải lên
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "products";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = "default.jpg"; // Ảnh mặc định nếu không có ảnh được tải lên
            Part filePart = request.getPart("productImage");

            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";

                int lastDotIndex = originalFileName.lastIndexOf('.');
                if (lastDotIndex != -1) {
                    fileExtension = originalFileName.substring(lastDotIndex).toLowerCase();
                }

                // Kiểm tra định dạng ảnh
                if (!fileExtension.matches("\\.(jpg|png|jpeg|gif)$")) {
                    throw new IllegalArgumentException("Chỉ chấp nhận ảnh định dạng JPG, PNG, JPEG, GIF.");
                }

                // Kiểm tra kích thước ảnh (giới hạn 5MB)
                if (filePart.getSize() > 5 * 1024 * 1024) {
                    throw new IllegalArgumentException("Kích thước ảnh quá lớn! Tối đa 5MB.");
                }

                File file = new File(realPath, originalFileName);
                while (file.exists()) {
                    String uniqueName = originalFileName.substring(0, lastDotIndex) + "_" + UUID.randomUUID() + fileExtension;
                    file = new File(realPath, uniqueName);
                }

                fileName = file.getName();
                filePart.write(realPath + File.separator + fileName);
            }

            // Tạo sản phẩm mới
            Product product = new Product(categoryId, productName, productPetType,
                    productPrice, fileName, stock, description, productActive);

            ProductDAO productDAO = new ProductDAO();
            boolean createSuccess = productDAO.createProduct(product);

            if (createSuccess) {
                request.getSession().setAttribute("successMessage", "Tạo sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
            } else {
                throw new Exception("Lỗi khi thêm sản phẩm vào cơ sở dữ liệu.");
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createproduct");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Tạo sản phẩm thất bại! Lỗi hệ thống.");
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/createproduct");
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
