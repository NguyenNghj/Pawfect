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
import java.sql.Timestamp;
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

    protected static String Delete_Order = "DELETE FROM Orders WHERE order_id = ?";

    protected static String Delete_Order_Item = "DELETE FROM OrderItems WHERE order_id = ?";

    protected static String Get_Last_Complete_Order = "SELECT TOP 1 oi.order_id\n"
            + "FROM Orders o\n"
            + "JOIN OrderItems oi ON o.order_id = oi.order_id\n"
            + "WHERE o.customer_id = ?\n"
            + "AND oi.product_id = ?\n"
            + "AND o.status = N'Hoàn thành'\n"
            + "ORDER BY o.order_date DESC;";

    protected static String Search_Order = "SELECT \n"
            + "    o.*,\n"
            + "    s.full_name AS staff_name,\n"
            + "    pm.name AS payment_method_name,\n"
            + "    sm.name AS shipping_method_name,\n"
            + "    sm.shipping_fee AS shipping_method_fee,\n"
            + "    c.full_name AS customer_name,\n"
            + "	do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "WHERE c.full_name COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ? ";

    protected static String Approval_Order = "UPDATE Orders\n"
            + "SET status = ?, \n"
            + "    staff_id = ?,\n"
            + "    reason_cancel = ?,\n"
            + "    finished_date = ?\n"
            + "WHERE order_id = ?";

    protected static String Request_Cancel_Order = "UPDATE Orders\n"
            + "SET status = ?, \n"
            + "    reason_cancel = ?,\n"
            + "	request_cancel = ?\n"
            + "WHERE order_id = ?";

    protected static String Cancel_Order = "UPDATE Orders\n"
            + "SET status = ?, \n"
            + "    reason_cancel = ?\n"
            + "WHERE order_id = ?";

    protected static String Create_Order = "INSERT INTO Orders (customer_id, paymentMethod_id, shippingMethod_id, recipient_name, recipient_phone, shipping_address, delivery_notes, total_amount, status) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    protected static String Create_Order_Item = "INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (?, ?, ?)";

    protected static String Get_Order_By_CustomerId_Vs_Status = "SELECT \n"
            + "    o.*, \n"
            + "    s.full_name AS staff_name, \n"
            + "    pm.name AS payment_method_name, \n"
            + "    sm.name AS shipping_method_name, \n"
            + "    sm.shipping_fee AS shipping_method_fee, \n"
            + "    c.full_name AS customer_name, \n"
            + "    do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "WHERE o.customer_id = ? AND o.status = ?\n"
            + "ORDER BY o.order_id DESC;";

    protected static String Get_All_Order_By_Status = "SELECT \n"
            + "    o.*, \n"
            + "    s.full_name AS staff_name, \n"
            + "    pm.name AS payment_method_name, \n"
            + "    sm.name AS shipping_method_name, \n"
            + "    sm.shipping_fee AS shipping_method_fee, \n"
            + "    c.full_name AS customer_name,\n"
            + "	do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "WHERE o.status = ?\n"
            + "ORDER BY o.order_id DESC;";

    protected static String Get_All_Order = "SELECT \n"
            + "    o.*, \n"
            + "    s.full_name AS staff_name, \n"
            + "    pm.name AS payment_method_name, \n"
            + "    sm.name AS shipping_method_name, \n"
            + "    sm.shipping_fee AS shipping_method_fee, \n"
            + "    c.full_name AS customer_name,\n"
            + "	do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "ORDER BY o.order_id DESC;";

    protected static String Get_Order_By_CustomerId = "SELECT \n"
            + "    o.*, \n"
            + "    s.full_name AS staff_name, \n"
            + "    pm.name AS payment_method_name, \n"
            + "    sm.name AS shipping_method_name, \n"
            + "    sm.shipping_fee AS shipping_method_fee, \n"
            + "    c.full_name AS customer_name,\n"
            + "    do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "WHERE o.customer_id = ?\n"
            + "ORDER BY o.order_id DESC;";

    protected static String Get_Order_By_OrderId = "SELECT \n"
            + "    o.*, \n"
            + "    s.full_name AS staff_name, \n"
            + "    pm.name AS payment_method_name, \n"
            + "    sm.name AS shipping_method_name, \n"
            + "    sm.shipping_fee AS shipping_method_fee, \n"
            + "    c.full_name AS customer_name,\n"
            + "	do.discount_amount\n"
            + "FROM Orders o\n"
            + "LEFT JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "LEFT JOIN Staffs s ON o.staff_id = s.staff_id\n"
            + "LEFT JOIN PaymentMethods pm ON o.paymentMethod_id = pm.paymentMethod_id\n"
            + "LEFT JOIN ShippingMethods sm ON o.shippingMethod_id = sm.shippingMethod_id\n"
            + "LEFT JOIN DiscountOrders do ON o.order_id = do.order_id\n"
            + "WHERE o.order_id = ?";

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

    public static boolean deleteOrderItem(int orderId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_Order_Item);
            ps.setInt(1, orderId);
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

    public static boolean deleteOrder(int orderId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Delete_Order);
            ps.setInt(1, orderId);
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

    public static int getLastCompleteOrder(int customerId, int productId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Last_Complete_Order);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int orderId = rs.getInt("order_id");
                System.out.println("Order ID gần nhất: " + orderId);
                return orderId;
            } else {
                System.out.println("Không tìm thấy đơn hàng nào.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<Order> searchOrder(String search, String status) {
        List<Order> list = new ArrayList<>();

        String searchStatus = "";
        
        switch (status) {
            case "cxn":
                searchStatus = "AND o.status = N'Chờ xác nhận'";
                break;
            case "cln":
                searchStatus = "AND o.status = N'Chờ lấy hàng'";
                break;
            case "cgh":
                searchStatus = "AND o.status = N'Chờ giao hàng'";
                break;
            case "ht":
                searchStatus = "AND o.status = N'Hoàn thành'";
                break;
            case "ych":
                searchStatus = "AND o.status = N'Yêu cầu huỷ...'";
                break;
            case "dh":
                searchStatus = "AND o.status = N'Đã huỷ'";
                break;
        }

        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Search_Order + searchStatus + "\nORDER BY o.order_id DESC;");
            ps.setString(1, "%" + search + "%");
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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

    public static boolean approvalOrder(String status, int staffId, String reasonCancel, Timestamp finishDate, int orderId) {
        boolean update = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Approval_Order);
            ps.setString(1, status);
            ps.setInt(2, staffId);
            ps.setString(3, reasonCancel);
            ps.setTimestamp(4, finishDate);
            ps.setInt(5, orderId);
            update = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return update;
    }

    public static boolean requestCancelOrder(Order order) {
        boolean update = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Request_Cancel_Order);
            ps.setString(1, order.getStatus());
            ps.setString(2, order.getReasonCancel());
            ps.setBoolean(3, order.isRequestCancel());
            ps.setInt(4, order.getOrderId());
            update = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return update;
    }

    public static boolean cancelOrder(Order order) {
        boolean update = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Cancel_Order);
            ps.setString(1, order.getStatus());
            ps.setString(2, order.getReasonCancel());
            ps.setInt(3, order.getOrderId());
            update = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return update;
    }

    public static List<Order> getAllOrderByStatus(String status) {
        List<Order> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_Order_By_Status);
            ps.setString(1, status);
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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

    public static List<Order> getOrderByCustomerIdVsStatus(int customerId, String status) {
        List<Order> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Order_By_CustomerId_Vs_Status);
            ps.setInt(1, customerId);
            ps.setString(2, status);
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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

    public static List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_All_Order);
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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
                        rs.getString("reason_cancel"),
                        rs.getBoolean("request_cancel"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getTimestamp("finished_date"),
                        rs.getString("staff_name"),
                        rs.getString("payment_method_name"),
                        rs.getString("shipping_method_name"),
                        rs.getDouble("shipping_method_fee"),
                        rs.getString("customer_name"),
                        rs.getDouble("discount_amount")
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

    public static int insertOrder(Order order) throws SQLException {
        boolean success = false;
        int orderId = 0;
        try {
            Con = new DBContext().getConnection();
            // Bắt đầu transaction
            Con.setAutoCommit(false);

            PreparedStatement ps = Con.prepareStatement(Create_Order, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getCustomerId());
            ps.setInt(2, order.getPaymentMethodId());
            ps.setInt(3, order.getShippingMethodId());
            ps.setString(4, order.getName());
            ps.setString(5, order.getPhone());
            ps.setString(6, order.getAddress());
            ps.setString(7, order.getNote());
            ps.setDouble(8, order.getTotalAmount());
            ps.setString(9, order.getStatus());
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

            List<CartItem> cartItems = CartDAO.getCartByCustomerId(order.getCustomerId());
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
