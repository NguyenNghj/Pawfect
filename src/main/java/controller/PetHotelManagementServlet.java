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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.PetHotel;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class PetHotelManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet PetRoomsListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PetRoomsListServlet at " + request.getContextPath() + "</h1>");
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
        // Lấy tham số tìm kiếm từ request
        String search = request.getParameter("search");

        // Lấy số trang từ request, mặc định là trang 1 nếu không có
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, quay về trang đầu
            }
        }

        // Số lượng phòng trên mỗi trang
        int itemsPerPage = 5;
        List<PetHotel> allRooms;

        if (search != null && !search.trim().isEmpty()) {
            // Nếu có tìm kiếm, lấy danh sách phòng theo từ khóa
            allRooms = PetHotelDAO.searchPetRooms(search);
        } else {
            // Nếu không có tìm kiếm, lấy toàn bộ danh sách phòng
            allRooms = PetHotelDAO.getAllPetRooms();
        }

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) allRooms.size() / itemsPerPage);

        // Xác định vị trí bắt đầu và kết thúc
        int start = (currentPage - 1) * itemsPerPage;
        int end = Math.min(start + itemsPerPage, allRooms.size());

        // Lấy danh sách phòng theo trang hiện tại
        List<PetHotel> petRooms = allRooms.subList(start, end);

        // Gửi dữ liệu sang JSP
        request.setAttribute("petRooms", petRooms);
        request.setAttribute("searchQuery", search); // Giữ lại từ khóa tìm kiếm
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng đến trang hiển thị kết quả
        request.getRequestDispatcher("/dashboard/admin/petRoom.jsp").forward(request, response);
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
        processRequest(request, response);
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
