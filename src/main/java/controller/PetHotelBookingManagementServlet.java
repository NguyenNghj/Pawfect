/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.PetHotelBookingDAO;
import dao.PetHotelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Comparator;
import java.util.List;
import model.PetHotelBooking;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class PetHotelBookingManagementServlet extends HttpServlet {

    private PetHotelBookingDAO bookingDAO = new PetHotelBookingDAO();

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
            out.println("<title>Servlet PetHotelBookingManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PetHotelBookingManagementServlet at " + request.getContextPath() + "</h1>");
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
        String searchQuery = request.getParameter("search");
        String bookingId = request.getParameter("bookingId");
        List<PetHotelBooking> bookings;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            bookings = PetHotelBookingDAO.searchBookingsByCustomerName(searchQuery);
        } else {
            bookings = PetHotelBookingDAO.getAllBookings();
        }

        // Sắp xếp theo ngày đặt phòng mới nhất
        bookings.sort(Comparator.comparing(PetHotelBooking::getBookingDate).reversed());

        // Kiểm tra nếu chỉ lấy chi tiết booking (AJAX request)
        if (bookingId != null && !bookingId.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(bookingId);
                PetHotelBooking bookingdetail = PetHotelBookingDAO.getBookingByIdForStaff(id);

                if (bookingdetail != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(new Gson().toJson(bookingdetail)); // Trả JSON về client
                    out.flush();
                    return; // Kết thúc luôn, không forward sang JSP
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        // Trường hợp load trang bình thường
        request.setAttribute("bookings", bookings);
        request.setAttribute("searchQuery", searchQuery);

        request.getRequestDispatcher("booking.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        String bookingId = request.getParameter("bookingId");
        String filter = request.getParameter("filter");

        String staffId = getStaffIdFromCookies(request); // Lấy ID nhân viên từ cookie

        if (action != null && bookingId != null && staffId != null) {
            try {
                int bookingID = Integer.parseInt(bookingId);
                int staffID = Integer.parseInt(staffId); // Chuyển từ String sang int
                PetHotelBooking booking = PetHotelBookingDAO.getBookingById(bookingID);
                if (booking != null) {
                    boolean success = false;
                    int roomId = booking.getRoomId();
                    int petId = booking.getPetId();
                    switch (action) {
                        case "approve":
                            boolean isAvailableForApproval = PetHotelBookingDAO.isRoomAvailable(roomId, booking.getCheckIn(), booking.getCheckOut());
                            if (!isAvailableForApproval) {
                                request.getSession().setAttribute("errorMessage", "Vui lòng từ chối đặt lịch cho phòng này!");
                            } else {
                                success = PetHotelBookingDAO.updateBookingStatus(bookingID, "Đã duyệt", staffID);
                            }
                            break;

                        case "cancel":
                            success = PetHotelBookingDAO.updateBookingStatus(bookingID, "Đã hủy", staffID);
                            break;
                        case "checkin":
                            if (PetHotelDAO.decreaseAvailableQuantity(roomId)) { // Giảm số lượng phòng trống
                                success = PetHotelBookingDAO.updateBookingStatus(bookingID, "Đã nhận phòng", staffID);
                            } else {
                                request.getSession().setAttribute("errorMessage", "Hiện tại không còn phòng trống cho loại phòng này!");
                            }
                            break;
                        case "checkout":
                            if (PetHotelDAO.increaseAvailableQuantity(roomId)) { // Tăng số lượng phòng trống
                                success = PetHotelBookingDAO.updateBookingStatus(bookingID, "Đã trả phòng", staffID);
                            }
                            break;
                        default:
                            break;
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String encodedFilter = (filter != null) ? URLEncoder.encode(filter, StandardCharsets.UTF_8.toString()) : "";
        response.sendRedirect("pethotelbooking?filter=" + encodedFilter);
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

    // Lấy Cookie nhân viên
    private String getStaffIdFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("staffId")) { // Giả sử cookie lưu staffId
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

}



