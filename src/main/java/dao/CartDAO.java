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
                        rs.getInt("product_id"),
                        rs.getInt("customer_id"),
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
    
//    public static void main(String[] args) {
//        List<CartItem> cartItems = getCartByCustomerId(1);
//        for (CartItem cartItem : cartItems) {
//            System.out.println(cartItem);
//        }
//    }
}
