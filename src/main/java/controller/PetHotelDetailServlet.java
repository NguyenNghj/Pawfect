/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.PetHotelDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartItem;
import model.PetHotel;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class PetHotelDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet PetHotelDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PetHotelDetailServlet at " + request.getContextPath() + "</h1>");
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
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("pethotel?error=missing_id");
            return;
        }

        try {
            int roomId = Integer.parseInt(idParam);
            PetHotel room = PetHotelDAO.getPetRoomById(roomId);

            if (room != null) {
                request.setAttribute("room", room);

                // Lấy danh sách phòng tương tự
                List<PetHotel> similarRooms = PetHotelDAO.getSimilarRooms(room.getRoomType(), roomId);
                request.setAttribute("similarRooms", similarRooms);

                // Lấy customerId từ Cookie
                String username = getCookieValue(request, "customerId");
                if (username == null) {
                    System.out.println("Không tìm thấy customerId!");
                    username = "0";
                }

                int totalQuantity = 0;
                int customerId = Integer.parseInt(username);

                // Lay tong so san pham trong gio hang (header)
                List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
                if (!cartItems.isEmpty()) {
                    for (CartItem cartItem : cartItems) {
                        totalQuantity += cartItem.getQuantity();
                    }
                }
                request.setAttribute("totalQuantity", totalQuantity);

                RequestDispatcher dispatcher = request.getRequestDispatcher("pethoteldetail.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("pethotel?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("pethotel?error=invalid_id");
        }
    }

    // Hàm lấy giá trị Cookie theo tên
    private String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
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
