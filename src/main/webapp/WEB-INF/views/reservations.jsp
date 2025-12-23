<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html>

        <head>
            <title>My Reservations</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <header>
                <div class="container">
                    <div id="branding">
                        <h1>RoomRes</h1>
                    </div>
                    <nav>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/rooms">Rooms</a></li>
                            <li><a href="${pageContext.request.contextPath}/reservations">My Reservations</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </header>
            <div class="container">
                <h2>Reservations</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Room</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <th>User</th>
                            </c:if>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="res" items="${reservations}">
                            <tr>
                                <td>${res.room.name}</td>
                                <td>${res.startTime}</td>
                                <td>${res.endTime}</td>
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <td>${res.user.username}</td>
                                </c:if>
                                <td>
                                    <a href="${pageContext.request.contextPath}/reservations?action=edit&id=${res.id}"
                                        class="button">Edit</a>
                                    <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                        class="button" onclick="return confirm('Cancel this reservation?')">Cancel</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>