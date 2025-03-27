/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.OrderServlet.getCustomerIdFromCookies;
import dao.CartDAO;
import dao.CustomersDAO;
import dao.DiscountOrderDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import model.Customers;
import model.DiscountOrder;
import model.Order;
import model.OrderItem;
import model.Product;
import org.json.JSONException;
import org.json.JSONObject;
import util.Email;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
public class VNPAYServlet extends HttpServlet {

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
            out.println("<title>Servlet VNPAYServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VNPAYServlet at " + request.getContextPath() + "</h1>");
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
        vnPayPaymentReturn(request);
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

        JSONObject json = new JSONObject();
        response.setContentType("application/json");

        String customerIdStr = getCustomerIdFromCookies(request);
        int customerId = Integer.parseInt(customerIdStr);

        try {
            String name = request.getParameter("name").trim();
            String email = request.getParameter("email").trim();
            String address = request.getParameter("address").trim();
            String note = request.getParameter("note").trim();
            String phone = request.getParameter("phone").trim();
            String shippingMethod = request.getParameter("shippingMethod");
            String paymentMethod = request.getParameter("paymentMethod");
            // Gia cuoi cung sau khi ap ma (neu co)
            double totalCartPrice = Double.parseDouble(request.getParameter("totalPrice"));
            double salePrice = Double.parseDouble(request.getParameter("salePrice"));
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));

            System.out.println("totalCartPrice: " + totalCartPrice);
            System.out.println("salePrice: " + salePrice);

            // Kiem tra du lieu dau vao
            try {
                if (email == null || email.isEmpty()) {
                    throw new IllegalArgumentException("error-data-email-empty");
                }
                if (!isValidEmail(email)) {
                    throw new IllegalArgumentException("error-data-email-valid");
                }

                if (!isValidEmailLength(email)) {
                    throw new IllegalArgumentException("error-data-email-length");
                }

                if (name == null || name.isEmpty()) {
                    throw new IllegalArgumentException("error-data-name-empty");
                }

                if (!isValidName(name)) {
                    throw new IllegalArgumentException("error-data-name-valid");
                }

                if (!isValidNameLength(name)) {
                    throw new IllegalArgumentException("error-data-name-length");
                }

                if (phone == null || phone.isEmpty()) {
                    throw new IllegalArgumentException("error-data-phone-empty");
                }

                if (!isValidPhone(phone)) {
                    throw new IllegalArgumentException("error-data-phone-valid");
                }

                if (address == null || address.isEmpty()) {
                    throw new IllegalArgumentException("error-data-address-empty");
                }

                if (!isValidAddressCharacters(address)) {
                    throw new IllegalArgumentException("error-data-address-valid");
                }

                if (!isValidAddressLength(address)) {
                    throw new IllegalArgumentException("error-data-address-lenght");
                }

                if (!isValidAddressNotOnlyNumbers(address)) {
                    throw new IllegalArgumentException("error-data-address-number");
                }

                if (!isValidOrderNoteLength(note)) {
                    throw new IllegalArgumentException("error-data-note-valid");
                }

            } catch (IllegalArgumentException e) {
                System.out.println("Loi du lieu dau vao: " + e.getMessage());
                json.put("status", e.getMessage());
                response.getWriter().write(json.toString());
                return;
            }

            // Lay phuong thuc dat hang, thanh toan va trang thai don hang
            int shippingMethod_id = shippingMethod.equals("shipping-hoatoc") ? 2 : 1;
            int paymentMethod_id = paymentMethod.equals("payment-cash") ? 1 : 2;
            String status = paymentMethod.equals("payment-cash") ? "Chờ xác nhận" : "Đã huỷ";

            Order order = new Order(customerId, paymentMethod_id, shippingMethod_id, name, phone, address, note, totalCartPrice + salePrice, "Thanh toán thất bại hoặc bị gián đoạn", status);
            int orderId = 0;
            orderId = OrderDAO.insertOrder(order);
            // Tao don hang thanh cong
            if (orderId != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("orderId", orderId);
                System.out.println("Them don hang thanh cong.");

                // Neu tim duoc voucher thi ap dung voucher
                if (voucherId != 0) {
                    DiscountOrderDAO discountOrderDAO = new DiscountOrderDAO();
                    DiscountOrder discountOrder = new DiscountOrder(orderId, voucherId, totalCartPrice);
                    boolean check = discountOrderDAO.addDiscountOrder(discountOrder);
                    if (check) {
                        System.out.println("Them DiscountOrder thanh cong.");
                    } else {
                        System.out.println("Them DiscountOrder that bai!");
                    }
                }

                boolean remove = CartDAO.removeCart(customerId);

                ProductDAO productDAO = new ProductDAO();

                List<OrderItem> orderitems = OrderDAO.getOrderItemsByOrderId(orderId);
                for (OrderItem orderitem : orderitems) {
                    Product product = productDAO.getProductById(orderitem.getProductId());
                    product.setStock(product.getStock() - orderitem.getQuantity());
                    productDAO.updateProduct(product);
                }

                if (remove) {
                    System.out.println("Xoa gio hang thanh cong.");

                    String vnpayUrl = createVnPayPayment(totalCartPrice, String.valueOf(orderId + 2500000), String.valueOf(customerId));
                    System.out.println("createVnPayPayment: " + vnpayUrl);

                    json.put("vnpayUrl", vnpayUrl);
                    json.put("status", "success");
                } else {
                    System.out.println("Xoa gio hang that bai!!");
                    json.put("status", "error");
                }
            } else {
                System.out.println("Them don hang that bai!!");
                json.put("status", "error");
            }

            response.getWriter().write(json.toString());
        } catch (IOException | NumberFormatException | JSONException e) {
            System.out.println(e);
        } catch (SQLException ex) {
            Logger.getLogger(VNPAYServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:9999/vnpay-return.jsp";
    public static String vnp_TmnCode = "VTOTZ4XT";
    public static String vnp_HashSecret = "0VMRFDNISVU9RCQWG6PS91A486PA9HK4";
    public static String vnp_apiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

    // * 1 số tham số cần chú ý
    // vnp_Amount - giá tiền hoá đơn
    // vnp_OrderInfo - thông tin hoá đơn - ở đây truyền vào là id hoá đơn (khi huỷ thì xoá hoá đơn đã tạo)
    // vnp_IpAddr - địa chỉ Ip của người mua - ở đây truyền là id của người thanh toán
    public String createVnPayPayment(double amount, String orderId, String customerId) {
        String vnpTxnRef = getRandomNumber(8);
        Map<String, String> vnpParams = new HashMap<>();
        vnpParams.put("vnp_Version", "2.1.0");
        vnpParams.put("vnp_Command", "pay");
        vnpParams.put("vnp_TmnCode", vnp_TmnCode);
        vnpParams.put("vnp_CurrCode", "VND");
        vnpParams.put("vnp_TxnRef", vnpTxnRef);
        vnpParams.put("vnp_OrderType", "other");
        vnpParams.put("vnp_Locale", "vn");
        vnpParams.put("vnp_ReturnUrl", vnp_ReturnUrl);

        // Tham số cần chú ý
        vnpParams.put("vnp_IpAddr", customerId);
        vnpParams.put("vnp_OrderInfo", orderId);
        vnpParams.put("vnp_Amount", String.valueOf((long) (amount * 100)));

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnpCreateDate = formatter.format(cld.getTime());
        vnpParams.put("vnp_CreateDate", vnpCreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnpExpireDate = formatter.format(cld.getTime());
        vnpParams.put("vnp_ExpireDate", vnpExpireDate);

        List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
            String fieldValue = vnpParams.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                try {
                    hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()))
                            .append('=')
                            .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                        query.append('&');
                        hashData.append('&');
                    }
                } catch (UnsupportedEncodingException e) {
                    System.out.println("Error encoding URL parameters: " + e);
                }
            }
        }

        String vnpSecureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnpSecureHash);

        return vnp_PayUrl + "?" + query;
    }

    public static String hmacSHA512(final String key, final String data) {
        try {
            if (key == null || data == null) {
                throw new NullPointerException();
            }
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] result = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception ex) {
            return "";
        }
    }

    public String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public Integer vnPayPaymentReturn(HttpServletRequest request) {
        Map<String, String> vnp_Params = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String paramName = params.nextElement();
            vnp_Params.put(paramName, request.getParameter(paramName));
        }
        String vnp_SecureHash = vnp_Params.remove("vnp_SecureHash");

        List<String> fields = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fields);

        StringBuilder hashData = new StringBuilder();
        for (int i = 0; i < fields.size(); i++) {
            String key = fields.get(i);
            String value = vnp_Params.get(key);
            hashData.append(key).append("=").append(value);
            if (i < fields.size() - 1) {
                hashData.append("&");
            }
        }

        String result = hashData.toString(); // Đây là chuỗi hashData giống với bản Java 8

        String secureHash = hmacSHA512(vnp_HashSecret, result);

        if (secureHash.equals(vnp_SecureHash)) {
            // Kiểm tra trạng thái thanh toán và xử lý đơn hàng
            String responseCode = vnp_Params.get("vnp_ResponseCode");
            if ("00".equals(responseCode)) {
                return 0; // Thành công
            } else {
                return 1; // Thất bại - huỷ khi thanh toán
            }
        } else {
            return null; // Thất bại - lỗi chữ ký (vnp_HashSecret) sai
        }
    }

    // Phương thức kiểm tra fullname hợp lệ
    private boolean isValidName(String name) {
        String nameRegex = "^[A-Za-zÀ-Ỹà-ỹ\\s]+$"; // Chỉ cho phép chữ cái và khoảng trắng
        return name.matches(nameRegex);
    }

    // Phuong thuc kiem tra ten khong vuot qua 100 ky tu
    private boolean isValidNameLength(String name) {
        return name != null && name.length() <= 100;
    }

    // Phương thức kiểm tra email hợp lệ (không bắt đầu bằng số)
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z][A-Za-z0-9._%+-]*@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    // Phuong thuc kiem tra email khong vuot qua 255 ky tu
    private boolean isValidEmailLength(String email) {
        return email != null && email.length() <= 255;
    }

    // Phương thức kiểm tra số điện thoại hợp lệ (10-11 chữ số)
    private boolean isValidPhone(String phone) {
        String phoneRegex = "^\\d{10,11}$"; // Chỉ chấp nhận số và có độ dài từ 10-11 chữ số
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    // Kiểm tra địa chỉ chỉ chứa chữ cái, số và khoảng trắng (không chứa ký tự đặc biệt)
    private boolean isValidAddressCharacters(String address) {
        return address != null && address.matches("^[a-zA-ZÀ-ỹ0-9\\s,.]+$");
    }

    // Kiểm tra địa chỉ không phải toàn số
    private boolean isValidAddressNotOnlyNumbers(String address) {
        return address != null && !address.matches("^\\d+$");
    }

    // Kiểm tra địa chỉ không vượt quá 255 ký tự
    private boolean isValidAddressLength(String address) {
        return address != null && address.length() <= 255;
    }

    // Phuong thuc kiem tra ghi chu khong vuot qua 500 ky tu
    private boolean isValidOrderNoteLength(String orderNote) {
        return orderNote != null && orderNote.length() <= 500;
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
