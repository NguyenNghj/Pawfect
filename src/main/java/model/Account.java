/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class Account {

   
private String username;
    private String password;
    private String CustomerId;
public Account() {
       username = "";     
        password="";
        CustomerId="";
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

    public String getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(String customerId) {
        this.CustomerId = customerId;
    }

    public Account(String username, String password, String customerId) {
        this.username = username;
        this.password = password;
        this.CustomerId = customerId;
    }
     public static boolean IsEmpty(Account account) {
        return account.getUsername().isEmpty() && account.getPassword().isEmpty() && account.getCustomerId().isEmpty();
    }

    
}
