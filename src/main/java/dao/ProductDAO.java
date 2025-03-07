package dao;

import db.DBContext;
import java.util.Comparator;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description, p.is_active "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getBoolean(10)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> getAllActiveProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description, p.is_active "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE p.is_active = 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getBoolean(10)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> getAllActiveProductsByCategoryName(String categoryName) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description, p.is_active "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE c.category_name = ? AND p.is_active = 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6),
                        rs.getString(7), rs.getInt(8), rs.getString(9), rs.getBoolean(10)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public Product getProductById(int productId) {
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description, p.is_active "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE p.product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6),
                        rs.getString(7), rs.getInt(8), rs.getString(9), rs.getBoolean(10)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, \n"
                + "                p.product_price, p.product_image, p.stock, p.description, p.is_active \n"
                + "                FROM Products p \n"
                + "               JOIN Category c ON p.category_id = c.category_id \n"
                + "                WHERE (p.product_name LIKE ? OR p.product_petType LIKE  ? OR c.category_name LIKE  ?)"
                + "                AND p.is_active = 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getDouble(6),
                        rs.getString(7), rs.getInt(8), rs.getString(9), rs.getBoolean(10)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE Products SET category_id = ?, product_name = ?, product_petType = ?, "
                + "product_price = ?, product_image = ?, stock = ?, description = ?, is_active = ? "
                + "WHERE product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getProductPetType());
            ps.setDouble(4, product.getProductPrice());
            ps.setString(5, product.getProductImage());
            ps.setInt(6, product.getStock());
            ps.setString(7, product.getDescription());
            ps.setBoolean(8, product.isActive());
            ps.setInt(9, product.getProductId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProductInactiveByCategory(int categoryId) {
        String query = "UPDATE Products SET is_active = 0 WHERE category_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO Products (category_id, product_name, product_petType, product_price, product_image, stock, description, is_active) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getProductPetType());
            ps.setDouble(4, product.getProductPrice());
            ps.setString(5, product.getProductImage());
            ps.setInt(6, product.getStock());
            ps.setString(7, product.getDescription());
            ps.setBoolean(8, product.isActive());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Product> filterByPrice(List<Product> products, String priceFilter) {
        List<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            double price = product.getProductPrice();
            switch (priceFilter) {
                case "1":
                    if (price < 100000) {
                        filteredList.add(product);
                    }
                    break;
                case "2":
                    if (price >= 100000 && price <= 300000) {
                        filteredList.add(product);
                    }
                    break;
                case "3":
                    if (price > 300000) {
                        filteredList.add(product);
                    }
                    break;
            }
        }
        return filteredList;
    }

    public List<Product> filterByPetType(List<Product> products, String petTypeFilter) {
        switch (petTypeFilter) {
            case "1":
                petTypeFilter = "Chó";
                break;
            case "2":
                petTypeFilter = "Mèo";
                break;
        }
        List<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            String petType = product.getProductPetType();
            if (petType != null && petType.equalsIgnoreCase(petTypeFilter)) {
                filteredList.add(product);
            }
        }
        return filteredList;
    }

    public List<Product> sortProducts(List<Product> products, String sortFilter) {
        if (sortFilter == null || sortFilter.isEmpty()) {
            return products;
        }
        switch (sortFilter) {
            case "1":
                products.sort(Comparator.comparingDouble(Product::getProductPrice));
                break;
            case "2":
                products.sort(Comparator.comparingDouble(Product::getProductPrice).reversed());
                break;
            case "3":
                products.sort(Comparator.comparing(Product::getProductName));
                break;
        }
        return products;
    }

}
