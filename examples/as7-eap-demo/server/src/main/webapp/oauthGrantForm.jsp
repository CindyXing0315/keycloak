<%@ page import="org.picketlink.idm.model.*,org.keycloak.services.models.*,org.keycloak.services.resources.*,javax.ws.rs.core.*,java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%
        RealmModel realm = (RealmModel)request.getAttribute(RealmModel.class.getName());
        String username = (String)request.getAttribute("username");
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Keycloak</title>

    <link rel="shortcut icon" type="image/x-icon" href="<%=application.getContextPath()%>/img/favicon.ico">

    <link href="<%=application.getContextPath()%>/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="<%=application.getContextPath()%>/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="<%=application.getContextPath()%>/css/reset.css" rel="stylesheet">
    <link href="<%=application.getContextPath()%>/css/base.css" rel="stylesheet">
</head>

<body>

<%
    User client = (User)request.getAttribute("client");
    List<Role> realmRolesRequested = (List<Role>)request.getAttribute("realmRolesRequested");
    MultivaluedMap<String, Role> resourceRolesRequested = (MultivaluedMap<String, Role>)request.getAttribute("resourceRolesRequested");
%>

    <h1>Grant request for: <%=client.getLoginName()%></h1>
<div class="modal-body">


    <p>This app would like to:</p>
    <hr/>
    <%
    if (realmRolesRequested.size() > 0) {
       %> <ul> <%
       for (Role role : realmRolesRequested) {
          String desc = "Have " + role.getName() + " privileges.";
          Attribute roleDesc = role.getAttribute("description");
          if (roleDesc != null) {
             desc = (String)roleDesc.getValue();
          }
          %>
          <li><%=desc%></li>
          <%
       }
       %> </ul> <%
    }
    for (String resource : resourceRolesRequested.keySet()) {
       List<Role> roles = resourceRolesRequested.get(resource);
       out.println("<i>For application " + resource + ":</i> ");
       out.println("<ul>");
       for (Role role : roles) {
          String desc = "Have " + role.getName() + " privileges.";
          Attribute roleDesc = role.getAttribute("description");
          if (roleDesc != null) {
             desc = (String)roleDesc.getValue();
          }
          out.println("<li>" + desc + "</li>");
       }
       out.println("</ul>");
    }
    %>
    <hr/>


    <form class="form-horizontal" name="oauthGrant" action="<%=request.getAttribute("action")%>" method="POST">
       <input type="hidden" name="code" value="<%=request.getAttribute("code")%>">
        <div class="control-group">
            <div class="controls">
                <input type="submit" name="accept" class="btn btn-primary" value="Accept">
                <input type="submit" name="cancel" class="btn btn-primary" value="Cancel">
            </div>
        </div>
    </form>
</div>
<footer>
  <p>Powered By Keycloak</p>
</body>
</html>
