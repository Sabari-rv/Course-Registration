<%-- 
    Document   : adminjsp
    Created on : Sep 15, 2022, 8:02:59 PM
    Author     : Sabarinathan R V
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Home</title>
        <style>
            table, th, td 
            {
                border:1px solid black;
            }
            th
            {
                border: 1px solid black;
                text-align:left;
            }
            body,html
            {
                background-image: url('https://theinjuryspecialists.com/wp-content/uploads/2016/11/solution-background.jpg');
                background-size: 100%;
            }
            .out
            {
                margin: 60px;
                padding-left: 65px;
                padding-top:20px;
                padding-bottom: 300px;
            }
        </style>
    </head>
    <body>
       <%
           try
            {
                //for db connection
                String username = "xyz";
                String password = "abc";
                String URL = "jdbc:mysql://localhost:3306/javatables";

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connect = DriverManager.getConnection(URL,username,password);
                Statement stmt = connect.createStatement();
                
                String admin_name = request.getParameter("adminname");
                String admin_pass = request.getParameter("adminpass");
                String name = null;
                String pass = null;
                String query1 = "SELECT adminname, adminpassword FROM admin_details WHERE adminname='"+admin_name+"';";
                
                ResultSet res1 = stmt.executeQuery(query1);
                
                while(res1.next())
                {
                    name = res1.getString(1);
                    pass= res1.getString(2);
                
                }
                if(name.equals(admin_name) && pass.equals(admin_pass))
                {
                out.println("<h1><center>REGISTERED STUDENT LIST</center></h1>");
                out.println("<h2><center>COURSE SUMMARY</center></h2>");
                String query2 = "SELECT * FROM student;";
                ResultSet res = stmt.executeQuery(query2);
                %>
                
                <center>
                        <table>
                            <tr>
                                <th>Student Register Number</th>
                                <th>Student Name</th>
                                <th>Total Courses</th>
                                <th>Total credits</th>
                            </tr>
                <%
            
                    while(res.next())
                    {
                    String Stud_regno = res.getString(1);
                    String Stud_name = res.getString(2);
                    int Stud_cred = res.getInt(3);
                    int Stud_course = res.getInt(4);
                    %>
                            <tr>
                                <td><%out.println("<a href='creddisplay.jsp?regnum="+Stud_regno+"'>"+Stud_regno+"</a>");%></td>
                                <td><%out.println(Stud_name);%></td>
                                <td><%out.println(Stud_cred);%></td>
                                <td><%out.println(Stud_course);%></td>
                            </tr>
                <%}%>
                 </table>
                    </center><%
                }
                else
                {
                    out.println("<h1><center>Invalid Credentials :(</center></h1>");
                    out.println("<center><a href='admin.html'>Click here to login again</a></center>");
                }
      
            }catch(Exception e)
            {
                out.println(e.getMessage());
            }

            %>
    </body>
</html>
