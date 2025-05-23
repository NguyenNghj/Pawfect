package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PetHotelBooking {

    private int bookingId;
    private int roomId;
    private String roomName;
    private int customerId;
    private String customerName;
    private String customerPhone;
    private String customerEmail;
    private Integer staffId; // Có thể null
    private String staffName;
    private int petId;
    private String petName;
    private String petType;
    private String petWeight;
    private String petBreed;
    private String petStatus;
    private Timestamp checkIn;
    private Timestamp checkOut;
    private BigDecimal totalPrice;
    private String note;
    private String status;
    private Timestamp bookingDate;
    private boolean isActive;

    public String getPetStatus() {
        return petStatus;
    }

    public void setPetStatus(String petStatus) {
        this.petStatus = petStatus;
    }

    //detail
    public PetHotelBooking(int bookingId, int roomId, String roomName, int customerId, String customerName,
            String customerPhone, String customerEmail, Integer staffId, String staffName,
            int petId, String petName, String petType, String petWeight, String petBreed,
            String petStatus, Timestamp checkIn, Timestamp checkOut, BigDecimal totalPrice,
            String note, String status, Timestamp bookingDate, boolean isActive) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomName = roomName;
        this.customerId = customerId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerEmail = customerEmail;
        this.staffId = staffId;
        this.staffName = staffName;
        this.petId = petId;
        this.petName = petName;
        this.petType = petType;
        this.petWeight = petWeight;
        this.petBreed = petBreed;
        this.petStatus = petStatus;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
        this.bookingDate = bookingDate;
        this.isActive = isActive;
    }

    // có petStatus
    public PetHotelBooking(int bookingId, int roomId, String roomName, int customerId, String customerName, Integer staffId, String staffName, int petId, String petName, String petStatus, Timestamp checkIn, Timestamp checkOut, BigDecimal totalPrice, String note, String status, Timestamp bookingDate, boolean isActive) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomName = roomName;
        this.customerId = customerId;
        this.customerName = customerName;
        this.staffId = staffId;
        this.staffName = staffName;
        this.petId = petId;
        this.petName = petName;
        this.petStatus = petStatus;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
        this.bookingDate = bookingDate;
        this.isActive = isActive;
    }

    public PetHotelBooking() {
    }

    public PetHotelBooking(int bookingId, int roomId, String roomName, int customerId, String customerName,
            Integer staffId, String staffName, int petId, String petName,
            Timestamp checkIn, Timestamp checkOut, BigDecimal totalPrice,
            String note, String status, Timestamp bookingDate, boolean isActive) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomName = roomName;
        this.customerId = customerId;
        this.customerName = customerName;
        this.staffId = staffId;
        this.staffName = staffName;
        this.petId = petId;
        this.petName = petName;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
        this.bookingDate = bookingDate;
        this.isActive = isActive;
    }

    // Getters và Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public int getPetId() {
        return petId;
    }

    public void setPetId(int petId) {
        this.petId = petId;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public Timestamp getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Timestamp checkIn) {
        this.checkIn = checkIn;
    }

    public Timestamp getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Timestamp checkOut) {
        this.checkOut = checkOut;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }
}
