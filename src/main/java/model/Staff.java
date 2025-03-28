package model;

import java.sql.Date;

public class Staff {

    private int staffId;
    private String roleName;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String gender;
    private Date birthDate;
    private String image;
    private boolean isActive;
    private double totalOrder;
    private double totalBooking;
    private double totalRevenue;

    // Constructor đầy đủ
    public Staff(int staffId, String roleName, String password, String fullName, String email, String phone, String address,
            String gender, Date birthDate, String image, boolean isActive) {
        this.staffId = staffId;
        this.roleName = roleName;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.birthDate = birthDate;
        this.image = image;
        this.isActive = isActive;
    }

    public Staff(int staffId, String password, String fullName, String email, String phone, String address, String gender, Date birthDate, String image, boolean isActive) {
        this.staffId = staffId;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.birthDate = birthDate;
        this.image = image;
        this.isActive = isActive;
    }

    public Staff(String password, String fullName, String email, String phone, String address, String gender, Date birthDate, String image, boolean isActive) {
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.birthDate = birthDate;
        this.image = image;
        this.isActive = isActive;
    }

    // Constructor không có staffId (dùng khi thêm mới)
    public Staff(String roleName, String password, String fullName, String email, String phone, String address,
            String gender, Date birthDate, String image, boolean isActive) {
        this.roleName = roleName;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.birthDate = birthDate;
        this.image = image;
        this.isActive = isActive;
    }

    public Staff(String fullName, String image, double totalOrder, double totalBooking, double totalRevenue) {
        this.fullName = fullName;
        this.image = image;
        this.totalOrder = totalOrder;
        this.totalBooking = totalBooking;
        this.totalRevenue = totalRevenue;
    }

    // Getters và Setters
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public double getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(double totalOrder) {
        this.totalOrder = totalOrder;
    }

    public double getTotalBooking() {
        return totalBooking;
    }

    public void setTotalBooking(double totalBooking) {
        this.totalBooking = totalBooking;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

}
