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
import model.User;

/**
 *
 * @author LENOVO
 */
public class ProfileDAO {
    
    Connection conn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    public User getUser(String customerId) {
        User user = new User();
        String query = "SELECT * FROM Customers WHERE customer_id=?";

        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, customerId);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setBirthDate(rs.getDate("birth_date"));
            }
        } catch (SQLException e) {

        }
        return user;

    }

    public void editProfil(User user, String customerId) {
        String query = "UPDATE Customers \n"
                + "SET email = ?,\n"
                + "    full_name = ?,\n"
                + "    phone = ?,\n"
                + "    address = ?,\n"
                + "    gender = ?,\n"
                + "    birth_date = ? WHERE customer_id = ?;";

        try {
          conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, user.getEmail());
            pt.setString(2, user.getFullName());
            pt.setString(3, user.getPhoneNumber());
            pt.setString(4, user.getAddress());
            pt.setString(5, user.getGender());
            pt.setDate(6, user.getBirthDate());
            pt.setString(7, customerId);
            pt.executeUpdate();
        } catch (SQLException e) {

        }
    }
}

