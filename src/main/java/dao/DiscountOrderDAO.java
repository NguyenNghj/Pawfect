/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.DiscountOrder;
import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
public class DiscountOrderDAO {
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    
    public boolean deleteDiscountOrder(int orderId) {
        String query = "DELETE FROM DiscountOrders WHERE order_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    public DiscountOrder getDiscountOrdersById(int orderId) {
        String query = "SELECT * FROM DiscountOrders WHERE order_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new DiscountOrder(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getDouble(4)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy voucher
    }
    
    public boolean addDiscountOrder(DiscountOrder discountOrder) {
        String query = "INSERT INTO DiscountOrders (order_id, voucher_id, discount_amount)"
                + "VALUES (?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, discountOrder.getOrderId());
            ps.setInt(2, discountOrder.getVoucherId());
            ps.setDouble(3, discountOrder.getDiscountAmount());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
