/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import db.DBContext;
import model.Customers;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;

/**
 *
 * @author ADMIN
 */
public class CustomersDAO {

    protected static Connection Con = null;

    // SQL Queries
    protected static final String Get_All_Customers = "SELECT * FROM Customers WHERE is_active = 1";
    protected static final String Get_Customer_By_Id = "SELECT * FROM Customers WHERE customer_id = ?";
    protected static final String Insert_Customer = "INSERT INTO Customers (password, full_name, email, phone, address, gender, birth_date, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
    protected static final String Update_Customer = "UPDATE Customers SET full_name = ?, phone = ?, address = ?, gender = ?, birth_date = ?, is_active = ? WHERE customer_id = ?";
    protected static final String Delete_Customer = "UPDATE Customers SET is_active = 0 WHERE customer_id = ?";

    // Lấy danh sách tất cả khách hàng
    public static List<Customers> getAllCustomers() {
        List<Customers> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_Customers);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToCustomer(rs));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return list;
    }

    // Lấy khách hàng theo ID
    public static Customers getCustomerById(int customerId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Customer_By_Id);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return null;
    }

    // Thêm khách hàng mới
    public static boolean insertCustomer(Customers customer) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Insert_Customer);
            ps.setString(1, customer.getPassword());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPhone());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getGender());
            ps.setDate(7, customer.getBirthDate());

            int rowsInserted = ps.executeUpdate();
            ps.close();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return false;
    }

    // Cập nhật thông tin khách hàng
    public static boolean updateCustomer(Customers customer) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Update_Customer);
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getPhone());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getGender());
            ps.setDate(5, customer.getBirthDate());
            ps.setBoolean(6, customer.isActive());
            ps.setInt(7, customer.getCustomerId());

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return false;
    }

    // Xóa khách hàng (cập nhật trạng thái is_active)
    public static boolean deleteCustomer(int customerId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_Customer);
            ps.setInt(1, customerId);

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return false;
    }

    // Đóng kết nối
    private static void closeConnection() {
        try {
            if (Con != null) {
                Con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Mapping ResultSet thành Customers object
    private static Customers mapResultSetToCustomer(ResultSet rs) throws SQLException {
        return new Customers(
                rs.getInt("customer_id"),
                rs.getString("password"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("address"),
                rs.getString("gender"),
                rs.getDate("birth_date"),
                rs.getBoolean("is_active")
        );
    }
}

    

