/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author Admin
 */
public class Feedback {

    private int feedbackId;
    private int customerId;
    private int staffId;
    private int productId;
    private String customerName;
    private String staffName;
    private String productName;
    private int rating;
    private String comment;
    private String reply;
    private String imagePath;
    private Timestamp feedbackDate;
    private boolean isVisible;

    public Feedback() {
    }

    public Feedback(int feedbackId, int customerId, int staffId, int productId, String customerName, String staffName, String productName, int rating, String comment, String reply, String imagePath, Timestamp feedbackDate, boolean isVisible) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.staffId = staffId;
        this.productId = productId;
        this.customerName = customerName;
        this.staffName = staffName;
        this.productName = productName;
        this.rating = rating;
        this.comment = comment;
        this.reply = reply;
        this.imagePath = imagePath;
        this.feedbackDate = feedbackDate;
        this.isVisible = isVisible;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getFeedbackDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        return sdf.format(feedbackDate);
    }

    public void setFeedbackDate(Timestamp feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public boolean isIsVisible() {
        return isVisible;
    }

    public void setIsVisible(boolean isVisible) {
        this.isVisible = isVisible;
    }

}
