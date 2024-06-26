/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets.petServlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Account;
import models.AnimalType;
import models.Breed;
import services.AddPetServices;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import services.ValidationServices;

/**
 *
 * @author Chris
 */
@MultipartConfig
public class AddPetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AddPetServices aps = new AddPetServices();
        ValidationServices vs = new ValidationServices();
              
        String email = (String) session.getAttribute("email");
        if (email.equals("") || email == null){
            session.invalidate();
            response.sendRedirect("Login");
        }
        
        try {
            request.setAttribute("animalList", vs.getAnimalType());
            //request.setAttribute("breedList", vs.getBreedList());
            request.setAttribute("dogBreeds", aps.getDogBreeds());
            request.setAttribute("catBreeds", aps.getCatBreeds());
            request.setAttribute("exoticBreeds", aps.getExoticBreeds());
        } catch (Exception ex) {
            Logger.getLogger(AddPetServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        getServletContext().getRequestDispatcher("/WEB-INF/AddAPet.jsp").forward(request,response);
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
        HttpSession session = request.getSession();
        ValidationServices vs = new ValidationServices();
        
        request.setAttribute("animalList", vs.getAnimalType());
        request.setAttribute("breedList", vs.getBreedList());
       
        
           //get photo
//            Part filePart = request.getPart("picture");
//            InputStream fileInputStream = filePart.getInputStream();
//            String url =UUID.randomUUID().toString();
//            
//            //File fileToSave = new File(getServletContext().getInitParameter("upload.location"+"/"+filePart.getSubmittedFileName()));
//            File folder = (File) getServletContext().getAttribute(ServletContext.TEMPDIR);
//            File result = new File(folder, filePart.getSubmittedFileName());
//  //          File fileToSave = new File(getServletContext().getResourceAsStream("/upload-files/"+filePart.getSubmittedFileName()));
//            Files.copy(fileInputStream, result.toPath(), StandardCopyOption.REPLACE_EXISTING);
//        
        
        if(request.getParameter("action").toString().equals("cancel")){
            response.sendRedirect("MyPets");
        }
        else if(request.getParameter("action").toString().equals("save")){
            AddPetServices aps = new AddPetServices();
            
            System.out.println("making pet");
            String owner = (String)session.getAttribute("email");
            String petName = request.getParameter("petName");
            String sex = request.getParameter("sex");
            String type = request.getParameter("animal");
            String breed = request.getParameter("breed");
            String birthday = request.getParameter("birthday");
            String info = request.getParameter("medical");
            String vet = request.getParameter("vet");
         
            
            System.out.println("INPUT: "+petName+" "+type+" "+breed+" "+birthday+" "+vet+" "+info+" "+sex+" "+owner);

            try{
                String msg = vs.checkInput(petName, type, breed, birthday, vet, info, sex, owner);
                if (msg.equals("Checked")){
                    System.out.println("going to aps");
                    aps.createPet(petName, type, breed, birthday, vet, info, sex, owner, null);
                    response.sendRedirect("MyPets");
                }
                else {
                    session.setAttribute("errorMsg", msg);
                    System.out.println(msg);
                    getServletContext().getRequestDispatcher("/WEB-INF/AddAPet.jsp").forward(request,response);
//                    response.sendRedirect("AddPet");
                }
            }
            catch(Exception e){
                Logger.getLogger(AddPetServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }    
    }
    
}


//        HttpSession session = request.getSession();
//        ValidationServices vs = new ValidationServices();
//        
//        request.setAttribute("animalList", vs.getAnimalType());
//        request.setAttribute("breedList", vs.getBreedList());
//       
//        if(request.getParameter("action").toString().equals("cancel")){
//            response.sendRedirect("MyPets");
//        }
//        else if(request.getParameter("action").toString().equals("save")){
//            AddPetServices aps = new AddPetServices();
//            
//            System.out.println("making pet");
//            String owner = (String)session.getAttribute("email");
//            String petName = request.getParameter("petName");
//            String sex = request.getParameter("sex");
//            String type = request.getParameter("animal");
//            String breed = request.getParameter("breed");
//            String birthday = request.getParameter("birthday");
//            String info = request.getParameter("medical");
//            String vet = request.getParameter("vet");
//            
//            System.out.println("INPUT: "+petName+" "+type+" "+breed+" "+birthday+" "+vet+" "+info+" "+sex+" "+owner);
//
//            try{
//                String msg = vs.checkInput(petName, type, breed, birthday, vet, info, sex, owner);
//                if (msg.equals("Checked")){
//                    System.out.println("going to aps");
//                    aps.createPet(petName, type, breed, birthday, vet, info, sex, owner);
//                    response.sendRedirect("MyPets");
//                }
//                else {
//                    session.setAttribute("errorMsg", msg);
//                    System.out.println(msg);
//                    getServletContext().getRequestDispatcher("/WEB-INF/AddAPet.jsp").forward(request,response);
////                    response.sendRedirect("AddPet");
//                }
//            }
//            catch(Exception e){
//                Logger.getLogger(AddPetServlet.class.getName()).log(Level.SEVERE, null, e);
//            }
//        }    
//    }
//    
