/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RegisterDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.User;

/**
 *
 * @author LENOVO
 */
public class RegisterGoogle extends HttpServlet {

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
            out.println("<title>Servlet RegisterGoogle</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterGoogle at " + request.getContextPath() + "</h1>");
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("registergoogle.jsp");
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
        try {
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("ggEmail");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String birthDateStr = request.getParameter("birthDate");
            Date birthDate = null;

            try {
                birthDate = Date.valueOf(birthDateStr);
            } catch (IllegalArgumentException e) {
                response.sendRedirect("/registergoogle.jsp?error=InvalidDate");
                return;
            }

            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");

            UserDAO userDAO = new UserDAO();
RegisterDAO registerDAO = new RegisterDAO();
            try {
               registerDAO.register(new User(email, password, fullName, phoneNumber, address, gender, birthDate));
                String customer = userDAO.getCustomerId(email);

                Cookie customerId = new Cookie("customerId", customer);
                customerId.setMaxAge(60 * 60 * 24 * 1);
                response.addCookie(customerId);
                response.sendRedirect("/registergoogle.jsp?success=true");
            } catch (Exception e) {
                e.printStackTrace(); // Ghi log lỗi
                response.sendRedirect("/registergoogle.jsp?error=DatabaseError");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            response.sendRedirect("/registergoogle.jsp?error=UnexpectedError");
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
