/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Pet;

/**
 *
 * @author LENOVO
 */
public class PetDAO {

    Connection conn = null;
    PreparedStatement pt = null;
    ResultSet rs = null;

    public List<Pet> getAllPets(String customerId) {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT * FROM Pets where customer_id=?";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, customerId);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet(
                        rs.getString("pet_id"),
                        rs.getString("customer_id"),
                        rs.getString("pet_name"),
                        rs.getString("pet_type"),
                        rs.getString("pet_breed"),
                        rs.getString("pet_sex"),
                        rs.getString("pet_weigth"),
                        rs.getDate("pet_dob"),
                        rs.getString("pet_status"),
                        rs.getString("pet_image")
                );
                petList.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    public Pet getPetId(String petId, String customerId) {
        Pet pet = new Pet();
        String query = "SELECT * FROM Pets where pet_id=? and customer_id=?";
        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(query);
            pt.setString(1, petId);
            pt.setString(2, customerId);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                pet = new Pet(
                        rs.getString("pet_id"),
                        rs.getString("customer_id"),
                        rs.getString("pet_name"),
                        rs.getString("pet_type"),
                        rs.getString("pet_breed"),
                        rs.getString("pet_sex"),
                        rs.getString("pet_weigth"),
                        rs.getDate("pet_dob"),
                        rs.getString("pet_status"),
                        rs.getString("pet_image")
                );

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pet;
    }

    public void updatePet(String petId, String name, String type, String breed, String sex, String weight, Date dob, String petImage) {
        String sql = "UPDATE Pets SET pet_name=?, pet_type=?, pet_breed=?, pet_sex=?, pet_weigth=?, pet_dob=?,pet_image=?  WHERE pet_id=?";

        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(sql);
            pt.setString(1, name);
            pt.setString(2, type);
            pt.setString(3, breed);
            pt.setString(4, sex);
            pt.setString(5, weight);
            pt.setDate(6, dob);
            pt.setString(7, petImage);
            pt.setString(8, petId);

            pt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePet(String petId) {
        String sql = "DELETE FROM Pets WHERE pet_id = ?";

        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(sql);
            pt.setString(1, petId);

            pt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addPet(String customerId, String petName, String petType, String petBreed, String petSex, String petWeight, Date petDob, String petImage) {
        String sql = "INSERT INTO Pets (customer_id,pet_name, pet_type, pet_breed, pet_sex, pet_weigth, pet_dob, pet_image, pet_status) VALUES (?,?, ?, ?, ?, ?, ?, ?, 'Health')";

        try {
            conn = new DBContext().getConnection();
            pt = conn.prepareStatement(sql);
            pt.setString(1, customerId);
            pt.setString(2, petName);
            pt.setString(3, petType);
            pt.setString(4, petBreed);
            pt.setString(5, petSex);
            pt.setString(6, petWeight);
            pt.setDate(7, petDob);
            pt.setString(8, petImage);

            pt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
