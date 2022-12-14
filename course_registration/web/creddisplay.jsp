<%-- 
    Document   : creddisplay
    Created on : Sep 15, 2022, 9:51:48 PM
    Author     : Sabarinathan R V
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Courses</title>
    
        <style>
            body,html
            {
                background-image: url('https://img.freepik.com/free-vector/white-abstract-background-design_23-2148825582.jpg?w=900&t=st=1663186262~exp=1663186862~hmac=b0bbb760ee5cadf3b01b5fac8bf45ed0eb20c47f8caf659f5d6169e78730824c');
                background-size: 100%;
            }
            table, th, td 
            {
                border:1px solid black;
            }
            th
            {
                border: 1px solid black;
                text-align:left;
            }
        </style>
    </head>
    <body>
        <h1><center>Course Details</center></h1>
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
                Statement stmt1 = connect.createStatement();
                String stud_reg = request.getParameter("regnum");
                String reg_nums[] = new String[30];
                
                String query1 = "SELECT regno FROM student;";
                ResultSet res = stmt.executeQuery(query1);
                
                int i=0;
                int j= 0;
                int k = 0;
                
                while(res.next())
                {
                    reg_nums[i++] = res.getString(1);
                }
                
                String query2 = "SELECT course_name FROM registered_courses WHERE regno='"+stud_reg+"';";
                ResultSet res1 = stmt.executeQuery(query2);                
                %>
    <center>  
         <table>
             <tr>
                 <th>List of courses</th>
                 <th>Credits</th>
                <%while(res1.next())
                { %>  
              
             </tr>
             <tr>
                 <td><%out.println(res1.getString(1));%></td>
                 <%String query3 = "SELECT credits FROM course_table WHERE course_name='"+res1.getString(1)+"';";

                 ResultSet res3 = stmt1.executeQuery(query3);
                 res3.next();%>
                 <td><%out.println(res3.getInt(1)); %></td>
             </tr>
                <%
                }%>
         </table>
    </center>
        <%
            }catch(Exception e)
            {
                out.println(e.getMessage());
            }
        %>
    </body>
</html>
