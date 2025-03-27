package model;

import java.sql.Date;

public class Pet {
    private String petId;
    private String customerId;
    private String petname;
    private String petType;
    private String petBreed;
    private String petSex;
    private String petWeight;
    private Date petDob; 
    private String petStatus;
    private String petImg;

    // Constructor mặc định
    public Pet() {
        this.petId = "";
        this.customerId = "";
        this.petname = "";
        this.petType = "";
        this.petBreed = "";
        this.petSex = "";
        this.petWeight = "";
        this.petDob = null; 
        this.petStatus = "";
        this.petImg = "";
    }

    // Constructor đầy đủ
    public Pet(String petId, String customerId, String petname, String petType, String petBreed, 
               String petSex, String petWeight, Date petDob, String petStatus, String petImg) {
        this.petId = petId;
        this.customerId = customerId;
        this.petname = petname;
        this.petType = petType;
        this.petBreed = petBreed;
        this.petSex = petSex;
        this.petWeight = petWeight;
        this.petDob = petDob;
        this.petStatus = petStatus;
        this.petImg = petImg;
    }

   
    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getPetname() {
        return petname;
    }

    public void setPetname(String petname) {
        this.petname = petname;
    }

    public String getPetType() {
        return petType;
    }

    public void setPetType(String petType) {
        this.petType = petType;
    }

    public String getPetBreed() {
        return petBreed;
    }

    public void setPetBreed(String petBreed) {
        this.petBreed = petBreed;
    }

    public String getPetSex() {
        return petSex;
    }

    public void setPetSex(String petSex) {
        this.petSex = petSex;
    }

    public String getPetWeight() {
        return petWeight;
    }

    public void setPetWeight(String petWeight) {
        this.petWeight = petWeight;
    }

    public Date getPetDob() {
        return petDob;
    }

    public void setPetDob(Date petDob) {
        this.petDob = petDob;
    }

    public String getPetStatus() {
        return petStatus;
    }

    public void setPetStatus(String petStatus) {
        this.petStatus = petStatus;
    }

    public String getPetImg() {
        return petImg;
    }

    public void setPetImg(String petImg) {
        this.petImg = petImg;
    }
    public static boolean isEmpty(Pet pet) {
        return pet.getPetId().isEmpty() &&
               pet.getCustomerId().isEmpty() &&
               pet.getPetname().isEmpty() &&
               pet.getPetType().isEmpty() &&
               pet.getPetBreed().isEmpty() &&
               pet.getPetSex().isEmpty() &&
               pet.getPetWeight().isEmpty() &&
               pet.getPetStatus().isEmpty() &&
               pet.getPetImg().isEmpty() &&
               pet.getPetDob() == null;  
    }
}
