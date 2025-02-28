/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class AccountStaff {
 private String username;
    private String password;
    private String staffId;
    private String role;
public AccountStaff() {
       username = "";     
        password="";
     staffId="";
     role="";
    }

    public AccountStaff(String username, String password, String staffId, String role) {
        this.username = username;
        this.password = password;
        this.staffId = staffId;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
  


     public static boolean IsEmpty(AccountStaff account) {
        return account.getUsername().isEmpty() && account.getPassword().isEmpty() && account.staffId.isEmpty()&& account.getRole().isEmpty();
    }

    
}