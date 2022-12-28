<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <title>Save Customer</title>
   <link type="text/css"
       rel="stylesheet"
       href="${pageContext.request.contextPath}/resources/css/style.css">
   <link type="text/css"
       rel="stylesheet"
       href="${pageContext.request.contextPath}/resources/css/add-customer-style.css">
</head>
<body>
   
   <div id="wrapper">
      <div id="header">
         <h2>Customer Management</h2>
      </div>
   </div>
   <div id="container">
      <h3>Save Customer</h3>
      <!-- modelAttribute  = class -->   
      <form:form action="saveCustomer" modelAttribute="customer" method="GET"> 
      <form:hidden path="id"/>
      <form:input type ="hidden" path= "id" />
         <table>
            <tbody>
               <tr>
                  <td><label>First name:</label></td>
                  <td><form:input path="firstName" /></td>
               </tr>
            
               <tr>
                  <td><label>Last name:</label></td>
                  <td><form:input path="lastName" /></td>
               </tr>
               <tr>
                  <td><label>Email:</label></td>
                  <td><form:input path="email" /></td>
               </tr>
               <tr>
                  <td><label></label></td>

                  <c:if test="${customer.id eq 0}">
                  		<td><input type="submit" value="Save" class ="save"/></td>
                  </c:if>
                   <c:if test="${customer.id ne 0}">
                  		<td><input type="submit" value="Upate"/></td>
                  </c:if>
               </tr>
            </tbody>
         </table>
      </form:form>
   
      <div style="clear; both;"></div>
      <p>
         <a href="${pageContext.request.contextPath}/customer/list">Back to List</a>
      </p>
   </div>
</body>
</html>