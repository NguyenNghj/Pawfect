package dao;

import db.DBContext;
import model.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Staff> getAllStaffs() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM Staffs WHERE is_active = 1";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                staffList.add(new Staff(
                        rs.getInt("staff_id"),
                        rs.getString("role_name"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getDate("birth_date"),
                        rs.getString("image"),
                        rs.getBoolean("is_active")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public Staff getStaffById(int staffId) {
        String query = "SELECT * FROM Staffs WHERE staff_id = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, staffId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Staff(
                        rs.getInt("staff_id"),
                        rs.getString("role_name"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getDate("birth_date"),
                        rs.getString("image"),
                        rs.getBoolean("is_active")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addStaff(Staff staff) {
        String query = "INSERT INTO Staffs (role_name, password, full_name, email, phone, address, gender, birth_date, image, is_active) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, staff.getRoleName());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getFullName());
            ps.setString(4, staff.getEmail());
            ps.setString(5, staff.getPhone());
            ps.setString(6, staff.getAddress());
            ps.setString(7, staff.getGender());
            ps.setDate(8, staff.getBirthDate());
            ps.setString(9, staff.getImage());
            ps.setBoolean(10, staff.isActive());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStaff(Staff staff) {
        String query = "UPDATE Staffs SET role_name = ?, password = ?, full_name = ?, email = ?, phone = ?, "
                + "address = ?, gender = ?, birth_date = ?, image = ?, is_active = ? WHERE staff_id = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, staff.getRoleName());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getFullName());
            ps.setString(4, staff.getEmail());
            ps.setString(5, staff.getPhone());
            ps.setString(6, staff.getAddress());
            ps.setString(7, staff.getGender());
            ps.setDate(8, staff.getBirthDate());
            ps.setString(9, staff.getImage());
            ps.setBoolean(10, staff.isActive());
            ps.setInt(11, staff.getStaffId()); // Sửa lỗi

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStaff(int staffId) {
        String query = "UPDATE Staffs SET is_active = 0 WHERE staff_id = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, staffId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
