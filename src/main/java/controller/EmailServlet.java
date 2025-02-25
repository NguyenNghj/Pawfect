/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import jakarta.servlet.http.HttpSession;
import java.io.StringWriter;
import java.util.List;
import model.Order;
import model.OrderItem;
import util.Email;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class EmailServlet extends HttpServlet {

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
            out.println("<title>Servlet EmailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmailServlet at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession();
//        int orderId = (int) session.getAttribute("orderId");
        int orderId = 10;

        List<OrderItem> orderitems = OrderDAO.getOrderItemsByOrderId(orderId);
        double basicPrice = 0;
        for (OrderItem orderitem : orderitems) {
            basicPrice += orderitem.getSubtotal();
        }
        List<Order> orders = OrderDAO.getOrderByOrderId(orderId);

        request.setAttribute("basicPrice", basicPrice);
        request.setAttribute("orderitems", orderitems);
        request.setAttribute("orders", orders);

        try {
            // Chuyển JSP thành String
            String emailContent = renderJSPToString(request, response, "sendemail.jsp");

            Email.sendEmail("vuquangduc1404@gmail.com", "Xác nhận đơn hàng", emailContent);
        } catch (ServletException | IOException e) {
            e.printStackTrace(); 
            // Có thể hiển thị thông báo lỗi cho người dùng
            System.out.println("Co loi trong qua trinh gui email!!");
        } finally {
            response.sendRedirect("checkoutsuccess.jsp");
        }
    }

    // Chuyển JSP thành chuỗi HTML
    private String renderJSPToString(HttpServletRequest request, HttpServletResponse response, String jspPath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        HttpServletResponseWrapper responseWrapper = new HttpServletResponseWrapper(response) {
            public PrintWriter getWriter() {
                return writer;
            }
        };
        dispatcher.include(request, responseWrapper);
        return stringWriter.toString();
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
