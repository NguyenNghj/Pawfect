package dao;


import static dao.CartDAO.Con;
import db.DBContext;
import model.Staff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    private Connection conn;

    public StaffDAO() {
        try {
            conn = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // L?y danh sách t?t c? nhân viên
    public List<Staff> getAllStaffs() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM Staffs Where is_active = 1";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Staff staff = new Staff(
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

                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return staffList;
    }

    public static boolean deleteStaff(int staffId) {
        String deleteStaffQuery = "UPDATE Staffs SET is_active = 0 WHERE staff_id = ?"; // Câu l?nh SQL xóa nhân viên
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(deleteStaffQuery);
            ps.setInt(1, staffId);

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

    // Thêm nhân viên m?i
    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO Staffs (role_name, password, full_name, email, phone, address, gender, birth_date, image, is_active) VALUES (?,?,?,?,?,?,?,? ,NULL, 1)"; // is_active luôn là 1

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staff.getRoleName());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getFullName());
            ps.setString(4, staff.getEmail());
            ps.setString(5, staff.getPhone());
            ps.setString(6, staff.getAddress());
            ps.setString(7, staff.getGender());
            ps.setDate(8, staff.getBirthDate());

            // X? lý image null
            if (staff.getImage() != null && !staff.getImage().trim().isEmpty()) {
                ps.setString(9, staff.getImage());
            } else {
                ps.setNull(9, Types.VARCHAR);
            }

            // Set giá tr? cho is_active
            ps.setBoolean(10, staff.isActive());

            // Debug log
            System.out.println("Executing SQL: " + sql);
            System.out.println("With values: "
                    + staff.getRoleName() + ", "
                    + staff.getPassword() + ", "
                    + staff.getFullName() + ", "
                    + staff.getEmail() + ", "
                    + staff.getPhone() + ", "
                    + staff.getAddress() + ", "
                    + staff.getGender() + ", "
                    + staff.getBirthDate() + ", "
                    + (staff.getImage() != null ? staff.getImage() : "NULL") + ", "
                    + staff.isActive());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
}
