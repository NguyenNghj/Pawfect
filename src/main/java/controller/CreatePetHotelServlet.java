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
import java.util.List;
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
public class CreatePetHotelServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminAddRoomServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAddRoomServlet at " + request.getContextPath() + "</h1>");
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
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<PetHotel> roomList = PetHotelDAO.getAllPetRooms(); // Lấy danh sách phòng từ DAO
        request.setAttribute("roomList", roomList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("createpethotel.jsp");
        dispatcher.forward(request, response);
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
            // Lấy dữ liệu text từ form
            String roomName = request.getParameter("roomName");
            String roomType = request.getParameter("roomType");
            String minWeightStr = request.getParameter("minWeight");
            String maxWeightStr = request.getParameter("maxWeight");
            String quantityStr = request.getParameter("quantity");
            String pricePerNightStr = request.getParameter("pricePerNight");
            String description = request.getParameter("description");

            // Kiểm tra dữ liệu null hoặc rỗng
            if (roomName == null || roomName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên phòng không được để trống.");
                request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
                return;
            }
            if (roomType == null || roomType.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng chọn loại phòng.");
                request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
                return;
            }
            if (minWeightStr == null || minWeightStr.trim().isEmpty()
                    || maxWeightStr == null || maxWeightStr.trim().isEmpty()
                    || quantityStr == null || quantityStr.trim().isEmpty()
                    || pricePerNightStr == null || pricePerNightStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
                request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi dữ liệu số
            double minWeight = Double.parseDouble(minWeightStr);
            double maxWeight = Double.parseDouble(maxWeightStr);
            int quantity = Integer.parseInt(quantityStr);
            double pricePerNight = Double.parseDouble(pricePerNightStr);
            int availableQuantity = quantity;

            if (description == null) {
                description = "Không có mô tả";
            }

            // Xử lý ảnh tải lên
            String[] context = request.getServletContext().getRealPath("").split("target");
            String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "pethotel";

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = "default.jpg"; // Ảnh mặc định nếu không có ảnh tải lên
            Part filePart = request.getPart("petHotelImage");

            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(realPath + File.separator + fileName);
            }

            // Tạo object PetHotel
            PetHotel room = new PetHotel(roomName, fileName, roomType, minWeight, maxWeight, quantity, availableQuantity, pricePerNight, description);

            // Lưu vào database
            PetHotelDAO roomDAO = new PetHotelDAO();
            boolean createSuccess = roomDAO.addRoom(room);

            if (createSuccess) {
                request.getSession().setAttribute("successMessage", "Thêm phòng thành công!");
                response.sendRedirect("pethotel");
            } else {
                throw new Exception("Thêm phòng thất bại!");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ! Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống khi xử lý tệp ảnh.");
            request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Thêm phòng thất bại! Lỗi: " + e.getMessage());
            request.getRequestDispatcher("createpethotel.jsp").forward(request, response);
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
