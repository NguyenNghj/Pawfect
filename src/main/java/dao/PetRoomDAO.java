package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PetRooms;

public class PetRoomDAO {

    protected static Connection Con = null;

    // Câu lệnh SQL
    protected static String Get_All_PetRooms = "SELECT * FROM PetRooms WHERE is_active = 1";
    protected static String Get_PetRoom_By_Id = "SELECT * FROM PetRooms WHERE room_id = ?";
    protected static String Insert_PetRoom = "INSERT INTO PetRooms (room_name, room_image, room_type, min_weight, max_weight, quantity, price_per_night, status, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    protected static String Update_PetRoom = "UPDATE PetRooms SET room_name = ?, room_image = ?, room_type = ?, min_weight = ?, max_weight = ?, quantity = ?, price_per_night = ?, status = ?, is_active = ? WHERE room_id = ?";
    protected static String Delete_PetRoom = "UPDATE PetRooms SET is_active = 0 WHERE room_id = ?";

    // Lấy danh sách tất cả phòng
    public static List<PetRooms> getAllPetRooms() {
        List<PetRooms> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_PetRooms);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PetRooms room = new PetRooms(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("status"),
                        rs.getBoolean("is_active")
                );
                list.add(room);
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

    // Phương thức lọc phòng theo tiêu chí
    public static List<PetRooms> filterPetRooms(String filter) {
        List<PetRooms> list = new ArrayList<>();
        String query = Get_All_PetRooms;

        // Thêm điều kiện lọc
        if ("cat".equals(filter)) {
            query += " AND room_type = 'Dành cho mèo'";
        } else if ("dog".equals(filter)) {
            query += " AND room_type = 'Dành cho chó'";
        } else if ("below-100k".equals(filter)) {
            query += " AND price_per_night < 100000";
        } else if ("100k-300k".equals(filter)) {
            query += " AND price_per_night BETWEEN 100000 AND 200000";
        } else if ("above-300k".equals(filter)) {
            query += " AND price_per_night > 200000";
        } else if ("ascending".equals(filter)) {
            query += " ORDER BY price_per_night ASC";
        } else if ("descending".equals(filter)) {
            query += " ORDER BY price_per_night DESC";
        }

        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PetRooms room = new PetRooms(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("status"),
                        rs.getBoolean("is_active")
                );
                list.add(room);
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

    // Lấy danh sách phòng tương tự
    public static List<PetRooms> getSimilarRooms(String roomType, int roomId) {
        List<PetRooms> list = new ArrayList<>();
        String query = "SELECT * FROM PetRooms WHERE room_type = ? AND room_id != ? AND is_active = 1";

        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(query);
            ps.setString(1, roomType);
            ps.setInt(2, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToRoom(rs));
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

    // Lấy chi tiết phòng theo ID
    public static PetRooms getPetRoomById(int roomId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_PetRoom_By_Id);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new PetRooms(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("status"),
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

    // Thêm mới một phòng
    public static boolean insertPetRoom(PetRooms room) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Insert_PetRoom);
            ps.setString(1, room.getRoomName());
            ps.setString(2, room.getRoomImage());
            ps.setString(3, room.getRoomType());
            ps.setDouble(4, room.getMinWeight());
            ps.setDouble(5, room.getMaxWeight());
            ps.setInt(6, room.getQuantity());
            ps.setDouble(7, room.getPricePerNight());
            ps.setString(8, room.getStatus());
            ps.setBoolean(9, room.isActive());

            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }

    // Cập nhật phòng
    public static boolean updatePetRoom(PetRooms room) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Update_PetRoom);
            ps.setString(1, room.getRoomName());
            ps.setString(2, room.getRoomImage());
            ps.setString(3, room.getRoomType());
            ps.setDouble(4, room.getMinWeight());
            ps.setDouble(5, room.getMaxWeight());
            ps.setInt(6, room.getQuantity());
            ps.setDouble(7, room.getPricePerNight());
            ps.setString(8, room.getStatus());
            ps.setBoolean(9, room.isActive());
            ps.setInt(10, room.getRoomId());

            success = ps.executeUpdate() > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return success;
    }

    // Xóa (ẩn) phòng
    public static boolean deletePetRoom(int roomId) {
        boolean success = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_PetRoom);
            ps.setInt(1, roomId);
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

    private static PetRooms mapResultSetToRoom(ResultSet rs) throws SQLException {
        return new PetRooms(
                rs.getInt("room_id"),
                rs.getString("room_name"),
                rs.getString("room_image"),
                rs.getString("room_type"),
                rs.getDouble("min_weight"),
                rs.getDouble("max_weight"),
                rs.getInt("quantity"),
                rs.getDouble("price_per_night"),
                rs.getString("status"),
                rs.getBoolean("is_active")
        );
    }

}
