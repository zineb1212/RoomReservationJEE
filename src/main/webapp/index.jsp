<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Room Reservation System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Room</span>Res</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li><a href="${pageContext.request.contextPath}/rooms">Rooms</a></li>
                            <li><a href="${pageContext.request.contextPath}/reservations">My Reservations</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout (${sessionScope.user.username})</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/auth/login">Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth/register">Register</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="card">
            <h2>Welcome to Room Reservation System</h2>
            <p>Book your meeting rooms efficiently.</p>
            <c:if test="${sessionScope.user == null}">
                <a href="${pageContext.request.contextPath}/auth/login" class="button">Login to Start</a>
            </c:if>
        </div>
    </div>
</body>
</html>
