<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>REGISTRO DE ASISTENCIA</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/main3.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.2/bootstrap-table.min.css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.2/bootstrap-table.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.2/locale/bootstrap-table-es-MX.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/extensions/filter/bootstrap-table-filter.min.js"></script> 
        <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/extensions/filter-control/bootstrap-table-filter-control.min.js"></script> 


    </head>

    <body id="body">
        <div>
            <img id="logo"  src="images/page_1.jpg">
        </div>        
        <!-- *****************************************************< Begin Nav >***************************************************************** -->

        <nav  class="navbar navbar-expand-lg navbar-dark " style="width:80% ;margin-bottom: 0%; left:10%; background-color: #1A5276">
            <a class="navbar-brand" href="Portero.jsp">Principal</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">                        
                    <li class="nav-item">
                        <a class="nav-link" href="NuevaContrasenaPortero.jsp">Cambiar Contraseña</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="CerrarSesion">Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- *****************************************************< End Nav >***************************************************************** -->

        <div id="contenedor">
            <!--<div class="cerrar">
               <div class="form-group aju"><button class="btn btn-info btn-block" type="submit">CERRAR SESIÓN</button></div><br>
           </div>-->
            <h2 id="h2">Bienvenido Vigilante</h2><br><hr> 
            <%
                String aviso = (String) request.getAttribute("Mensaje");
                if (aviso != null) {
                    out.println(aviso);
                    request.setAttribute("Mensaje", null);
                }
                aviso = (String) request.getAttribute("AvisoContrasena");
                if (aviso != null) {
                    out.println(aviso);
                    request.setAttribute("AvisoContrasena", null);
                }
            %>
            <h2 id="h2">Registro de asistencias</h2>     
            <div  class="escanear">
                <form  id="registrar-asistencia" method="POST" autocomplete="off">

                    <div class="form" style="padding-left: 20%">
                        <label class="form-group">Número de control: </label>	
                        <div class="form-group" style="display:inline-block">
                            <input class="form-control" onkeypress="soloNumerosAqui(event)" type="text" id="input-nocontrol" name="nocontrol" placeholder="Esperando..." autocomplete="off" maxlength="8" minlength="8" required="required" style="width:40%;display: inline-block">
                            <button id="btn-registrar" class="btn btn-primary btn-block" type="submit" style="width:40%; display:inline-block">Registrar</button>
                        </div>
                        <div class="radio-group "> 
                            <input type="radio" checked="checked" id="option-one" value="0" onclick="loadValueFromRadio(this.value)" name="selector" class="form-group aju2"><label class="label" for="option-one" style="color:black">Normal</label>
                            <input type="radio" id="option-two" value="1" onclick="loadValueFromRadio(this.value)" name="selector" class="form-group aju2"><label class="label" for="option-two" style="color:black">Incidencia</label>

                        </div><br>
                    </div>
                </form>

                <!-- *******************************************Div de aviso ********************************************** -->
                <div class="alert alert-success" id="aviso" style="display: none">
                    <!--<strong>Success!</strong> Indicates a successful or positive action.-->
                </div>
                <center><img src=""  id="img-alumno-img" style="display:none;height:150px; width:150px" ></center>

                <div class="form">
                    <div class="form-group aju"><button class="btn btn-primary btn-block" type="submit" id="button-manual">MANUAL</button></div><br>
                    <div id="contenedor_buscar">

                        <div>
                            <%@page import="java.sql.*" %>
                            <%
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cbetis123", "root", "");

                                Statement Estamento = conexion.createStatement();
                                ResultSet rs = Estamento.executeQuery(""
                                        + "SELECT * "
                                        + "FROM estudiante");%>


                            <div class="container" style=" width: 98%">
                                <table id="table"  data-toggle="table"
                                       data-click-to-select="true"
                                       data-filter-control="true"
                                       data-toolbar="#toolbar"
                                       data-pagination="true"  
                                       data-side-pagination="client" 
                                       data-page-size="10" 
                                       data-page-list="[10, 25, 50]">
                                    <thead>
                                        <tr>

                                            <th  data-field="NoControl"   data-filter-control="input"  data-sortable="true">No. de Control</th>
                                            <th data-field="Nombre" data-filter-control="input" data-sortable="true">Nombre</th>
                                            <th data-field="Apellido Paterno" data-filter-control="input" data-sortable="true">Apellido Paterno</th>
                                            <th data-field="Apellido Materno" data-width="15%" data-filter-control="input" data-sortable="true">Apellido Materno</th>
                                        </tr>
                                    </thead>
                                    <tbody id="myTable">
                                        <% while (rs.next()) {
                                                out.println("<tr>");

                                                out.println("<td>");

                                                out.println(rs.getInt("NoControl"));

                                                out.println("</td><td>");

                                                out.println(rs.getString("Nombre"));

                                                out.println("</td><td>");

                                                out.println(rs.getString("ApPaterno"));

                                                out.println("</td><td>");

                                                out.println(rs.getString("ApMaterno"));

                                                out.println("</td>");

                                                out.println("</tr>");
                                            }%>

                                    </tbody>
                                </table>
                            </div>
                        </div>  
                    </div>


                </div>



            </div>
        </div>	
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/InsertarAsistencia.js"></script>
        <script src="js/EventosPortero.js"></script>


        <script>
                                $(document).ready(function () {
                                    $("#MyIdName").on("keyup", function () {
                                        var value = $(this).val().toLowerCase();
                                        $("#myTable tr").filter(function () {
                                            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                                        });
                                    });
                                });
        </script>

        <script>

            var $table = $('#table');
            $(function () {
                $('#toolbar').find('select').change(function () {
                    $table.bootstrapTable('refreshOptions', {
                        exportDataType: $(this).val()
                    });
                });
            });

            var trBoldBlue = $("table");

            $(trBoldBlue).on("click", "tr", function () {
                $(this).toggleClass("bold-blue");
            });
        </script>
    </body>
</html>
