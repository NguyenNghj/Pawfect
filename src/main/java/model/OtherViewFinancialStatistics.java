package model;


import java.math.BigDecimal;
import java.sql.Date;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author ADMIN
 */
public class OtherViewFinancialStatistics {

    private Date order_date;
    private int shippingMethod_id;
    private int staff_id;
    private int customer_id;
    private int order_id;
    private int paymentMethod_id;
    private String recipient_name;
    private String recipient_phone;
    private String shipping_address;
    private String delivery_notes;
    private String status;
    private BigDecimal total_amount;

    public OtherViewFinancialStatistics(Date order_date, int shippingMethod_id, int staff_id, int customer_id, int order_id, int paymentMethod_id, String recipient_name, String recipient_phone, String shipping_address, String delivery_notes, String status, BigDecimal total_amount) {
        this.order_date = order_date;
        this.shippingMethod_id = shippingMethod_id;
        this.staff_id = staff_id;
        this.customer_id = customer_id;
        this.order_id = order_id;
        this.paymentMethod_id = paymentMethod_id;
        this.recipient_name = recipient_name;
        this.recipient_phone = recipient_phone;
        this.shipping_address = shipping_address;
        this.delivery_notes = delivery_notes;
        this.status = status;
        this.total_amount = total_amount;
    }

    public OtherViewFinancialStatistics() {
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public int getShippingMethod_id() {
        return shippingMethod_id;
    }

    public void setShippingMethod_id(int shippingMethod_id) {
        this.shippingMethod_id = shippingMethod_id;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getPaymentMethod_id() {
        return paymentMethod_id;
    }

    public void setPaymentMethod_id(int paymentMethod_id) {
        this.paymentMethod_id = paymentMethod_id;
    }

    public String getRecipient_name() {
        return recipient_name;
    }

    public void setRecipient_name(String recipient_name) {
        this.recipient_name = recipient_name;
    }

    public String getRecipient_phone() {
        return recipient_phone;
    }

    public void setRecipient_phone(String recipient_phone) {
        this.recipient_phone = recipient_phone;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
    }

    public String getDelivery_notes() {
        return delivery_notes;
    }

    public void setDelivery_notes(String delivery_notes) {
        this.delivery_notes = delivery_notes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(BigDecimal total_amount) {
        this.total_amount = total_amount;
    }


 }
