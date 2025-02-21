/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class OrderItem {
    private int orderItemId;
    private int customerId;
    private int productId;
    private int quantity;
    private double productPrice;
    private String productImage;
    private String productName;

    public OrderItem() {
    }

    public OrderItem(int orderItemId, int customerId, int productId, int quantity, double productPrice, String productImage, String productName) {
        this.orderItemId = orderItemId;
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.productName = productName;
    }
    
    public double getSubtotal() {
        return productPrice * quantity;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    @Override
    public String toString() {
        return "OrderItem{" + "orderItemId=" + orderItemId + ", customerId=" + customerId + ", productId=" + productId + ", quantity=" + quantity + ", productPrice=" + productPrice + ", productImage=" + productImage + ", productName=" + productName + '}';
    }
    
    
}
