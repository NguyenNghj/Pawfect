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
import model.PetHotel;
import model.Product;
import model.Staff;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class StatisticDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public double getTotalOrderByDayOfWeek(String dayOfWeek) {
        String query = "SELECT SUM(total_amount) "
                + "FROM Orders "
                + "WHERE DATENAME(WEEKDAY, finished_date) = ? "
                + "AND status = N'Hoàn thành' "
                + "AND finished_date >= DATEADD(DAY, -6, GETDATE())"; // Chỉ tính đơn hàng đã hoàn thành trong 7 ngày qua

        double total = 0;

        try {
            conn = new DBContext().getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                ps.setString(1, dayOfWeek); // Truyền tên ngày (Monday, Tuesday, ...)
                rs = ps.executeQuery();

                if (rs.next()) {
                    total = rs.getDouble(1); // Lấy tổng doanh thu
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public double getTotalBookingByDayOfWeek(String dayOfWeek) {
        String query = "SELECT SUM(total_price) "
                + "FROM PetHotelBookings "
                + "WHERE DATENAME(WEEKDAY, booking_date) = ? "
                + "AND status = N'Đã trả phòng'";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, dayOfWeek); // Truyền giá trị ngày trong tuần vào query
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1); // Lấy tổng doanh thu
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu không có dữ liệu
    }

    public int getOrderCountByDayOfWeek(String dayOfWeek) {
        String query = "SELECT COUNT(*) "
                + "FROM Orders "
                + "WHERE DATENAME(WEEKDAY, finished_date) = ? "
                + "AND status = N'Hoàn thành' "
                + "AND finished_date >= DATEADD(DAY, -6, GETDATE())"; // Chỉ tính đơn hàng hoàn thành trong 7 ngày qua

        int count = 0;

        try {
            conn = new DBContext().getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                ps.setString(1, dayOfWeek); // Truyền tên ngày (Monday, Tuesday, ...)
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1); // Lấy số lượng đơn hàng
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getBookingCountByDayOfWeek(String dayOfWeek) {
        String query = "SELECT COUNT(*) "
                + "FROM PetHotelBookings "
                + "WHERE DATENAME(WEEKDAY, booking_date) = ? "
                + "AND status = N'Đã trả phòng'";

        int count = 0;

        try {
            conn = new DBContext().getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(query);
                ps.setString(1, dayOfWeek); // Truyền giá trị ngày trong tuần vào query
                rs = ps.executeQuery();

                if (rs.next()) {
                    count = rs.getInt(1); // Lấy số lượng đặt phòng
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count; // Trả về số lượng đặt phòng
    }

    public List<Product> getTop5BestSellingProductsInWeek() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT TOP 5 p.product_id, p.product_name, SUM(oi.quantity) AS total_order, "
                + "SUM(oi.quantity * p.product_price) AS total_amount "
                + "FROM OrderItems oi "
                + "JOIN Orders o ON oi.order_id = o.order_id "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE o.finished_date >= DATEADD(DAY, -7, GETDATE()) "
                + "AND o.status = N'Hoàn thành' "
                + "GROUP BY p.product_id, p.product_name, p.product_price "
                + "ORDER BY total_order DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("total_order"),
                        rs.getDouble("total_amount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<PetHotel> getTop5BestBookingHotelInWeek() {
        List<PetHotel> hotelList = new ArrayList<>();
        String query = "SELECT TOP 5 ph.room_id, ph.room_name, COUNT(phb.booking_id) AS time_booking, SUM(phb.total_price) AS total_revenue "
                + "FROM PetHotelBookings phb "
                + "JOIN PetHotel ph ON phb.room_id = ph.room_id "
                + "WHERE phb.booking_date >= DATEADD(DAY, -7, GETDATE()) "
                + "AND phb.status = N'Đã trả phòng' "
                + "GROUP BY ph.room_id, ph.room_name "
                + "ORDER BY time_booking DESC, total_revenue DESC";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotelList.add(new PetHotel(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getInt("time_booking"),
                        rs.getDouble("total_revenue")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hotelList;
    }

    public List<Staff> getStaffRevenueInWeek() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT s.staff_id, s.full_name, s.image, "
                + "COALESCE(SUM(o.total_amount), 0) AS total_order, "
                + "COALESCE(SUM(phb.total_price), 0) AS total_booking, "
                + "(COALESCE(SUM(o.total_amount), 0) + COALESCE(SUM(phb.total_price), 0)) AS total_revenue "
                + "FROM Staffs s "
                + "LEFT JOIN Orders o ON s.staff_id = o.staff_id AND o.status = N'Hoàn thành' "
                + "LEFT JOIN PetHotelBookings phb ON s.staff_id = phb.staff_id AND phb.status = N'Hoàn thành' "
                + "GROUP BY s.staff_id, s.full_name, s.image "
                + "ORDER BY total_revenue DESC";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                staffList.add(new Staff(
                        rs.getString("full_name"),
                        rs.getString("image"),
                        rs.getDouble("total_order"),
                        rs.getDouble("total_booking"),
                        rs.getDouble("total_revenue")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staffList;
    }

}
