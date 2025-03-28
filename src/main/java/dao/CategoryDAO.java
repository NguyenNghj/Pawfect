/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class CategoryDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT category_id, category_name, is_active FROM Category";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Category> getAllActiveCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT category_id, category_name FROM Category WHERE is_active = 1";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt(1),
                        rs.getString(2),
                        true // Mặc định là đang hoạt động
                ));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Nên thay bằng logging trong thực tế
        }
        return categories;
    }

    public boolean isCategoryExists(String categoryName) {
        String query = "SELECT COUNT(*) FROM Category WHERE LOWER(category_name) = LOWER(?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            ps.setString(1, categoryName);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Nếu COUNT > 0, danh mục đã tồn tại
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isCategoryExists(String categoryName, int excludeId) {
        String query = "SELECT COUNT(*) FROM Category WHERE LOWER(category_name) = LOWER(?) AND category_id != ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            ps.setString(1, categoryName);
            ps.setInt(2, excludeId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Category getCategoryById(int categoryId) {
        String query = "SELECT category_id, category_name, is_active FROM Category WHERE category_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean getCategoryActive(int categoryId) {
        boolean isActive = false;
        String query = "SELECT is_active FROM Category WHERE category_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();
            if (rs.next()) {
                isActive = rs.getBoolean(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isActive;
    }

    public List<Category> searchCategories(String keyword) {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT category_id, category_name, is_active FROM Category WHERE category_name COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%"); // Tìm kiếm theo từ khóa
            rs = ps.executeQuery();

            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public boolean createCategory(Category category) {
        String query = "INSERT INTO Category (category_name, is_active) VALUES (?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, category.getCategoryName());
            ps.setBoolean(2, category.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCategory(int categoryId, String categoryName, boolean isActive) {
        String query = "UPDATE Category SET category_name = ?, is_active = ? WHERE category_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
            ps.setBoolean(2, isActive);
            ps.setInt(3, categoryId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Trả về false nếu cập nhật thất bại
    }

}
