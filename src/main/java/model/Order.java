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
public class Order {
    private int orderId;
    private int customerId;
    private Integer staffId;
    private int paymentMethodId;
    private int shippingMethodId;
    private String name;
    private String phone;
    private String address;
    private String note;
    private double totalAmount;
    private String reasonCancel;
    private boolean requestCancel;
    private String status;
    private Timestamp orderDate;
    private Timestamp finishDate;
    private String staffName;
    private String paymentMethodName;
    private String shippingMethodName;
    private double shippingMethodFee;
    private String customerName;
    private double discountAmount;

    public Order() {
    }

    public Order(int orderId, int customerId, Integer staffId, int paymentMethodId, int shippingMethodId, String name, String phone, String address, String note, double totalAmount, String reasonCancel, boolean requestCancel, String status, Timestamp orderDate, Timestamp finishDate, String staffName, String paymentMethodName, String shippingMethodName, double shippingMethodFee, String customerName, double discountAmount) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.staffId = staffId;
        this.paymentMethodId = paymentMethodId;
        this.shippingMethodId = shippingMethodId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.reasonCancel = reasonCancel;
        this.requestCancel = requestCancel;
        this.status = status;
        this.orderDate = orderDate;
        this.finishDate = finishDate;
        this.staffName = staffName;
        this.paymentMethodName = paymentMethodName;
        this.shippingMethodName = shippingMethodName;
        this.shippingMethodFee = shippingMethodFee;
        this.customerName = customerName;
        this.discountAmount = discountAmount;
    }

    public Order(int customerId, int paymentMethodId, int shippingMethodId, String name, String phone, String address, String note, double totalAmount, String status) {
        this.customerId = customerId;
        this.paymentMethodId = paymentMethodId;
        this.shippingMethodId = shippingMethodId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public Order(int customerId, int paymentMethodId, int shippingMethodId, String name, String phone, String address, String note, double totalAmount, String reasonCancel, String status) {
        this.customerId = customerId;
        this.paymentMethodId = paymentMethodId;
        this.shippingMethodId = shippingMethodId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.reasonCancel = reasonCancel;
        this.status = status;
    }
    
    

    public Order(int orderId, Integer staffId, String reasonCancel, String status, Timestamp finishDate) {
        this.orderId = orderId;
        this.staffId = staffId;
        this.reasonCancel = reasonCancel;
        this.status = status;
        this.finishDate = finishDate;
    }

    public Order(int orderId, String reasonCancel, boolean requestCancel, String status) {
        this.orderId = orderId;
        this.reasonCancel = reasonCancel;
        this.requestCancel = requestCancel;
        this.status = status;
    }

    public Order(int orderId, String reasonCancel, String status) {
        this.orderId = orderId;
        this.reasonCancel = reasonCancel;
        this.status = status;
    }
    
   
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public int getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public int getShippingMethodId() {
        return shippingMethodId;
    }

    public void setShippingMethodId(int shippingMethodId) {
        this.shippingMethodId = shippingMethodId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getReasonCancel() {
        return reasonCancel;
    }

    public void setReasonCancel(String reasonCancel) {
        this.reasonCancel = reasonCancel;
    }

    public boolean isRequestCancel() {
        return requestCancel;
    }

    public void setRequestCancel(boolean requestCancel) {
        this.requestCancel = requestCancel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        return sdf.format(orderDate);
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getFinishDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        return sdf.format(finishDate);
    }

    public void setFinishDate(Timestamp finishDate) {
        this.finishDate = finishDate;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getPaymentMethodName() {
        return paymentMethodName;
    }

    public void setPaymentMethodName(String paymentMethodName) {
        this.paymentMethodName = paymentMethodName;
    }

    public String getShippingMethodName() {
        return shippingMethodName;
    }

    public void setShippingMethodName(String shippingMethodName) {
        this.shippingMethodName = shippingMethodName;
    }

    public double getShippingMethodFee() {
        return shippingMethodFee;
    }

    public void setShippingMethodFee(double shippingMethodFee) {
        this.shippingMethodFee = shippingMethodFee;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    
}
