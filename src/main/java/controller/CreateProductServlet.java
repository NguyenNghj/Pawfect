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

            request.setAttribute("categories", categories);
            if (categories == null || categories.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Không có danh mục nào. Vui lòng tạo ít nhất một danh mục.");
                response.sendRedirect(request.getContextPath() + "/dashboard/admin/product");
                return;
            }
            request.getRequestDispatcher("/dashboard/admin/createproduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi để debug (nên thay bằng Logger trong hệ thống lớn)
            // Thông báo lỗi để hiển thị trên giao diện
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh mục sản phẩm.");
            request.getRequestDispatcher("/dashboard/admin/createproduct.jsp").forward(request, response);
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
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productPetType = request.getParameter("productPetType");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            boolean productActive = false;
            if (stock != 0) {
                productActive = Boolean.parseBoolean(request.getParameter("productActive"));
            }
            String description = request.getParameter("description");

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
                File file = new File(realPath, originalFileName);

                // Nếu file đã tồn tại, đổi tên mới
                while (file.exists()) {
                    String extension = "";
                    int lastDotIndex = originalFileName.lastIndexOf('.');
                    if (lastDotIndex != -1) {
                        extension = originalFileName.substring(lastDotIndex);
                        originalFileName = originalFileName.substring(0, lastDotIndex);
                    }
                    String uniqueName = originalFileName + "_" + UUID.randomUUID() + extension;
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
                response.sendRedirect("/dashboard/admin/product");
                request.getSession().setAttribute("successMessage", "Tạo sản phẩm thành công!");
            } else {
                throw new Exception();
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (IOException | ServletException e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống khi xử lý tệp ảnh.");
            request.getRequestDispatcher("/dashboard/admin/product").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Tạo sản phẩm thất bại!");
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
