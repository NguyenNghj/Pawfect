package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PetHotel;

public class PetHotelDAO {

    protected static Connection Con = null;

    // Câu lệnh SQL
    protected static String Get_All_PetRooms = "SELECT * FROM PetHotel WHERE is_active = 1";
    protected static String Get_PetRoom_By_Id = "SELECT * FROM PetHotel WHERE room_id = ?";
    protected static String INSERT_PETROOM = "INSERT INTO PetHotel (room_name, room_image, room_type, min_weight, max_weight, quantity, available_quantity, price_per_night, description, status, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, N'Còn phòng', ?)";
    protected static String Update_PetRoom = "UPDATE PetHotel SET room_name = ?, room_image = ?, room_type = ?, min_weight = ?, max_weight = ?, quantity = ?, available_quantity = ?, price_per_night = ?, description = ?, status = ?, is_active = 1 WHERE room_id = ?";
    protected static String Delete_PetRoom = "UPDATE PetHotel SET is_active = 0 WHERE room_id = ?";

    // Lấy danh sách tất cả phòng
    public static List<PetHotel> getAllPetRooms() {
        List<PetHotel> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_PetRooms);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PetHotel room = new PetHotel(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getInt("available_quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("description"),
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

    public static List<PetHotel> filterPetRooms(String sizeFilter, String roomTypeFilter) {
        List<PetHotel> list = new ArrayList<>();
        String query = "SELECT * FROM PetHotel WHERE is_active = 1";

        if ("small".equals(sizeFilter)) {
            query += " AND max_weight <= 5";
        } else if ("medium".equals(sizeFilter)) {
            query += " AND min_weight > 5 AND max_weight <= 15";
        } else if ("large".equals(sizeFilter)) {
            query += " AND min_weight > 15";
        }

        if ("dog".equals(roomTypeFilter)) {
            query += " AND room_type = 'Chó'";
        } else if ("cat".equals(roomTypeFilter)) {
            query += " AND room_type = 'Mèo'";
        }

        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new PetHotel(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getInt("available_quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getBoolean("is_active")
                ));
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

    public static List<PetHotel> getSimilarRooms(String roomType, int roomId) {
        List<PetHotel> list = new ArrayList<>();
        String query = "SELECT * FROM PetHotel WHERE room_type = ? AND room_id != ? AND is_active = 1";

        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(query);
            ps.setString(1, roomType);
            ps.setInt(2, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new PetHotel(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getInt("available_quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getBoolean("is_active")
                ));
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
    public static PetHotel getPetRoomById(int roomId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_PetRoom_By_Id);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new PetHotel(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("room_image"),
                        rs.getString("room_type"),
                        rs.getDouble("min_weight"),
                        rs.getDouble("max_weight"),
                        rs.getInt("quantity"),
                        rs.getInt("available_quantity"),
                        rs.getDouble("price_per_night"),
                        rs.getString("description"),
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

    // Cập nhật phòng
    public static boolean updatePetRoom(PetHotel room) {
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
            ps.setInt(7, room.getAvailableQuantity());
            ps.setDouble(8, room.getPricePerNight());
            ps.setString(9, room.getDescription());
            ps.setString(10, room.getStatus());
            ps.setInt(11, room.getRoomId());

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

    // Thêm mới một phòng
    public static boolean addRoom(PetHotel room) {
        try ( Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(INSERT_PETROOM)) {
            ps.setString(1, room.getRoomName());
            ps.setString(2, room.getRoomImage());
            ps.setString(3, room.getRoomType());
            ps.setDouble(4, room.getMinWeight());
            ps.setDouble(5, room.getMaxWeight());
            ps.setInt(6, room.getQuantity());
            ps.setInt(7, room.getQuantity()); // Đặt available_quantity = quantity            
            ps.setDouble(8, room.getPricePerNight());
            ps.setString(9, room.getDescription());
            ps.setBoolean(10, room.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void updateRoomStatus(int roomId) {
        String query = "UPDATE PetHotel SET status = CASE WHEN available_quantity = 0 THEN N'Hết phòng' ELSE N'Còn phòng' END WHERE room_id = ?";
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(query);
            ps.setInt(1, roomId);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
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
