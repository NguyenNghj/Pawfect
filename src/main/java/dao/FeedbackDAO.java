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
import model.Feedback;

/**
 *
 * @author Admin
 */
public class FeedbackDAO {

    protected static Connection Con = null;

    protected static String Get_Product_Feedback_By_Rating = "SELECT\n"
            + "    f.feedback_id,\n"
            + "    f.customer_id,\n"
            + "    f.staff_id,\n"
            + "    f.product_id,\n"
            + "    c.full_name AS customer_name,\n"
            + "    s.full_name AS staff_name,\n"
            + "    p.product_name,\n"
            + "    f.rating,\n"
            + "    f.comment,\n"
            + "    f.reply,\n"
            + "    f.feedback_date,\n"
            + "    f.is_visible\n"
            + "FROM\n"
            + "    Feedbacks f\n"
            + "JOIN\n"
            + "    Customers c ON f.customer_id = c.customer_id\n"
            + "LEFT JOIN\n"
            + "    Staffs s ON f.staff_id = s.staff_id\n"
            + "JOIN\n"
            + "    Products p ON f.product_id = p.product_id\n"
            + "WHERE\n"
            + "    f.rating = ?";

    protected static String Get_All_Product_Feedback = "SELECT\n"
            + "    f.feedback_id,\n"
            + "	f.customer_id,\n"
            + "	f.staff_id,\n"
            + "	f.product_id,\n"
            + "    c.full_name AS customer_name,\n"
            + "    s.full_name AS staff_name,\n"
            + "    p.product_name,\n"
            + "    f.rating,\n"
            + "    f.comment,\n"
            + "    f.reply,\n"
            + "    f.feedback_date,\n"
            + "    f.is_visible\n"
            + "FROM\n"
            + "    Feedbacks f\n"
            + "JOIN\n"
            + "    Customers c ON f.customer_id = c.customer_id\n"
            + "LEFT JOIN\n"
            + "    Staffs s ON f.staff_id = s.staff_id\n"
            + "JOIN\n"
            + "    Products p ON f.product_id = p.product_id";

    public static List<Feedback> getProductFeedbackByRating(int rating) {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Product_Feedback_By_Rating);
            ps.setInt(1, rating);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback o = new Feedback(
                        rs.getInt("feedback_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("staff_id"),
                        rs.getInt("product_id"),
                        rs.getString("customer_name"),
                        rs.getString("staff_name"),
                        rs.getString("product_name"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getString("reply"),
                        rs.getTimestamp("feedback_date"),
                        rs.getBoolean("is_visible")
                );
                list.add(o);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (Con != null) {
                    Con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return list;
    }

    public static List<Feedback> getAllProductFeedback() {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_Product_Feedback);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback o = new Feedback(
                        rs.getInt("feedback_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("staff_id"),
                        rs.getInt("product_id"),
                        rs.getString("customer_name"),
                        rs.getString("staff_name"),
                        rs.getString("product_name"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getString("reply"),
                        rs.getTimestamp("feedback_date"),
                        rs.getBoolean("is_visible")
                );
                list.add(o);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (Con != null) {
                    Con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return list;
    }
}
