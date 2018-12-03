/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Controlador.Consultas;
import Utilidades.md5;
import com.mysql.jdbc.exceptions.jdbc4.CommunicationsException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "CambiarContrasena", urlPatterns = {"/CambiarContrasena"})
public class CambiarContrasena extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //response.setContentType("text/plain");

        String contrasena = request.getParameter("txtpass");
        String verificarcontrasena = request.getParameter("txtVpass");
        if (contrasena.equals(verificarcontrasena)) {
            try {
                Consultas co = new Consultas();
                if (co.CambiarContrasena(md5.Encriptar(contrasena))) {
                    //response.sendRedirect("Coordinadora.jsp");
                     out.print(" <div class=\"alert alert-warning alert-dismissable\" role=\"alert\"> "+
                        "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>" +
                "<strong>Exito!</strong> La contraseña fue cambiada correctamente"+ 
                "</div> ");
             
             RequestDispatcher rd=request.getRequestDispatcher("Coordinadora.jsp");  
             
                rd.include(request,response);
                } else {
                   // response.sendRedirect("NuevaContrasena.jsp");
 out.print(" <div class=\"alert alert-warning alert-dismissable\" role=\"alert\"> "+
                        "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>" +
                "<strong>Error!</strong> La contraseña no coincide"+ 
                "</div> ");
             
             RequestDispatcher rd=request.getRequestDispatcher("NuevaContrasena.jsp");  
             
                rd.include(request,response);
                }
            } catch (CommunicationsException ex) {
                 response.sendRedirect("ErrorPages/ErrorDeConexionBD.html");
            }

        } else {
            out.println("Invalid password <a href='NuevaContrasena.jsp'>try again</a>");
        }
    }
}
