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
import java.sql.SQLException;
import model.PetHotel;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class AdminEditRoomServlet extends HttpServlet {

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
        int roomId = Integer.parseInt(request.getParameter("room_id"));
        PetHotel room = PetHotelDAO.getPetRoomById(roomId);
        if (room != null) {
            request.setAttribute("room", room);
            RequestDispatcher dispatcher = request.getRequestDispatcher("editroom.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Room not found");
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
        int roomId = Integer.parseInt(request.getParameter("room_id"));
        String roomName = request.getParameter("room_name");
        String roomImage = request.getParameter("room_image");
        String roomType = request.getParameter("room_type");
        double minWeight = Double.parseDouble(request.getParameter("min_weight"));
        double maxWeight = Double.parseDouble(request.getParameter("max_weight"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double pricePerNight = Double.parseDouble(request.getParameter("price_per_night"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        boolean isActive = Boolean.parseBoolean(request.getParameter("is_active"));

        PetHotel room = new PetHotel();
        room.setRoomId(roomId);
        room.setRoomName(roomName);
        room.setRoomImage(roomImage);
        room.setRoomType(roomType);
        room.setMinWeight(minWeight);
        room.setMaxWeight(maxWeight);
        room.setQuantity(quantity);
        room.setPricePerNight(pricePerNight);
        room.setDescription(description);
        room.setStatus(status);
        

        PetHotelDAO dao = new PetHotelDAO();
        boolean isUpdated = dao.updatePetRoom(room);

        if (isUpdated) {
            response.sendRedirect("petroom"); // Sau khi cập nhật, chuyển hướng về danh sách phòng
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update the room");
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
