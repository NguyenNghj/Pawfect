package dao;

import db.DBContext;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PetHotelBooking;

public class PetHotelBookingDAO {

    protected static Connection Con = null;

    // Câu lệnh SQL (Sửa LEFT JOIN để tránh lỗi khi staff_id null)
    protected static final String Get_All_Bookings = "SELECT p.booking_id, p.room_id, r.room_name, p.customer_id, c.full_name AS customer_name, \n"
            + "               p.staff_id, s.full_name AS staff_name, p.pet_id, pet.pet_name, \n"
            + "               p.check_in, p.check_out, p.total_price, p.note, p.status, p.booking_date, p.is_active \n"
            + "        FROM PetHotelBookings p \n"
            + "        JOIN PetHotel r ON p.room_id = r.room_id\n"
            + "        JOIN Customers c ON p.customer_id = c.customer_id\n"
            + "        LEFT JOIN Staffs s ON p.staff_id = s.staff_id\n"
            + "        JOIN Pets pet ON p.pet_id = pet.pet_id\n"
            + "        WHERE p.is_active = 1";
    protected static final String Get_Bookings_By_Customer = Get_All_Bookings + " AND p.customer_id = ?";
    protected static final String Get_Booking_By_Id = Get_All_Bookings + " AND p.booking_id = ?";
    protected static final String Approve_Booking = "UPDATE PetHotelBookings SET status = N'Đã duyệt' WHERE booking_id = ? AND is_active = 1";
    protected static final String Cancel_Booking = "UPDATE PetHotelBookings SET status = N'Đã hủy' WHERE booking_id = ? AND is_active = 1";
    protected static final String Create_Booking = "INSERT INTO PetHotelBookings (room_id, customer_id, pet_id, check_in, check_out, total_price, note, status, booking_date, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 1)";
    protected static final String Delete_Booking = "UPDATE PetHotelBookings SET is_active = 0 WHERE booking_id = ?";

    // Lấy danh sách tất cả Booking
    public static List<PetHotelBooking> getAllBookings() {
        List<PetHotelBooking> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_Bookings);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PetHotelBooking booking = new PetHotelBooking(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getInt("customer_id"),
                        rs.getString("customer_name"),
                        rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null, // Xử lý null
                        rs.getString("staff_name"),
                        rs.getInt("pet_id"),
                        rs.getString("pet_name"),
                        rs.getTimestamp("check_in"),
                        rs.getTimestamp("check_out"),
                        rs.getBigDecimal("total_price"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("booking_date"),
                        rs.getBoolean("is_active")
                );
                list.add(booking);
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

    // Lấy Booking theo ID
    public static PetHotelBooking getBookingById(int bookingId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Booking_By_Id);
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new PetHotelBooking(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getInt("customer_id"),
                        rs.getString("customer_name"),
                        rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null, // Xử lý null
                        rs.getString("staff_name"),
                        rs.getInt("pet_id"),
                        rs.getString("pet_name"),
                        rs.getTimestamp("check_in"),
                        rs.getTimestamp("check_out"),
                        rs.getBigDecimal("total_price"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("booking_date"),
                        rs.getBoolean("is_active")
                );
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

    // Cập nhật trạng thái Booking
    public static boolean approveBooking(int bookingId) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Approve_Booking);
            ps.setInt(1, bookingId);
            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }

    // Hủy Booking
    public static boolean cancelBooking(int bookingId) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Cancel_Booking);
            ps.setInt(1, bookingId);
            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }

    // Hàm tạo booking mới
    public static boolean createBooking(int roomId, int customerId, int petId, Timestamp checkIn, Timestamp checkOut, BigDecimal totalPrice, String note) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Create_Booking);
            ps.setInt(1, roomId);
            ps.setInt(2, customerId);
            ps.setInt(3, petId);
            ps.setTimestamp(4, checkIn);
            ps.setTimestamp(5, checkOut);
            ps.setBigDecimal(6, totalPrice);
            ps.setString(7, note);
            ps.setString(8, "Chờ xác nhận"); // Trạng thái mặc định

            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }
// Lấy danh sách lịch sử đặt phòng theo ID khách hàng

    public static List<PetHotelBooking> getBookingsByCustomerId(int customerId) {
        List<PetHotelBooking> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Bookings_By_Customer);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PetHotelBooking booking = new PetHotelBooking(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getInt("customer_id"),
                        rs.getString("customer_name"),
                        rs.getObject("staff_id") != null ? rs.getInt("staff_id") : null, // Xử lý null
                        rs.getString("staff_name"),
                        rs.getInt("pet_id"),
                        rs.getString("pet_name"),
                        rs.getTimestamp("check_in"),
                        rs.getTimestamp("check_out"),
                        rs.getBigDecimal("total_price"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("booking_date"),
                        rs.getBoolean("is_active")
                );
                list.add(booking);
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

    public static boolean deleteBooking(int bookingId) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_Booking);
            ps.setInt(1, bookingId);
            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }

    // Hàm đóng kết nối
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
