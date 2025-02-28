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
public class DashboardServlet extends HttpServlet {
   
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
            out.println("<title>Servlet DashboardServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath () + "</h1>");
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
        // Hiển thị tổng sản phẩm
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
// Hiển thị tổng tiền 
        double Monthh1 = dao.getTotaMoneyByMonthh(01);
        double Monthh2 = dao.getTotaMoneyByMonthh(02);
        double Monthh3 = dao.getTotaMoneyByMonthh(03);
        double Monthh4 = dao.getTotaMoneyByMonthh(04);
        double Monthh5 = dao.getTotaMoneyByMonthh(05);
        double Monthh6 = dao.getTotaMoneyByMonthh(06);
        double Monthh7 = dao.getTotaMoneyByMonthh(07);
        double Monthh8 = dao.getTotaMoneyByMonthh(8);
        double Monthh9 = dao.getTotaMoneyByMonthh(9);
        double Monthh10 = dao.getTotaMoneyByMonthh(10);
        double Monthh11 = dao.getTotaMoneyByMonthh(11);
        double Monthh12 = dao.getTotaMoneyByMonthh(12);

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
        
       request.setAttribute("Monthh1", Monthh1);
request.setAttribute("Monthh2", Monthh2);
request.setAttribute("Monthh3", Monthh3);
request.setAttribute("Monthh4", Monthh4);
request.setAttribute("Monthh5", Monthh5);
request.setAttribute("Monthh6", Monthh6);
request.setAttribute("Monthh7", Monthh7);
request.setAttribute("Monthh8", Monthh8);
request.setAttribute("Monthh9", Monthh9);
request.setAttribute("Monthh10", Monthh10);
request.setAttribute("Monthh11", Monthh11);
request.setAttribute("Monthh12", Monthh12);


        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
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
