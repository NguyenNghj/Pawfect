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

}
