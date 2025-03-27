package dao;

import db.DBContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Staff> getAllStaffs() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM Staffs WHERE role_name ='Staff'";

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
    // Thêm nhân viên mới

    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO Staffs (role_name, password, full_name, email, phone, address, gender, birth_date, image, is_active) "
                + "VALUES ('Staff', ?, ?, ?, ?, ?, ?, ?, ?, 1)"; // is_active luôn là 1

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staff.getPassword());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getEmail());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getAddress());
            ps.setString(6, staff.getGender());
            ps.setDate(7, staff.getBirthDate());
            ps.setString(8, staff.getImage()); // Không kiểm tra null

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStaff(Staff staff) {
        String query = "UPDATE Staffs SET password = ?, full_name = ?, email = ?, phone = ?, "
                + "address = ?, gender = ?, birth_date = ?, image = ?, is_active = ? WHERE staff_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            // Mã hóa mật khẩu trước khi cập nhật
            ps.setString(1, staff.getPassword());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getEmail());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getAddress());
            ps.setString(6, staff.getGender());

            // Nếu birthDate là null, set null cho SQL
            if (staff.getBirthDate() != null) {
                ps.setDate(7, staff.getBirthDate());
            } else {
                ps.setNull(7, java.sql.Types.DATE);
            }

            ps.setString(8, staff.getImage());
            ps.setBoolean(9, staff.isActive());
            ps.setInt(10, staff.getStaffId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi cập nhật nhân viên: " + e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
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

    public List<Staff> searchStaffs(String keyword) {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM Staffs WHERE LOWER(full_name) LIKE LOWER(N'%' + ? + '%') AND is_active = 1";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);

            ResultSet rs = ps.executeQuery();
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
    public boolean isEmailOrPhoneExists(String email, String phone) {
    String query = "SELECT COUNT(*) FROM Staffs WHERE email = ? OR phone = ?";
    
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setString(1, email);
        ps.setString(2, phone);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Nếu có ít nhất 1 kết quả, nghĩa là đã tồn tại
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    public boolean isEmailOrPhoneExistsForUpdate(int staffId, String email, String phone) {
    String query = "SELECT COUNT(*) FROM Staffs WHERE (email = ? OR phone = ?) AND staff_id != ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setString(1, email);
        ps.setString(2, phone);
        ps.setInt(3, staffId);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Nếu có kết quả, nghĩa là email/phone đã có nhân viên khác dùng
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
public boolean updateStaff(int staffId, String fullName, String email, String phone) {
    if (isEmailOrPhoneExistsForUpdate(staffId, email, phone)) {
        System.out.println("Email hoặc số điện thoại đã tồn tại!");
        return false; // Ngăn cập nhật nếu trùng
    }

    String query = "UPDATE Staffs SET fullName = ?, email = ?, phone = ? WHERE staff_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setInt(4, staffId);

        return ps.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}



    /**
     * Hashes a password using MD5 algorithm
     *
     * @param password - The plain text password to hash
     * @return A string representing the MD5 hashed password
     */
    public static String hashPasswordMD5(String password) {
        String hashedPassword = null;
        if (password != null) {
            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(password.getBytes());
                byte[] digest = md.digest();
                StringBuilder sb = new StringBuilder();
                for (byte b : digest) {
                    sb.append(String.format("%02x", b & 0xff));
                }
                hashedPassword = sb.toString();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
        }
        return hashedPassword;
    }
    

}
