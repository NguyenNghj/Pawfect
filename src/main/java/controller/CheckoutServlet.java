/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.CartItem;
import org.json.JSONObject;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class CheckoutServlet extends HttpServlet {
    
    private double totalCartPrice;
    private double shippingCost;
    private int totalQuantity;
    private List<CartItem> cartItems;

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
                    viewCheckout(request, response);
                    break;
                case "get":
                    getDataToOrder(request, response);
                    break;
                case "order":
                    submitOrder(request, response);
                    break;
                default:
//                    listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }
    
    private void submitOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = 1;

        cartItems = CartDAO.getCartByCustomerId(customerId);
        
        totalQuantity = 0;
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }

        totalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalCartPrice", (totalCartPrice + shippingCost));
        request.setAttribute("shippingCost", shippingCost);
        request.setAttribute("totalQuantity", totalQuantity);
        
        request.getRequestDispatcher("checkoutsuccess.jsp").forward(request, response);
    }

    private void getDataToOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = 1;

        cartItems = CartDAO.getCartByCustomerId(customerId);

        totalQuantity = 0;
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }

        totalCartPrice = Double.parseDouble(request.getParameter("totalPrice"));
        shippingCost = Double.parseDouble(request.getParameter("shippingCost"));
        
        JSONObject json = new JSONObject();
        response.setContentType("application/json");
        json.put("status", "success");
             
        response.getWriter().write(json.toString());
    }

    private void viewCheckout(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int customerId = 1;

        cartItems = CartDAO.getCartByCustomerId(customerId);

        totalQuantity = 0;
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }

        totalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalCartPrice", totalCartPrice);
        request.setAttribute("totalQuantity", totalQuantity);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
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
