<%-- 
    Document   : calc1
    Created on : Sep 13, 2022, 5:22:30 PM
    Author     : Sabarinathan R V
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registered Courses</title>
        <style>
            body,html
            {
                background-image: url('https://img.freepik.com/free-vector/white-abstract-background-design_23-2148825582.jpg?w=900&t=st=1663186262~exp=1663186862~hmac=b0bbb760ee5cadf3b01b5fac8bf45ed0eb20c47f8caf659f5d6169e78730824c');
                background-size: 100%;
            }
            .out
            {
                margin: 60px;
                padding-left: 65px;
                padding-top:20px;
                padding-bottom: 300px;
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
        <%@page import="java.sql.*"%>
        <%@page import="java.math.*"%>
        <%@page import="java.io.*"%>
        <br>
        <%
            out.println("<h1><center>Student Registration Details</center></h1>");
            try
            {
                //for db connection
                String username = "xyz";
                String password = "abc";
                String URL = "jdbc:mysql://localhost:3306/javatables";

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connect = DriverManager.getConnection(URL,username,password);
                Statement stmt = connect.createStatement();

                String name = request.getParameter("sname");
                String id = request.getParameter("sid");
                String compiler_design = request.getParameter("CSI2005");
                String java = request.getParameter("CSI2008");
                String cloud = request.getParameter("CSI3001");
                String crypt = request.getParameter("CSI3002");
                String advjava = request.getParameter("CSI3018");
                String cyber = request.getParameter("CSI3022");
                String english = request.getParameter("ENG1000");
                String spanish = request.getParameter("ESP1001");
                String psychology = request.getParameter("HUM1022");
                String pred = request.getParameter("MDI3003");

                int j = 0;
                int k = 0;
                int selection = 0;
                int sum = 0;

                String subjects[] = {compiler_design,java,cloud,crypt,advjava,cyber,english,spanish,psychology,pred};
                int credit_array[] = {3,4,3,4,3,4,2,2,3,4};
                
                String selected_subjects[] = new String[60];
                int credit_arr[] = new int[20];
                
                for(int i = 0; i<10;i++)
                {
                    if(subjects[i]!=null)
                    {
                        selection++;
                        selected_subjects[j++] = subjects[i];
                        credit_arr[k++] = credit_array[i];
                    }
                }
                
                
                String query = "INSERT INTO registered_courses(regno,course_name) VALUES(?,?);";
                
                PreparedStatement pstmt1 = connect.prepareStatement(query);
                 for(int i=0;i<selection;i++)
                {
                    pstmt1.setString(1,id);
                    pstmt1.setString(2, selected_subjects[i]);
                    pstmt1.executeUpdate();
                }
                
                
                
                for(int i=0;i<=selection;i++)
                {
                    int credits;
                    ResultSet res = stmt.executeQuery("SELECT credits FROM course_table WHERE course_name='"+selected_subjects[i]+"';");
                    while(res.next())
                    {   
                        credits = res.getInt(1);
                        sum = sum + credits;
                    }   
                }
                
                if(sum<16)
                {
                    out.println("<h3><center>"+name+", you have to register "+(16-sum)+" more credits to qualify</center></h3>");
                    out.println("<a href='index.html'><center>Home Page</center></a>");
                }
                else if(sum>26)
                {
                    out.println("<h3><center>MAXIMUM CREDITS IS 26</center></h3>");
                    out.println("<h3><center>"+name+", you have registered "+(sum-26)+" than the limit</center></h3>");
                    out.println("<a href='index.html'><center>Home Page</a></center>");
                }
                else
                {
                    out.println("<h2><center>Registered Successfully</center></h2>");
        
                    String query1 = "INSERT INTO student(regno,student_name,total_cred,total_courses) values (?,?,?,?)";
                    PreparedStatement pstmt = connect.prepareStatement(query1);
                    pstmt.setString(1,id);
                    pstmt.setString(2,name);
                    pstmt.setInt(3, sum);
                    pstmt.setInt(4,selection);
                    pstmt.executeUpdate();
                    
                    ResultSet res1 = stmt.executeQuery("SELECT * FROM student WHERE regno='"+id+"';");
                    
                    while(res1.next())
                    {
                        String s_id = res1.getString(1);
                        String S_name = res1.getString(2);
                        int s_cred = res1.getInt(3);
                        int s_course = res1.getInt(4);
                        %>
                        <center>
                        <table>
                            <tr>
                                <th>Student Register Number</th>
                                <td><%out.println(s_id);%></td>
                            </tr>
                            <tr>
                                <th>Student Name</th>
                                <td><%out.println(S_name);%></td>
                            </tr>
                            <tr>
                                <th>Total Credits Registered</th>
                                <td><%out.println(s_cred);%></td>
                            </tr>
                            <tr>
                                <th>Total courses registered</th>
                                <td><%out.println(s_course);%></td>
                            </tr>
                        </table>
                        </center>

                            <h2> <center>Registered courses</center></h2>
                        <center>
                        <table>
                            <tr>
                                <th>List of Courses</th>
                                <th>Credits</th>
                            </tr>
                            <tr>
                                <%
                                    for (int i=0;i<selection;i++)
                                    { 
                                %>
                                <td><%out.println(selected_subjects[i]);%></td>
                                <td><%out.println(credit_arr[i]);%></td>
                                
                            </tr>
                            <%}%>
                        </table>
                        </center>
            <%
                    }
                    out.println("<br><a href='index.html'><center>Home Page</a></center>");
                }
            }
            catch(Exception e)
            {
                out.println("exception:"+e.getMessage());
            }
        %>
    </body>
</html>
