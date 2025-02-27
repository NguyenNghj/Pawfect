package dao;

import db.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PetHotelBooking;

public class PetHotelBookingDAO {

    protected static Connection Con = null;

    // Câu lệnh SQL
    protected static final String Get_All_Bookings = "SELECT p.booking_id, r.room_name, c.full_name, s.full_name AS staff_name, \n"
            + "               pet.pet_name, p.check_in, p.check_out, p.total_price, \n"
            + "               p.note, p.status, p.booking_date\n"
            + "        FROM PetHotelBookings p \n"
            + "        JOIN PetHotel r ON p.room_id = r.room_id\n"
            + "        JOIN Customers c ON p.customer_id = c.customer_id\n"
            + "        JOIN Staffs s ON p.staff_id = s.staff_id\n"
            + "        JOIN Pets pet ON p.pet_id = pet.pet_id";

    protected static final String Get_Booking_By_Id = "SELECT p.booking_id, r.room_name, c.full_name, s.full_name AS staff_name, \n"
            + "               pet.pet_name, p.check_in, p.check_out, p.total_price, \n"
            + "               p.note, p.status, p.booking_date\n"
            + "        FROM PetHotelBookings p\n"
            + "        JOIN PetHotel r ON p.room_id = r.room_id\n"
            + "        JOIN Customers c ON p.customer_id = c.customer_id\n"
            + "        JOIN Staffs s ON p.staff_id = s.staff_id\n"
            + "        JOIN Pets pet ON p.pet_id = pet.pet_id\n"
            + "        WHERE p.booking_id = ?";

    protected static final String Approve_Booking = "UPDATE PetHotelBookings SET status = N'Đã duyệt' WHERE booking_id = ?";
    protected static final String Cancel_Booking = "DELETE FROM PetHotelBookings WHERE booking_id = ?";

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
                        rs.getString("room_name"), // Đổi từ room_id -> room_name
                        rs.getString("full_name"),
                        rs.getString("staff_name"),
                        rs.getString("pet_name"),
                        rs.getTimestamp("check_in"),
                        rs.getTimestamp("check_out"),
                        rs.getBigDecimal("total_price"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("booking_date")
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
                        rs.getString("room_name"), // Đổi từ room_id -> room_name
                        rs.getString("full_name"),
                        rs.getString("staff_name"),
                        rs.getString("pet_name"),
                        rs.getTimestamp("check_in"),
                        rs.getTimestamp("check_out"),
                        rs.getBigDecimal("total_price"),
                        rs.getString("note"),
                        rs.getString("status"),
                        rs.getTimestamp("booking_date")
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
    // Cập nhật trạng thái Booking

    public static boolean cancelBooking(int bookingId) {
        boolean success = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(Cancel_Booking);
            ps.setInt(1, bookingId);
            success = ps.executeUpdate() > 0;
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
