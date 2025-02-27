package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PetHotelBooking {
    private int bookingId;
    private String roomName;  // Đổi từ roomId -> roomName
    private String customerName;
    private String staffName;
    private String petName;
    private Timestamp checkIn;
    private Timestamp checkOut;
    private BigDecimal totalPrice;
    private String note;
    private String status;
    private Timestamp bookingDate;

    public PetHotelBooking(int bookingId, String roomName, String customerName, String staffName, String petName, 
                           Timestamp checkIn, Timestamp checkOut, BigDecimal totalPrice, 
                           String note, String status, Timestamp bookingDate) {
        this.bookingId = bookingId;
        this.roomName = roomName;
        this.customerName = customerName;
        this.staffName = staffName;
        this.petName = petName;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
        this.bookingDate = bookingDate;
    }

    // Getters và Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public Timestamp getCheckIn() { return checkIn; }
    public void setCheckIn(Timestamp checkIn) { this.checkIn = checkIn; }

    public Timestamp getCheckOut() { return checkOut; }
    public void setCheckOut(Timestamp checkOut) { this.checkOut = checkOut; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
}
