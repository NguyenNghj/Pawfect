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
import model.Account;
import model.GoogleAccount;

/**
 *
 * @author LENOVO
 */
public class UserDAO {
     Connection conn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;
    
     public Account login(String username, String password) {
       
        String query = "SELECT * FROM Customers WHERE email = ? AND password = ? and is_active= 1";
 Account account = new Account();
        try {
             conn = new DBContext().getConnection();
          pt = conn.prepareStatement(query);
            pt.setString(1, username);
            pt.setString(2, password);
          rs = pt.executeQuery();

            if (rs.next()) {
           
            account.setUsername(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setCustomerId(rs.getString("customer_id"));
            
            }

        } catch (SQLException e) {
          
        }

        return account;
    }
     
        public boolean checkGoogleExists(String Email) {
        boolean isValid = false;
        String sql = "SELECT * FROM Customers WHERE email = ? AND password = 'GG' ";
        try {
          conn = new DBContext().getConnection();
          pt = conn.prepareStatement(sql);
            pt.setString(1, Email);
             rs = pt.executeQuery();
            if (rs.next()) {
                isValid = true;

            }
        } catch (SQLException e) {

        }
        return isValid;
    }
        
        public void insertGoogleAcc(GoogleAccount googleUser) {
        String sql = "  INSERT INTO Customers (email,password) VALUES (?,'GG');";
        try {
          conn = new DBContext().getConnection();
          pt = conn.prepareStatement(sql);
            pt.setString(1, googleUser.getId());  
            pt.executeUpdate();
        } catch (SQLException e) {

        }
    }
     public String getCustomerId(String email) {
        String sql = " select customer_id from Customers where email=? ";
        String customerId="";
        try {
          conn = new DBContext().getConnection();
          pt = conn.prepareStatement(sql);
            pt.setString(1, email);  
             rs = pt.executeQuery();
            if (rs.next()) {
              customerId = rs.getString("customer_id");

            }
        } catch (SQLException e) {

        }
        return customerId;
    }
        
}
