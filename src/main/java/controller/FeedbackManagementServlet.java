/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Feedback;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class FeedbackManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet FeedbackManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackManagementServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "view":
                    viewFeedbackList(request, response);
                    break;
                default:
                    // listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }
    
    private void viewFeedbackList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Feedback> feedbacks = null;
        try {
//            int customerId = 1;
            int status = Integer.parseInt(request.getParameter("status"));
            
            if(status != 0){
                feedbacks = FeedbackDAO.getProductFeedbackByRating(status);
            } else {
                feedbacks = FeedbackDAO.getAllProductFeedback();
            }

//            switch (status) {
//                case "5s":
//                    feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ xác nhận");
//                    break;
//                case "4s":
//                    feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ lấy hàng");
//                    break;
//                case "3s":
//                    feedbacks = FeedbackDAO.getAllOrderByStatus("Chờ giao hàng");
//                    break;
//                case "2s":
//                    feedbacks = FeedbackDAO.getAllOrderByStatus("Hoàn thành");
//                    break;
//                case "1s":
//                    feedbacks = FeedbackDAO.getAllOrderByStatus("Yêu cầu huỷ...");
//                    break;
//                default:
//                    feedbacks = FeedbackDAO.getAllProductFeedback();
//            }

            request.setAttribute("feedbackStatus", status);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("/dashboard/staff/feedback.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            System.out.println(e);
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
        doGet(request, response);
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
