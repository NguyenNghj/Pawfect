/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.CustomersDAO;
import dao.ProductDAO;
import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;
import model.CartItem;
import model.Customers;
import model.Product;
import model.Voucher;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class CheckoutServlet extends HttpServlet {

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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
                case "voucher":
                    applyVoucher(request, response);
                    break;
                default:
                    // listNhanVien(request, response);
                    break;
            }
        } catch (ServletException | IOException | SQLException e) {
            throw new ServletException(e);
        }
    }

    public void applyVoucher(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        try {
            String voucherCode = request.getParameter("voucherCode").trim();
            System.out.println("voucherCode: " + voucherCode);

            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            System.out.println("basePrice: " + basePrice);

            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);

            // Kiem tra voucher da het han su dung hay chua?
            Timestamp endDate = voucher.getEndDate();
            Timestamp startDate = voucher.getStartDate();
            Timestamp now = new Timestamp(System.currentTimeMillis());

            // Neu voucher khong hop le
            if (voucher == null || now.before(startDate)) {
                System.out.println("Ma khuyen mai khong hop le hoac khong ton tai!");
                json.put("status", "error");

                // Nguoc lai
            } else {

                // Neu voucher da het han su dung
                if (now.after(endDate)) {
                    System.out.println("Voucher da het han su dung!");
                    json.put("status", "outOfDateVoucher");
                    response.getWriter().write(json.toString());
                    response.getWriter().flush();
                    return;
                }

                // Kiem tra voucher con hoat dong khong?
                if (voucher.isActive() == false) {
                    System.out.println("Voucher khong con hoat dong!");
                    json.put("status", "isActiveVoucher");
                    response.getWriter().write(json.toString());
                    response.getWriter().flush();
                    return;
                }

                // Lay customerId tu Cookie
                String customerIdStr = getCustomerIdFromCookies(request);
                int customerId = Integer.parseInt(customerIdStr);

                // Check xem khach da su dung voucher do hay chua?
                int numberOfUseVoucher = voucherDAO.numberOfUseVoucher(customerId, voucherCode);
                if (numberOfUseVoucher > 0) {
                    System.out.println("Voucher da duoc su dung truoc do!");
                    json.put("status", "voucherIsUse");
                    response.getWriter().write(json.toString());
                    response.getWriter().flush();
                    return;
                } else if (numberOfUseVoucher == 0) {
                    System.out.println("Voucher chua duoc su dung.");
                } else {
                    System.out.println("Loi! Khong kiem tra duoc.");
                    return;
                }

                System.out.println("Lay ma khuyen mai thanh cong.");

                if (basePrice < voucher.getMinOrderValue()) {
                    System.out.println("Tien don hang khong dat gia tri toi thieu!");
                    json.put("status", "errorMinOrderValue");
                    json.put("minOrderValue", voucher.getMinOrderValue());
                    response.getWriter().write(json.toString());
                    response.getWriter().flush();
                    return;
                }

                // Khuyen mai theo gia tien
                if (voucher.getDiscountAmount() != 0) {
                    json.put("discountValue", voucher.getDiscountAmount());

                    // Khuyen mai theo %
                } else {
                    double salePrice = basePrice * (voucher.getDiscountPercentage() / 100.0);
                    System.out.println("salePrice: " + salePrice);
                    // Neu so tien giam vuot qua quy dinh thi lay so tien giam toi da
                    if (salePrice > voucher.getMaxDiscount()) {
                        json.put("discountValue", voucher.getMaxDiscount());
                    } else {
                        json.put("discountValue", salePrice);
                    }
                }

                json.put("voucherId", voucher.getVoucherId());
                json.put("status", "success");
            }
            response.getWriter().write(json.toString());
            response.getWriter().flush();

        } catch (IOException | JSONException e) {
            e.printStackTrace(); // Hiện lỗi trong console server
        }

    }

    private void viewCheckout(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        // Lay customerId tu Cookie
        String customerIdStr = getCustomerIdFromCookies(request);
        int customerId = Integer.parseInt(customerIdStr);

        List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
        ProductDAO productDAO = new ProductDAO();

        int totalQuantity = 0;
        if (customerIdStr != null) {
            try {

                Iterator<CartItem> iterator = cartItems.iterator();
                while (iterator.hasNext()) {
                    CartItem cartItem = iterator.next();
                    Product product = productDAO.getProductById(cartItem.getProductId());

                    // Neu san pham trong gio hang vuot qua ton kho thi xoa san pham do
                    if (cartItem.getQuantity() > product.getStock() || product.isActive() == false) {
                        iterator.remove(); // Xóa phần tử an toàn khi đang lặp
                        CartDAO.removeProductFromCart(product.getProductId(), customerId);
                    }

                    totalQuantity += cartItem.getQuantity();
                    System.out.println("totalQuantity: " + totalQuantity);
                }

                totalQuantity = cartItems.stream().mapToInt(CartItem::getQuantity).sum();
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Dữ liệu khách hàng không hợp lệ.");
            }
        }

        if (cartItems.isEmpty()) {
            response.sendRedirect("/cart?&action=view");
            return;
        }

        double totalCartPrice = CartDAO.getTotalCartByCustomerId(customerId);

        VoucherDAO voucherDAO = new VoucherDAO();
        Voucher voucher = voucherDAO.getVoucherByCode("LANDAU");
        if (voucher != null) {
            int count = 0;
            // Kiem tra voucher da het han su dung hay chua?
            Timestamp endDate = voucher.getEndDate();
            Timestamp now = new Timestamp(System.currentTimeMillis());

            // Neu voucher da het han su dung
            if (now.after(endDate)) {
                System.out.println("Voucher da het han su dung!");
                count++;
            }

            // Kiem tra voucher con hoat dong khong?
            if (voucher.isActive() == false) {
                System.out.println("Voucher khong con hoat dong!");
                count++;
            }

            // Check xem khach da su dung voucher do hay chua?
            int numberOfUseVoucher = voucherDAO.numberOfUseVoucher(customerId, "LANDAU");
            if (numberOfUseVoucher > 0) {
                System.out.println("Voucher da duoc su dung truoc do!");
                count++;
            } else if (numberOfUseVoucher == 0) {
                System.out.println("Voucher chua duoc su dung.");
            } else {
                System.out.println("Loi! Khong kiem tra duoc.");
                count++;
            }

            System.out.println("Count: " + count);
            if (count == 0) {
                request.setAttribute("voucher", voucher);
            }
        } else {
            System.out.println("Voucher: " + voucher);
        }

        Customers customers = CustomersDAO.getCustomerById(customerId);
        request.setAttribute("emailCustomer", customers.getEmail());
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalCartPrice", totalCartPrice);
        request.setAttribute("totalQuantity", totalQuantity);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    public static String getCustomerIdFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
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
