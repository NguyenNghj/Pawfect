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
import model.CartItem;

/**
 *
 * @author Admin
 */
public class CartDAO {

    protected static Connection Con = null;

    protected static String Get_Cart_By_CustomerId = "SELECT\n"
            + "	c.cartItem_id,\n"
            + "	c.product_id,\n"
            + "	c.customer_id,\n"
            + "	c.quantity,\n"
            + "    p.product_name,\n"
            + "    p.product_price,\n"
            + "    p.product_image  \n"
            + "FROM\n"
            + "    CartItems AS c\n"
            + "INNER JOIN\n"
            + "    Products AS p ON c.product_id = p.product_id\n"
            + "WHERE c.customer_id = ?";

    protected static String Check_Product_In_Cart = "SELECT\n"
            + "	c.cartItem_id,\n"
            + "	c.product_id,\n"
            + "	c.customer_id,\n"
            + "	c.quantity,\n"
            + "    p.product_name,\n"
            + "    p.product_price,\n"
            + "    p.product_image  \n"
            + "FROM\n"
            + "    CartItems AS c\n"
            + "INNER JOIN\n"
            + "    Products AS p ON c.product_id = p.product_id\n"
            + "WHERE c.customer_id = ? AND p.product_id = ?";

    protected static String Get_Total_Cart_Price_By_CustomerId = "SELECT SUM(c.quantity * p.product_price) AS TotalCartValue\n"
            + "FROM CartItems c\n"
            + "JOIN Products p ON c.product_id = p.product_id\n"
            + "WHERE c.customer_id = ?";

    protected static String Get_Subtotal_Of_Product = "SELECT (c.quantity * p.product_price) AS Subtotal\n"
            + "FROM CartItems c\n"
            + "JOIN Products p ON c.product_id = p.product_id\n"
            + "WHERE c.customer_id = ? AND p.product_id = ?";

    protected static String Remove_Product_From_Cart = "DELETE FROM CartItems WHERE product_id = ? AND customer_id = ?";

    protected static String Remove_Cart = "DELETE FROM CartItems\n"
            + "WHERE customer_id = ?";

    protected static String Increase_Quantity = "UPDATE CartItems\n"
            + "SET quantity = CASE\n"
            + "    WHEN quantity < (SELECT stock FROM Products WHERE product_id = CartItems.product_id) THEN quantity + ?\n"
            + "    ELSE quantity\n"
            + "END\n"
            + "WHERE customer_id = ? AND product_id = ?;";

    protected static String Decrease_Quantity = "UPDATE CartItems\n"
            + "SET quantity = CASE\n"
            + "    WHEN quantity > 0 THEN quantity - 1\n"
            + "    ELSE 0\n"
            + "END\n"
            + "WHERE customer_id = ? AND product_id = ?";

    protected static String Get_Quantity_Of_Product = "SELECT quantity FROM CartItems WHERE product_id = ? AND customer_id = ?";

    protected static String Add_To_Cart = "INSERT INTO CartItems (customer_id, product_id, quantity)  \n"
            + "VALUES  \n"
            + "    (?, ?, ?)";

    protected static String Count_Quantity_From_Cart = "SELECT\n"
            + "    SUM(c.quantity) AS total_quantity\n"
            + "FROM\n"
            + "    CartItems AS c\n"
            + "INNER JOIN\n"
            + "    Products AS p ON c.product_id = p.product_id\n"
            + "WHERE c.customer_id = ?;";

    public static List<CartItem> getCartByCustomerId(int customerId) {
        List<CartItem> list = new ArrayList<>();
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Cart_By_CustomerId);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem c = new CartItem(
                        rs.getInt("cartItem_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("product_price"),
                        rs.getString("product_image"),
                        rs.getString("product_name")
                );
                list.add(c);
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

    public static boolean addToCart(int customerId, int productId, int quantity) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Add_To_Cart);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
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

    public static boolean checkProductInCart(int productId, int customerId) {
        boolean productInCart = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Check_Product_In_Cart);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                productInCart = true;
            }

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
        return productInCart;
    }

    public static double getTotalCartByCustomerId(int customerId) {
        double totalCartPrice = 0;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Total_Cart_Price_By_CustomerId);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                totalCartPrice = rs.getDouble(1);
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
        return totalCartPrice;
    }

    public static double getSubtotalOfProduct(int customerId, int productId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Subtotal_Of_Product);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getDouble(1);
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
        return 0;
    }

    public static int getQuantityOfProduct(int customerId, int productId) {
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Get_Quantity_Of_Product);
            ps.setInt(1, productId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }
    
    public static boolean removeCart(int customerId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Remove_Cart);
            ps.setInt(1, customerId);
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

    public static boolean removeProductFromCart(int productId, int customerId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Remove_Product_From_Cart);
            ps.setInt(1, productId);
            ps.setInt(2, customerId);
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

    public static boolean increaseProductFromCart(int quantity, int productId, int customerId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Increase_Quantity);
            ps.setInt(1, quantity);
            ps.setInt(2, customerId);
            ps.setInt(3, productId);
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

    public static boolean decreseProductFromCart(int productId, int customerId) {
        boolean rs = false;
        try {
            Con = new DBContext().getConnection();
            PreparedStatement ps = Con.prepareStatement(Decrease_Quantity);
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
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

//    public static void main(String[] args) {
//        List<CartItem> cartItems = getCartByCustomerId(1);
//        for (CartItem cartItem : cartItems) {
//            System.out.println(cartItem);
//        }
//    }
}
