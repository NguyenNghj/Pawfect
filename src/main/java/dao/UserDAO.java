/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;
import model.AccountStaff;
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
     
       public AccountStaff loginStaff(String username, String password) {    
        String query = "SELECT * FROM Staffs WHERE email = ? AND password = ? and is_active= 1";
 AccountStaff account = new AccountStaff();
        try {
             conn = new DBContext().getConnection();
          pt = conn.prepareStatement(query);
            pt.setString(1, username);
            pt.setString(2, password);
          rs = pt.executeQuery();

            if (rs.next()) {
           
            account.setUsername(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setStaffId(rs.getString("staff_id"));
            account.setRole(rs.getString("role_name"));
            
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
   
    public void updateNewPassword(String email,String password) throws NoSuchAlgorithmException {
        String sql = "UPDATE Customers SET password = ? WHERE email = ?";
        try {
             MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b)); 
            }
            String hashedPassword = sb.toString();
             conn = new DBContext().getConnection();
          pt = conn.prepareStatement(sql);
            pt.setString(1, hashedPassword);  
            pt.setString(2, email);  
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
     public String getPassword (String email) {
        String sql = " select [password] from Customers where email=? ";
        String password="";
        try {
             conn = new DBContext().getConnection();
          pt = conn.prepareStatement(sql);
            pt.setString(1, email);  
           rs = pt.executeQuery();
            if (rs.next()) {
              password = rs.getString("password");

            }
        } catch (SQLException e) {

        }
        return password;
    }
     
}
