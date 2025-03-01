/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class Category {

    private int categoryId;
    private String categoryName;
    private boolean active;

    public Category(int categoryId, String categoryName, boolean active) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.active = active;
    }

    public Category(String categoryName, boolean active) {
        this.categoryName = categoryName;
        this.active = active;
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

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

}
