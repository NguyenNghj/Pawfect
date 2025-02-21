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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Order;
import model.OrderItem;

/**
 *
 * @author Admin
 */
public class OrderDAO {

    protected static Connection Con = null;

    protected static String Create_Order = "INSERT INTO Orders (customer_id, paymentMethod_id, shippingMethod_id, recipient_name, recipient_phone, shipping_address, delivery_notes, total_amount, status) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    protected static String Create_Order_Item = "INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (?, ?, ?)";

    protected static String Get_Order_By_CustomerId = "SELECT\n"
            + "    o.*,\n"
            + "    s.fullName AS staff_name,\n"
            + "    pm.name AS payment_method_name,\n"
            + "    sm.name AS shipping_method_name,\n"
            + "	sm.shipping_fee AS shipping_method_fee\n"
            + "FROM\n"
            + "    Orders o\n"
            + "LEFT JOIN\n"
            + "    Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN\n"
            + "    PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN\n"
            + "    ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "WHERE\n"
            + "    o.customer_id = ?";

    protected static String Get_Order_By_OrderId = "SELECT\n"
            + "    o.*,\n"
            + "    s.fullName AS staff_name,\n"
            + "    pm.name AS payment_method_name,\n"
            + "    sm.name AS shipping_method_name,\n"
            + "	sm.shipping_fee AS shipping_method_fee\n"
            + "FROM\n"
            + "    Orders o\n"
            + "LEFT JOIN\n"
            + "    Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN  -- Nối với bảng PaymentMethods\n"
            + "    PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN  -- Nối với bảng ShippingMethods\n"
            + "    ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "WHERE\n"
            + "    o.order_id = ?";

    protected static String Get_OrderItems_By_OrderId = "SELECT\n"
            + "    oi.orderItem_id,\n"
            + "    oi.product_id,\n"
            + "    o.customer_id,\n"
            + "    oi.quantity,\n"
            + "    p.product_name,\n"
            + "    p.product_price,\n"
            + "    p.product_image\n"
            + "FROM\n"
            + "    OrderItems AS oi\n"
            + "INNER JOIN\n"
            + "    Products AS p ON oi.product_id = p.product_id\n"
            + "INNER JOIN\n"
            + "    Orders AS o ON oi.order_id = o.order_id\n"
            + "WHERE\n"
            + "    oi.order_id = ?";

    public static List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_OrderItems_By_OrderId);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem o = new OrderItem(
                        rs.getInt("orderItem_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("product_price"),
                        rs.getString("product_image"),
                        rs.getString("product_name")
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

    public static List<Order> getOrderByOrderId(int orderId) {
        List<Order> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Order_By_OrderId);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("staff_id"),
                        rs.getInt("paymentMethod_id"),
                        rs.getInt("shippingMethod_id"),
                        rs.getString("recipient_name"),
                        rs.getString("recipient_phone"),
                        rs.getString("shipping_address"),
                        rs.getString("delivery_notes"),
                        rs.getDouble("total_amount"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee")
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

    public static List<Order> getOrderByCustomerId(int customerId) {
        List<Order> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Order_By_CustomerId);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("staff_id"),
                        rs.getInt("paymentMethod_id"),
                        rs.getInt("shippingMethod_id"),
                        rs.getString("recipient_name"),
                        rs.getString("recipient_phone"),
                        rs.getString("shipping_address"),
                        rs.getString("delivery_notes"),
                        rs.getDouble("total_amount"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee")
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

    public static int insertOrder(int customerId, int paymentMethod_id, int shippingMethod_id, String recipient_name, String recipient_phone, String shipping_address, String delivery_notes, double total_amount, String status) throws SQLException {
        boolean success = false;
        int orderId = 0;
        try {
            Con = new DBContext().getConnection();
            // Bắt đầu transaction
            Con.setAutoCommit(false);

            PreparedStatement ps = Con.prepareStatement(Create_Order, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customerId);
            ps.setInt(2, paymentMethod_id);
            ps.setInt(3, shippingMethod_id);
            ps.setString(4, recipient_name);
            ps.setString(5, recipient_phone);
            ps.setString(6, shipping_address);
            ps.setString(7, delivery_notes);
            ps.setDouble(8, total_amount);
            ps.setString(9, status);
            success = ps.executeUpdate() > 0;
            if (!success) {
                System.out.println("Loi khi insert data Order!!");
                return 0;
            }

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            ps = Con.prepareStatement(Create_Order_Item);

            List<CartItem> cartItems = CartDAO.getCartByCustomerId(customerId);
            for (CartItem cartItem : cartItems) {
                ps.setInt(1, orderId);
                ps.setInt(2, cartItem.getProductId());
                ps.setInt(3, cartItem.getQuantity());
                success = ps.executeUpdate() > 0;
                if (!success) {
                    System.out.println("Loi khi insert data Order Item!!");
                    return 0;
                }
            }

            // Commit transaction
            Con.commit();

            ps.close();
            rs.close();
        } catch (SQLException e) {
            // Rollback transaction nếu có lỗi
            if (Con != null) {
                Con.rollback();
            }
            throw e; // Re-throw exception để servlet xử lý
        } finally {
            try {
                if (Con != null) {
                    Con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }
}
