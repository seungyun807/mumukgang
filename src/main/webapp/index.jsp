<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:if test="${not empty sessionScope.email}">
 	<jsp:forward page="/findchannel"/>
 </c:if>
<jsp:forward page="/intro"/>