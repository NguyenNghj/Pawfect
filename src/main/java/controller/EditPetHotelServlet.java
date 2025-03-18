/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PetHotelDAO;
import jakarta.servlet.RequestDispatcher;
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
import model.PetHotel;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB trước khi lưu vào disk
        maxFileSize = 1024 * 1024 * 10, // Tối đa 10MB
        maxRequestSize = 1024 * 1024 * 50 // Tổng request tối đa 50MB
)
/**
 *
 * @author Nguyen Tien Thanh
 */
public class EditPetHotelServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminEditRoomServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminEditRoomServlet at " + request.getContextPath() + "</h1>");
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
            // Lấy tham số room_id từ request
            String roomIdParam = request.getParameter("roomId");

            // Kiểm tra room_id có null hoặc rỗng không
            if (roomIdParam == null || roomIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu room_id");
                return;
            }

            // Chuyển đổi room_id thành số nguyên
            int roomId = Integer.parseInt(roomIdParam);

            // Gọi DAO để lấy thông tin phòng
            PetHotel room = PetHotelDAO.getPetRoomById(roomId);

            // Kiểm tra xem room có tồn tại không
            if (room != null) {
                request.setAttribute("room", room);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editpethotel.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy phòng");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "room_id không hợp lệ");
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
            String roomIdParam = request.getParameter("roomId");
            String roomName = request.getParameter("roomName");
            String roomType = request.getParameter("roomType");
            String minWeightStr = request.getParameter("minWeight");
            String maxWeightStr = request.getParameter("maxWeight");
            String quantityStr = request.getParameter("quantity");
            String pricePerNightStr = request.getParameter("pricePerNight");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String existingImage = request.getParameter("existingImage");

            // Kiểm tra dữ liệu null hoặc rỗng
            if (roomIdParam == null || roomIdParam.trim().isEmpty()
                    || roomName == null || roomName.trim().isEmpty()
                    || roomType == null || roomType.trim().isEmpty()
                    || minWeightStr == null || minWeightStr.trim().isEmpty()
                    || maxWeightStr == null || maxWeightStr.trim().isEmpty()
                    || quantityStr == null || quantityStr.trim().isEmpty()
                    || pricePerNightStr == null || pricePerNightStr.trim().isEmpty()) {

                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
                request.getRequestDispatcher("editpethotel.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi dữ liệu số
            int roomId = Integer.parseInt(roomIdParam.trim());
            double minWeight = Double.parseDouble(minWeightStr.trim());
            double maxWeight = Double.parseDouble(maxWeightStr.trim());
            int quantity = Integer.parseInt(quantityStr.trim());
            double pricePerNight = Double.parseDouble(pricePerNightStr.trim());
            int availableQuantity = quantity;

            if (description == null) {
                description = "Không có mô tả";
            }

            // Xử lý đường dẫn lưu ảnh
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator
                    + "webapp" + File.separator + "img" + File.separator + "pethotel";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Xử lý file ảnh mới
            Part filePart = request.getPart("petHotelImage");
            String newFileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    newFileName = Paths.get(submittedFileName).getFileName().toString();
                }
            }

            // Nếu có ảnh mới, lưu ảnh và cập nhật đường dẫn
            if (newFileName != null) {
                filePart.write(realPath + File.separator + newFileName);

//                // Xóa ảnh cũ nếu tồn tại
//                if (existingImage != null && !existingImage.isEmpty()) {
//                    File oldImageFile = new File(realPath + File.separator + existingImage);
//                    if (oldImageFile.exists()) {
//                        oldImageFile.delete();
//                    }
//                }
            }

            // Tạo object PetHotel với ảnh mới (nếu có)
            PetHotel room = new PetHotel(roomId, roomName, newFileName != null ? newFileName : existingImage,
                    roomType, minWeight, maxWeight, quantity, availableQuantity,
                    pricePerNight, description, status);

            // Cập nhật vào database
            PetHotelDAO roomDAO = new PetHotelDAO();
            boolean updateSuccess = roomDAO.updatePetRoom(room);

            if (updateSuccess) {
                request.getSession().setAttribute("successMessage", "Cập nhật phòng thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Chỉnh sửa phòng thất bại!");
            }
            response.sendRedirect(request.getContextPath() + "/dashboard/admin/pethotel");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("editpethotel.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống khi xử lý tệp ảnh.");
            request.getRequestDispatcher("editpethotel.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Chỉnh sửa phòng thất bại! Lỗi: " + e.getMessage());
            request.getRequestDispatcher("editpethotel.jsp").forward(request, response);
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
