/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StatisticDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import model.PetHotel;
import model.Product;
import model.Staff;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class StatisticManagement extends HttpServlet {

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
            out.println("<title>Servlet StatisticManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatisticManagement at " + request.getContextPath() + "</h1>");
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
         StatisticDAO statisticDAO = new StatisticDAO(); // Lấy tham số month từ request
    String monthParam = request.getParameter("month");

if (monthParam != null && monthParam.equalsIgnoreCase("true")) {
    double[] orderss = new double[12]; 
    double[] bookingss = new double[12]; 
    double[] revenueData = new double[12]; 
    int[] countOrders = new int[12]; // Số lượng đơn hàng hoàn thành theo tháng
    int[] countBookings = new int[12]; // Số lượng phòng check-out theo tháng

    double totalOrder = 0;
    double totalBooking = 0;
    int totalCountOrder = 0; // Tổng số lượng đơn hàng hoàn thành trong tháng
    int totalCountBooking = 0; // Tổng số lượng phòng check-out trong tháng

    for (int i = 0; i < 12; i++) {
        int month = i + 1; 
        orderss[i] = statisticDAO.getTotalOrderByMonth(month);
        bookingss[i] = statisticDAO.getTotalBookingByMonth(month);
        revenueData[i] = orderss[i] + bookingss[i];

        countOrders[i] = statisticDAO.getOrderCountByMonth(month);
        countBookings[i] = statisticDAO.getBookingCountByMonth(month);

        totalOrder += orderss[i];
        totalBooking += bookingss[i];
        totalCountOrder += countOrders[i];
        totalCountBooking += countBookings[i];
    }

    double totalRevenue = totalOrder + totalBooking;

    request.setAttribute("orderss", orderss);
    request.setAttribute("bookingss", bookingss);
    request.setAttribute("revenueData", revenueData);
    request.setAttribute("totalOrder", totalOrder);
    request.setAttribute("totalBooking", totalBooking);
    request.setAttribute("totalRevenue", totalRevenue);
    request.setAttribute("totalCountOrder", totalCountOrder); // Tổng số đơn hàng
    request.setAttribute("totalCountBooking", totalCountBooking); // Tổng số phòng check-out
        request.setAttribute("days", new String[]{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"});
    request.setAttribute("countOrder", countOrders);
    request.setAttribute("countBooking", countBookings);
}

 else {
        // Thống kê theo ngày trong tuần
        double[] orders = new double[7];
        int[] countOrder = new int[7];
        double[] bookings = new double[7];
        int[] countBooking = new int[7];
        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

        double totalOrder = 0;
        int totalCountOrder = 0;
        double totalBooking = 0;
        int totalCountBooking = 0;

        for (int i = 0; i < 7; i++) {
            orders[i] = statisticDAO.getTotalOrderByDayOfWeek(days[i]);
            countOrder[i] = statisticDAO.getOrderCountByDayOfWeek(days[i]);
            totalOrder += orders[i];
            totalCountOrder += countOrder[i];

            bookings[i] = statisticDAO.getTotalBookingByDayOfWeek(days[i]);
            countBooking[i] = statisticDAO.getBookingCountByDayOfWeek(days[i]);
            totalBooking += bookings[i];
            totalCountBooking += countBooking[i];
        }

        double totalRevenue = totalOrder + totalBooking;
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("totalBooking", totalBooking);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalCountOrder", totalCountOrder);
        request.setAttribute("totalCountBooking", totalCountBooking);
        request.setAttribute("orders", orders);
        request.setAttribute("bookings", bookings);
            request.setAttribute("days", new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"});
    request.setAttribute("countOrder", countOrder);
    request.setAttribute("countBooking", countBooking);
    }

    // Lấy danh sách top sản phẩm, nhân viên, khách sạn
    List<Product> top5Product = statisticDAO.getTop5BestSellingProductsInWeek();
    List<Staff> topStaff = statisticDAO.getStaffRevenueInWeek();
    List<PetHotel> topPetHotel = statisticDAO.getTop5BestBookingHotelInWeek();

    request.setAttribute("top5Product", top5Product);
    request.setAttribute("topPetHotel", topPetHotel);
    request.setAttribute("topStaff", topStaff);

    // Chuyển hướng đến trang thống kê
    request.getRequestDispatcher("/dashboard/admin/statistic.jsp").forward(request, response);
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
