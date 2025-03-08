/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class Product {

    private int productId;
    private int categoryId;
    private String categoryName;
    private String productName;
    private String productPetType;
    private double productPrice;
    private String productImage;
    private int stock;
    private String description;
    private boolean active;

    public Product(int productId, int categoryId, String categoryName, String productName, String productPetType, double productPrice, String productImage, int stock, String description, boolean active) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.productName = productName;
        this.productPetType = productPetType;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.stock = stock;
        this.description = description;
        this.active = active;
    }

    public Product(int productId, int categoryId, String productName, String productPetType, double productPrice, String productImage, int stock, String description, boolean active) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.productPetType = productPetType;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.stock = stock;
        this.description = description;
        this.active = active;
    }

    public Product(int categoryId, String productName, String productPetType, double productPrice, String productImage, int stock, String description, boolean active) {
        this.categoryId = categoryId;
        this.productName = productName;
        this.productPetType = productPetType;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.stock = stock;
        this.description = description;
        this.active = active;
    }

    public Product(int productId, String productName, double productPrice, String productImage, int stock, boolean active) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.stock = stock; // total_sold gán vào stock
        this.active = active;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPetType() {
        return productPetType;
    }

    public void setProductPetType(String productPetType) {
        this.productPetType = productPetType;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

}
