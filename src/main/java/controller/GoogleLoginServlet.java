/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.GoogleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.GoogleAccount;

/**
 *
 * @author LENOVO
 */
public class GoogleLoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          
       String code = request.getParameter("code");
   GoogleDAO gg = new GoogleDAO();
 String accessToken = gg.getToken(code);
        System.out.print(accessToken);
        GoogleAccount acc = gg.getUserInfo(accessToken);
  //      UserDAO userDAO = new UserDAO();
//       // if(userDAO.checkGoogleExists(acc.getId()))
//        {
//         String customer=  userDAO.getCustomerId(acc.getId());
//             Cookie customerId = new Cookie("customerId", customer);
//            customerId.setMaxAge(60 * 60 * 24 * 1);
//            response.addCookie(customerId);
//        response.sendRedirect("home.jsp");
//        }
//        else{
//            userDAO.insertGoogleAcc(acc);
//          String customer=  userDAO.getCustomerId(acc.getId());
//             Cookie customerId = new Cookie("customerId", customer);
//            customerId.setMaxAge(60 * 60 * 24 * 1);
//            response.addCookie(customerId);
        response.sendRedirect("home.jsp");
        

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
        processRequest(request, response);
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
