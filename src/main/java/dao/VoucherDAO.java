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
import model.Voucher;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class VoucherDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int numberOfUseVoucher(int customerId, String voucherCode) {
        String query = "SELECT COUNT(*)\n"
                + "FROM DiscountOrders d\n"
                + "JOIN Orders o ON d.order_id = o.order_id\n"
                + "JOIN Voucher v ON d.voucher_id = v.voucher_id\n"
                + "WHERE o.customer_id = ? AND v.code = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerId);
            ps.setString(2, voucherCode);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; 
    }

    public List<Voucher> getAllVoucher() {
        List<Voucher> voucherList = new ArrayList<>();
        String query = "SELECT voucher_id, code, description, discount_percentage, discount_amount, min_order_value, max_discount, start_date, end_date, is_active\n"
                + "FROM Voucher";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                voucherList.add(new Voucher(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getTimestamp(8),
                        rs.getTimestamp(9),
                        rs.getBoolean(10)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return voucherList;
    }

    public Voucher getVoucherByCode(String voucherCode) {
        String query = "SELECT voucher_id, code, description, discount_percentage, discount_amount, min_order_value, max_discount, start_date, end_date, is_active "
                + "FROM Voucher WHERE code = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, voucherCode);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Voucher(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getTimestamp(8),
                        rs.getTimestamp(9),
                        rs.getBoolean(10)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy voucher
    }

    public Voucher getVoucherById(int voucherId) {
        String query = "SELECT voucher_id, code, description, discount_percentage, discount_amount, min_order_value, max_discount, start_date, end_date, is_active "
                + "FROM Voucher WHERE voucher_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, voucherId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Voucher(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getTimestamp(8),
                        rs.getTimestamp(9),
                        rs.getBoolean(10)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy voucher
    }

    public boolean createVoucher(Voucher voucher) {
        String query = "INSERT INTO Voucher (code, description, discount_percentage, discount_amount, min_order_value, max_discount, start_date, end_date, is_active) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getDescription());
            ps.setInt(3, voucher.getDiscountPercentage());
            ps.setDouble(4, voucher.getDiscountAmount());
            ps.setDouble(5, voucher.getMinOrderValue());
            ps.setDouble(6, voucher.getMaxDiscount());
            ps.setTimestamp(7, voucher.getStartDate());
            ps.setTimestamp(8, voucher.getEndDate());
            ps.setBoolean(9, voucher.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVoucher(Voucher voucher) {
        String query = "UPDATE Voucher SET code = ?, description = ?, discount_percentage = ?, discount_amount = ?, min_order_value = ?, max_discount = ?, "
                + "start_date = ?, end_date = ?, is_active = ? WHERE voucher_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getDescription());
            ps.setInt(3, voucher.getDiscountPercentage());
            ps.setDouble(4, voucher.getDiscountAmount());
            ps.setDouble(5, voucher.getMinOrderValue());
            ps.setDouble(6, voucher.getMaxDiscount());
            ps.setTimestamp(7, voucher.getStartDate());
            ps.setTimestamp(8, voucher.getEndDate());
            ps.setBoolean(9, voucher.isActive());
            ps.setInt(10, voucher.getVoucherId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVoucher(int voucherId) {
        String query = "DELETE FROM Voucher WHERE voucher_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isCodeExists(String code) {
        String query = "SELECT COUNT(*) FROM voucher WHERE code = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, code);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Nếu số lượng > 0, nghĩa là code đã tồn tại
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
