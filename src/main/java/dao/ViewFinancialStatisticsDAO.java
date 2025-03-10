/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.Staff;

/**
 *
 * @author ADMIN
 */
public class ViewFinancialStatisticsDAO extends DBContext {
//sản phẩm

    public double getTotaMoneyByMonth(int month) {
        String sql = "SELECT SUM(oi.quantity) AS totalProducts "
                + "FROM [pawfect].[dbo].[OrderItems] oi "
                + "JOIN [pawfect].[dbo].[Orders] o ON oi.order_id = o.order_id "
                + "WHERE MONTH(o.order_date) = ? AND o.status = N'Hoàn thành';";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //doanh thu
    public double getTotaMoneyByMonthh(int month) {
        String sql = "SELECT SUM(o.total_amount - sm.shipping_fee) AS totalRevenue " +
                     "FROM Orders o " +
                     "JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id " +
                     "WHERE MONTH(order_date) = ? AND status = N'Hoàn thành'";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    //sp bán chạy

    public double getTotaMoneyByMonthhh(int month) {
        String sql = "SELECT SUM(oi.quantity) AS totalProducts "
                + "FROM [pawfect].[dbo].[OrderItems] oi "
                + "JOIN [pawfect].[dbo].[Orders] o ON oi.order_id = o.order_id "
                + "WHERE MONTH(o.order_date) = ? AND o.status = N'Hoàn thành';";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
     public List<Product> getTopSellingProducts() {
    List<Product> topProducts = new ArrayList<>();
String sql = "SELECT TOP 5 p.product_id, p.product_name, p.product_price, p.product_image, SUM(oi.quantity) AS total_sold " +
             "FROM [pawfect].[dbo].[OrderItems] oi " +
             "JOIN [pawfect].[dbo].[Products] p ON oi.product_id = p.product_id " +
             "JOIN [pawfect].[dbo].[Orders] o ON oi.order_id = o.order_id " +
             "WHERE o.status = N'Hoàn thành' " +
             "GROUP BY p.product_id, p.product_name, p.product_price, p.product_image " +
             "ORDER BY total_sold DESC";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Product p = new Product(
                rs.getInt("product_id"),
                rs.getString("product_name"),
                rs.getDouble("product_price"),
                rs.getString("product_image"),
                rs.getInt("total_sold"), // total_sold sẽ gán vào stock tạm thời
                true // active (mặc định true)
            );
            topProducts.add(p);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return topProducts;
}
     public List<Staff> getTopStaffs() {
        List<Staff> topStaffs = new ArrayList<>();
        String sql = "SELECT TOP 5 s.staff_id, s.full_name, COUNT(o.order_id) AS total_orders, " +
                     "SUM(oi.quantity) AS total_sold, SUM(o.total_amount - sm.shipping_fee) AS total_revenue " +
                     "FROM Orders o " +
                     "JOIN OrderItems oi ON o.order_id = oi.order_id " +
                     "JOIN Staffs s ON o.staff_id = s.staff_id " +
                     "JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id " +
                     "WHERE o.status = N'Hoàn thành' " +
                     "GROUP BY s.staff_id, s.full_name " +
                     "ORDER BY total_sold DESC";
        
        try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int staffId = rs.getInt("staff_id");
            String fullName = rs.getString("full_name");
            int totalOrders = rs.getInt("total_orders");
            int totalSold = rs.getInt("total_sold");
            double totalRevenue = rs.getDouble("total_revenue");
                // Chỉ sử dụng các thông tin cần thiết từ Staff model
                 Staff staff = new Staff(staffId, fullName, totalOrders, totalSold, totalRevenue);
            topStaffs.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return topStaffs;
    }
      public double getTotalMoneyFromPetHotelByMonth(int month) {
    String sql = "SELECT SUM(phb.total_price) AS totalRevenue " +
                 "FROM [pawfect].[dbo].[PetHotelBookings] phb " +
                 "WHERE MONTH(phb.booking_date) = ? AND phb.status = N'Đã duyệt';";

    try {
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, month);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return rs.getDouble(1);
        }
    } catch (Exception e) {
        e.printStackTrace(); // Thêm debug lỗi nếu cần
    }
    return 0;
}
}
