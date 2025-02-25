package model;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class PetRooms {
    private int roomId;
    private String roomName;
    private String roomImage;
    private String roomType;
    private double minWeight;
    private double maxWeight;
    private int quantity;
    private double pricePerNight;
    private String status;
    private boolean isActive;

    // Constructor
    public PetRooms() {}

    public PetRooms(int roomId, String roomName, String roomImage, String roomType, double minWeight, double maxWeight, int quantity, double pricePerNight, String status, boolean isActive) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomImage = roomImage;
        this.roomType = roomType;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.quantity = quantity;
        this.pricePerNight = pricePerNight;
        this.status = status;
        this.isActive = isActive;
    }

    // Getters và Setters
    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getRoomImage() { return roomImage; }
    public void setRoomImage(String roomImage) { this.roomImage = roomImage; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getMinWeight() { return minWeight; }
    public void setMinWeight(double minWeight) { this.minWeight = minWeight; }

    public double getMaxWeight() { return maxWeight; }
    public void setMaxWeight(double maxWeight) { this.maxWeight = maxWeight; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(double pricePerNight) { this.pricePerNight = pricePerNight; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
}