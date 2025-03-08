package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Admin
 */
public class DiscountOrder {
    private int discountOrderId;
    private int orderId;
    private int voucherId;
    private double discountAmount;

    public DiscountOrder() {
    }

    public DiscountOrder(int discountOrderId, int orderId, int voucherId, double discountAmount) {
        this.discountOrderId = discountOrderId;
        this.orderId = orderId;
        this.voucherId = voucherId;
        this.discountAmount = discountAmount;
    }
    
    public DiscountOrder(int orderId, int voucherId, double discountAmount) {
        this.orderId = orderId;
        this.voucherId = voucherId;
        this.discountAmount = discountAmount;
    }

    public int getDiscountOrderId() {
        return discountOrderId;
    }

    public void setDiscountOrderId(int discountOrderId) {
        this.discountOrderId = discountOrderId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }
    
    
}
