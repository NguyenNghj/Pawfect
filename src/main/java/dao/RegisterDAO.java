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
public class RegisterDAO {

    Connection conn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;

    public boolean userExists(String email) {
        boolean isValid = true;
        String query = "SELECT * FROM Customers WHERE email = ? ";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, email);

            rs = pt.executeQuery();

            if (rs.next()) {
                isValid = false;

            }

        } catch (SQLException e) {

        }

        return isValid;
    }

    public void register(User user) {

        String query = "INSERT INTO Customers (email, password, full_name, phone, address, gender, birth_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
           conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, user.getEmail());
            pt.setString(2, user.getPassword());
            pt.setString(3, user.getFullName());
            pt.setString(4, user.getPhoneNumber());
            pt.setString(5, user.getAddress());
            pt.setString(6, user.getGender());
            pt.setDate(7, user.getBirthDate());

           rs = pt.executeQuery();

        } catch (SQLException e) {

        }

    }
}
