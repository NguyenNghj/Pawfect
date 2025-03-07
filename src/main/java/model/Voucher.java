/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class Voucher {

    private int voucherId;
    private String code;
    private String description;
    private int discountPercentage;
    private double discountAmount;
    private double minOrderValue;
    private double maxDiscount;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean active;

    public Voucher(int voucherId, String code, String description, int discountPercentage, double discountAmount, double minOrderValue, double maxDiscount, Timestamp startDate, Timestamp endDate, boolean active) {
        this.voucherId = voucherId;
        this.code = code;
        this.description = description;
        this.discountPercentage = discountPercentage;
        this.discountAmount = discountAmount;
        this.minOrderValue = minOrderValue;
        this.maxDiscount = maxDiscount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.active = active;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(int discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public double getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(double maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

}
