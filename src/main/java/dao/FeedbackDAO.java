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

    protected static String Search_Feedback = "SELECT\n"
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
            + "    f.image_path,\n"
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
            + "    p.product_name COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?\n"
            + "    OR c.full_name COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?";

    protected static String Check_Order_Feedback = "SELECT COUNT(*) \n"
            + "FROM Feedbacks \n"
            + "WHERE customer_id = ? \n"
            + "AND product_id = ? \n"
            + "AND order_id = ?;";

    protected static String Delete_Feedback = "DELETE FROM Feedbacks WHERE feedback_id = ?";

    protected static String Add_Feedback = "INSERT INTO Feedbacks (customer_id, product_id, order_id, rating, comment, image_path) VALUES\n"
            + "(?, ?, ?, ?, ?, ?)";

    protected static String Get_Product_Feedback_By_ProductId = "SELECT\n"
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
            + "    f.image_path,\n"
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
            + "    f.product_id = ?"
            + "ORDER BY\n"
            + "     f.feedback_date DESC";

    protected static String Reply_Feedback = "UPDATE Feedbacks\n"
            + "SET staff_id = ?,\n"
            + "	reply = ?\n"
            + "WHERE feedback_id = ?";

    protected static String Is_Visible_Feedback = "UPDATE Feedbacks\n"
            + "SET is_visible = CASE WHEN is_visible = 1 THEN 0 ELSE 1 END\n"
            + "WHERE feedback_id = ?";

    protected static String Get_Product_Feedback_By_ProductId_Vs_Image = "SELECT\n"
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
            + "    f.image_path,\n"
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
            + "    f.image_path IS NOT NULL AND f.product_id = ?";

    protected static String Get_Product_Feedback_By_ProductId_Vs_Rating = "SELECT\n"
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
            + "    f.image_path,\n"
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
            + "    f.rating = ? AND f.product_id = ?";

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
            + "    f.image_path,\n"
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
            + "    f.image_path,\n"
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

    public static List<Feedback> searchOrder(String search) {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Search_Feedback);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
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
                        rs.getString("image_path"),
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

    public static int checkOrderFeedback(int customerId, int productId, int orderId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Check_Order_Feedback);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setInt(3, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("So lan feedback cua don hang gan nhat: " + count);
                return count;
            } else {
                System.out.println("Khong tim thay cot nao!!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean deleteFeedback(int feedbackId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_Feedback);
            ps.setInt(1, feedbackId);
            rs = ps.executeUpdate() > 0;
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
        return rs;
    }

    public static List<Feedback> getProductFeedbackByProductIdVsImage(int productId) {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Product_Feedback_By_ProductId_Vs_Image);
            ps.setInt(1, productId);
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
                        rs.getString("image_path"),
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

    public static List<Feedback> getProductFeedbackByRatingVsProductId(int rating, int productId) {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Product_Feedback_By_ProductId_Vs_Rating);
            ps.setInt(1, rating);
            ps.setInt(2, productId);
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
                        rs.getString("image_path"),
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

    public static boolean addFeedback(int customerId, int productId, int orderId, int rating, String comment, String image_path) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Add_Feedback);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setInt(3, orderId);
            ps.setInt(4, rating);
            ps.setString(5, comment);
            ps.setString(6, image_path);
            rs = ps.executeUpdate() > 0;
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
        return rs;
    }

    public static List<Feedback> getProductFeedbackByProductId(int productId) {
        List<Feedback> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Product_Feedback_By_ProductId);
            ps.setInt(1, productId);
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
                        rs.getString("image_path"),
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

    public static boolean replyFeedback(int staffId, String reply, int feedbackId) {
        boolean update = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Reply_Feedback);
            ps.setInt(1, staffId);
            ps.setString(2, reply);
            ps.setInt(3, feedbackId);
            update = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return update;
    }

    public static boolean isVisibleFeedback(int feedbackId) {
        boolean update = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Is_Visible_Feedback);
            ps.setInt(1, feedbackId);
            update = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return update;
    }

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
                        rs.getString("image_path"),
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
                        rs.getString("image_path"),
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
