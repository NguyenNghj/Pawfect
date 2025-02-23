/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.ViewFinancialStatisticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class ViewFinancialStatisticsServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewFinancialStatisticsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewFinancialStatisticsServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ViewFinancialStatisticsDAO dao = new ViewFinancialStatisticsDAO();
        double Month1 = dao.getTotaMoneyByMonth(01);
        double Month2 = dao.getTotaMoneyByMonth(02);
        double Month3 = dao.getTotaMoneyByMonth(03);
        double Month4 = dao.getTotaMoneyByMonth(04);
        double Month5 = dao.getTotaMoneyByMonth(05);
        double Month6 = dao.getTotaMoneyByMonth(06);
        double Month7 = dao.getTotaMoneyByMonth(07);
        double Month8 = dao.getTotaMoneyByMonth(8);
        double Month9 = dao.getTotaMoneyByMonth(9);
        double Month10 = dao.getTotaMoneyByMonth(10);
        double Month11 = dao.getTotaMoneyByMonth(11);
        double Month12 = dao.getTotaMoneyByMonth(12);

        request.setAttribute("Month1", Month1);
        request.setAttribute("Month2", Month2);
        request.setAttribute("Month3", Month3);
        request.setAttribute("Month4", Month4);
        request.setAttribute("Month5", Month5);
        request.setAttribute("Month6", Month6);
        request.setAttribute("Month7", Month7);
        request.setAttribute("Month8", Month8);
        request.setAttribute("Month9", Month9);
        request.setAttribute("Month10", Month10);
        request.setAttribute("Month11", Month11);
        request.setAttribute("Month12", Month12);

        request.getRequestDispatcher("viewfinancialstatistics.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
