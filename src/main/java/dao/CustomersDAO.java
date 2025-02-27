package dao;
import db.DBContext;
import model.Customers;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomersDAO {

    protected static Connection Con = null;

    // SQL Queries
    protected static final String Get_All_Customers = "SELECT * FROM Customers";
    protected static final String Get_Customer_By_Id = "SELECT * FROM Customers WHERE customer_id = ?";
    protected static final String Insert_Customer = "INSERT INTO Customers (password, full_name, email, phone, address, gender, birth_date, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
    protected static final String Update_Customer = "UPDATE Customers SET full_name = ?, phone = ?, address = ?, gender = ?, birth_date = ?, is_active = ? WHERE customer_id = ?";
    protected static final String Ban_Customer = "UPDATE Customers SET is_active = 0 WHERE customer_id = ?";
    protected static final String UnBan_Customer = "UPDATE Customers SET is_active = 1 WHERE customer_id = ?";
    protected static final String Search_Customer = "SELECT * FROM Customers WHERE LOWER(full_name) LIKE LOWER(N'%' + ? + '%')";

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

    public static boolean deleteCustomer(int customerId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Ban_Customer);
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
    public static boolean unbanCustomer(int customerId) {
    try {
        Con = new DBContext().getConnection();
        PreparedStatement ps = Con.prepareStatement(UnBan_Customer);
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

    // Search customers by name or email
public static List<Customers> searchCustomers(String keyword) {
    List<Customers> list = new ArrayList<>();


    try {
        Con = new DBContext().getConnection();
        PreparedStatement ps = Con.prepareStatement(Search_Customer);
        ps.setString(1, "%" + keyword + "%");  // Chỉ tìm theo tên khách hàng

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



    private static void closeConnection() {
        try {
            if (Con != null) {
                Con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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

    public static boolean banCustomer(int customerId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
