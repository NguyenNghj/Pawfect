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
        String sql = "SELECT SUM(total_amount) AS totalRevenue "
                + "FROM [pawfect].[dbo].[Orders]"
                + "WHERE MONTH(order_date) = ? AND status = N'Hoàn thành';";

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
}
