<!-- viewContacts.jsp -->
<html>
<head>
    <title>Contact List</title>
</head>
<body>
    <h2>Contact List</h2>
    <style>
    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
    th {
        font-size: 16px;
        text-transform: uppercase;
    }
    td {
        font-size: 14px;
    }
    a{ 
    display: block;
       
        text-align: center;
    }
</style>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>



        <%-- Iterate through the contacts using a loop provided by the servlet --%>
        <%@ page import="java.sql.*" %>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contactdb?user=postgres&password=root");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM contacts");
                while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="editContact.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
                        <a href="ContactServlet?action=delete&id=<%= rs.getInt("id") %>">Delete</a>
                    </td>
                </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    <a href="addContact.jsp">Add New Contact</a>
</body>
</html>

