package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import model.Product;

/**
 *
 * @author Nguyen Tri Nghi - CE180897
 */
public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt("product_id"),
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("product_name"),
                        rs.getString("product_petType"),
                        rs.getDouble("product_price"),
                        rs.getString("product_image"),
                        rs.getInt("stock"),
                        rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm theo tên danh mục
    public List<Product> getAllProductsByCategoryName(String categoryName) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description "
                + "FROM Products p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE c.category_name = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, categoryName);
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
                        rs.getString(9)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int productId) {
        String query = "SELECT p.product_id, p.category_id, c.category_name, p.product_name, p.product_petType, "
                + "p.product_price, p.product_image, p.stock, p.description "
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
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lọc sản phẩm theo giá
    public List<Product> filterByPrice(List<Product> products, String giaFilter) {
        List<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            double price = product.getProductPrice();
            if ("1".equals(giaFilter) && price < 100000) {
                filteredList.add(product);
            } else if ("2".equals(giaFilter) && price >= 100000 && price <= 300000) {
                filteredList.add(product);
            } else if ("3".equals(giaFilter) && price > 300000) {
                filteredList.add(product);
            }
        }
        return filteredList;
    }

    // Sắp xếp sản phẩm
    public List<Product> sortProducts(List<Product> products, String sapxepFilter) {
        if (sapxepFilter == null || sapxepFilter.isEmpty()) {
            return products;  // Không sắp xếp nếu không có filter
        }

        switch (sapxepFilter) {
            case "1":
                products.sort(Comparator.comparingDouble(Product::getProductPrice));
                break;
            case "2":
                products.sort(Comparator.comparingDouble(Product::getProductPrice).reversed());
                break;
            case "3":
                products.sort(Comparator.comparing(Product::getProductName));
                break;
            default:
                break;
        }
        return products;
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE Products SET category_id = ?, product_name = ?, product_petType = ?, product_price = ?, product_image = ?, stock = ?, description = ? WHERE product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getProductPetType());
            ps.setDouble(4, product.getProductPrice());
            ps.setString(5, product.getProductImage());
            ps.setInt(6, product.getStock());
            ps.setString(7, product.getDescription()); // Thêm description
            ps.setInt(9, product.getProductId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

}
