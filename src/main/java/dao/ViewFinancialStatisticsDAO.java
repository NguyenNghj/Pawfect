/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ADMIN
 */
public class ViewFinancialStatisticsDAO extends DBContext {

    public double getTotaMoneyByMonth(int month) {
           String sql = "SELECT SUM(oi.quantity) AS totalProducts " +
             "FROM [pawfect].[dbo].[OrderItems] oi " +
             "JOIN [pawfect].[dbo].[Orders] o ON oi.order_id = o.order_id " +
             "WHERE MONTH(o.order_date) = ? AND o.status = N'Hoàn thành';";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
}
