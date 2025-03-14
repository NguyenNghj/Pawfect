/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PetDAO;
import dao.ProfileDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

import java.sql.Date;
import model.Pet;
import model.User;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
/**
 *
 * @author LENOVO
 */
public class EditPetServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditPetServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditPetServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      String petId = request.getParameter("petId");
        PetDAO petDAO = new PetDAO(); 
         String customerId = null;   
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {            
                if ("customerId".equals(cookie.getName())) {
                         customerId  = cookie.getValue();
                    break;
                }
            }
        }

        Pet pet = petDAO.getPetId(petId,customerId);
       if(!Pet.isEmpty(pet)) {
       request.setAttribute("pet", pet);
        ProfileDAO profileDAO = new ProfileDAO();
User user = profileDAO.getUser(customerId);
request.setAttribute("customer", user);
        request.getRequestDispatcher("editpet.jsp").forward(request, response);
       }
       else{
        response.sendRedirect("viewpet");
       }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String petId = request.getParameter("petId");
        String petName = request.getParameter("petName");
        String petType = request.getParameter("petType");
        String petBreed = request.getParameter("petBreed");
        String petSex = request.getParameter("petSex");
        String petWeight = request.getParameter("petWeight");
        String birthDateStr = request.getParameter("petDob");
        Date petDob = Date.valueOf(birthDateStr);
        String existingImage = request.getParameter("existingImage");
        String[] context = request.getServletContext().getRealPath("").split("target");
        String realPath = context[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "img" + File.separator + "pet";

        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = existingImage; // Giữ ảnh cũ mặc định
        Part filePart = request.getPart("petImage");

        if (filePart != null && filePart.getSize() > 0) {
            // Lấy tên file mới
            String newFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            // Xác định đường dẫn file ảnh cũ
            File oldImageFile = new File(realPath + File.separator + existingImage);
            // Lưu ảnh mới
            filePart.write(realPath + File.separator + newFileName);
            // Xóa ảnh cũ 
            oldImageFile.delete();
            fileName = newFileName; // Cập nhật tên ảnh mới vào CSDL
        }

        PetDAO petDAO = new PetDAO();
        // Cập nhật database
        petDAO.updatePet(petId, petName, petType, petBreed, petSex, petWeight, petDob, fileName);
        response.sendRedirect("petviewdetail?petId=" + petId);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
