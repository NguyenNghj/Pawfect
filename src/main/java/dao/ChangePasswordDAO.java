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

/**
 *
 * @author LENOVO
 */
public class ChangePasswordDAO {

    Connection conn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;

    public boolean checkPassword(String password, String customerId) {
        boolean isValid = false;
        String query = "SELECT * FROM Customers WHERE password = ? and customer_id=? ";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, password);
            pt.setString(2, customerId);
            rs = pt.executeQuery();

            if (rs.next()) {
                isValid = true;
            }
        } catch (SQLException e) {
        }
        return isValid;
    }
public boolean checkStaffadminPassword(String password, String staffId) {
        boolean isValid = false;
        String query = "SELECT * FROM Staffs WHERE password = ? and staff_id=? ";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, password);
            pt.setString(2, staffId);
            rs = pt.executeQuery();

            if (rs.next()) {
                isValid = true;
            }
        } catch (SQLException e) {
        }
        return isValid;
    }
  public void changeStaffAdminPassword(String password, String staffId) {
        String query = "UPDATE Staffs \n"
                + "SET password = ? WHERE staff_id = ?";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, password);
            pt.setString(2, staffId);
            pt.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void changePassword(String password, String customerId) {
        String query = "UPDATE Customers \n"
                + "SET password = ? WHERE customer_id = ?";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, password);
            pt.setString(2, customerId);
            pt.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
