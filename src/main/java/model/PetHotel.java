package model;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class PetHotel {

    private int roomId;
    private String roomName;
    private String roomImage;
    private String roomType;
    private double minWeight;
    private double maxWeight;
    private int quantity;
    private int availableQuantity; // Thêm số lượng phòng trống
    private double pricePerNight;
    private String description;
    private String status;
    private boolean isActive;

    private int timeBooking;
    private double totalRenueve;

   // Constructor không có `status` và `isActive`
    public PetHotel(String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, int availableQuantity, double pricePerNight, String description) {
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.pricePerNight = pricePerNight;
        this.description = description;
        this.status = "Còn phòng";
        this.isActive = true;
    }

    public PetHotel(int roomId, String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, int availableQuantity, double pricePerNight, String description) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.pricePerNight = pricePerNight;
        this.description = description;
    }

    public PetHotel(int roomId, String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, int availableQuantity, double pricePerNight, String description, boolean isActive) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.pricePerNight = pricePerNight;
        this.description = description;
        this.isActive = isActive;
    }

    public PetHotel() {
    }

    // Constructor đầy đủ
    public PetHotel(int roomId, String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, int availableQuantity, double pricePerNight, String description, String status, boolean isActive) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.pricePerNight = pricePerNight;
        this.description = description;
        this.status = status;
        this.isActive = isActive;
    }

    public PetHotel(int roomId, String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, int availableQuantity, double pricePerNight, String description, String status) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.pricePerNight = pricePerNight;
        this.description = description;
        this.status = status;
    }

    public PetHotel(int roomId, String roomName, int timeBooking, double totalRenueve) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.timeBooking = timeBooking;
        this.totalRenueve = totalRenueve;
    }

    // Getters và Setters
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

    public String getRoomImage() {
        return roomImage;
    }

    public void setRoomImage(String roomImage) {
        this.roomImage = roomImage;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public double getMinWeight() {
        return minWeight;
    }

    public void setMinWeight(double minWeight) {
        this.minWeight = minWeight;
    }

    public double getMaxWeight() {
        return maxWeight;
    }

    public void setMaxWeight(double maxWeight) {
        this.maxWeight = maxWeight;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(int availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }


    public int getTimeBooking() {
        return timeBooking;
    }

    public void setTimeBooking(int timeBooking) {
        this.timeBooking = timeBooking;
    }

    public double getTotalRenueve() {
        return totalRenueve;
    }

    public void setTotalRenueve(double totalRenueve) {
        this.totalRenueve = totalRenueve;
    }

}
