
import controller.CheckoutServlet;
import static org.mockito.Mockito.*;
import static org.junit.Assert.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Voucher;
import dao.VoucherDAO;
import jakarta.servlet.http.Cookie;
import org.json.JSONObject;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

public class ApplyVoucherTest {

    private CheckoutServlet checkoutServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private VoucherDAO voucherDAO;
    private StringWriter responseWriter;

    @Before
    public void setUp() throws IOException {
        checkoutServlet = new CheckoutServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        voucherDAO = mock(VoucherDAO.class);
        responseWriter = new StringWriter();

        // Giả lập response.getWriter() để bắt kết quả JSON trả về
        when(response.getWriter()).thenReturn(new PrintWriter(responseWriter));
    }

    @Test
    public void testApplyVoucher_Success() throws SQLException, IOException, ServletException {
        // Giả lập dữ liệu
        when(request.getParameter("voucherCode")).thenReturn("SALE100K");
        when(request.getParameter("basePrice")).thenReturn("250000");

        // Giả lập cookie `customerId`
        Cookie customerCookie = new Cookie("customerId", "1");
        when(request.getCookies()).thenReturn(new Cookie[]{customerCookie});

        Voucher mockVoucher = new Voucher();
        mockVoucher.setVoucherId(1);
        mockVoucher.setDiscountPercentage(0);
        mockVoucher.setMaxDiscount(100000);
        mockVoucher.setMinOrderValue(200000);
        mockVoucher.setEndDate(new Timestamp(System.currentTimeMillis() + 86400000)); // Chưa hết hạn
        mockVoucher.setActive(true);

        when(voucherDAO.getVoucherByCode("SALE100K")).thenReturn(mockVoucher);

        // Thực thi phương thức applyVoucher
        checkoutServlet.applyVoucher(request, response);

        // Kiểm tra kết quả JSON
        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("success", jsonResponse.getString("status"));
        assertTrue(jsonResponse.has("discountValue"));
    }

    @Test
    public void testApplyVoucher_VoucherNotFound() throws SQLException, IOException, ServletException {
        when(request.getParameter("voucherCode")).thenReturn("SALE100%");
        when(request.getParameter("basePrice")).thenReturn("250000");
        when(voucherDAO.getVoucherByCode("SALE100%")).thenReturn(null);

        // Giả lập cookie `customerId`
        Cookie customerCookie = new Cookie("customerId", "1");
        when(request.getCookies()).thenReturn(new Cookie[]{customerCookie});

        checkoutServlet.applyVoucher(request, response);

        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("error", jsonResponse.getString("status"));
    }

    @Test
    public void testApplyVoucher_ExpiredVoucher() throws SQLException, IOException, ServletException {
        when(request.getParameter("voucherCode")).thenReturn("SALE50K");
        when(request.getParameter("basePrice")).thenReturn("250000");

        Voucher expiredVoucher = new Voucher();
        expiredVoucher.setEndDate(new Timestamp(System.currentTimeMillis() - 10000)); // Đã hết hạn
        expiredVoucher.setActive(true);

        when(voucherDAO.getVoucherByCode("SALE50K")).thenReturn(expiredVoucher);

        checkoutServlet.applyVoucher(request, response);

        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("outOfDateVoucher", jsonResponse.getString("status"));

    }

    @Test
    public void testApplyVoucher_InactiveVoucher() throws SQLException, IOException, ServletException {
        when(request.getParameter("voucherCode")).thenReturn("SALE70K");
        when(request.getParameter("basePrice")).thenReturn("250000");

        Voucher inactiveVoucher = new Voucher();
        inactiveVoucher.setEndDate(new Timestamp(System.currentTimeMillis() + 10000));
        inactiveVoucher.setActive(false);

        when(voucherDAO.getVoucherByCode("SALE70K")).thenReturn(inactiveVoucher);

        checkoutServlet.applyVoucher(request, response);

        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("isActiveVoucher", jsonResponse.getString("status"));
    }

    @Test
    public void testApplyVoucher_MinOrderValueNotMet() throws SQLException, IOException, ServletException {
        when(request.getParameter("voucherCode")).thenReturn("SALE1M");
        when(request.getParameter("basePrice")).thenReturn("250000");

        // Giả lập cookie `customerId`
        Cookie customerCookie = new Cookie("customerId", "1");
        when(request.getCookies()).thenReturn(new Cookie[]{customerCookie});

        Voucher voucher = new Voucher();
        voucher.setMinOrderValue(2000000); // Cần >= 2000000 mới dùng được
        voucher.setEndDate(new Timestamp(System.currentTimeMillis() + 10000));
        voucher.setActive(true);

        when(voucherDAO.getVoucherByCode("SALE1M")).thenReturn(voucher);

        checkoutServlet.applyVoucher(request, response);

        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("errorMinOrderValue", jsonResponse.getString("status"));
        assertEquals(2000000, jsonResponse.getInt("minOrderValue"));
    }

    @Test
    public void testApplyVoucher_AlreadyUsed() throws SQLException, IOException, ServletException {
        when(request.getParameter("voucherCode")).thenReturn("SALE100KUSE");
        when(request.getParameter("basePrice")).thenReturn("250000");

        // ✅ Giả lập cookie `customerId`
        Cookie customerCookie = new Cookie("customerId", "1");
        when(request.getCookies()).thenReturn(new Cookie[]{customerCookie});

        // ✅ Giả lập dữ liệu voucher
        Voucher usedVoucher = new Voucher();
        usedVoucher.setEndDate(new Timestamp(System.currentTimeMillis() + 10000)); // Chưa hết hạn
        usedVoucher.setActive(true);

        when(voucherDAO.getVoucherByCode("SALE100KUSE")).thenReturn(usedVoucher);

        // ✅ Giả lập số lần sử dụng voucher > 0 (đã sử dụng)
        when(voucherDAO.numberOfUseVoucher(1, "SALE100KUSE")).thenReturn(1);

        checkoutServlet.applyVoucher(request, response);

        JSONObject jsonResponse = new JSONObject(responseWriter.toString());
        assertEquals("voucherIsUse", jsonResponse.getString("status"));

    }

}
