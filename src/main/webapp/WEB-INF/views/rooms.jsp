<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html>

        <head>
            <title>Available Rooms</title>
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
                <h2>Available Rooms</h2>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/rooms?action=new" class="button">Add New Room</a>
                </c:if>
                <div class="card">
                    <h3>Check Availability</h3>
                    <form action="${pageContext.request.contextPath}/rooms" method="get">
                        <label>Date:</label>
                        <input type="date" name="date" value="${filterDate}">

                        <label>Start Time (Optional):</label>
                        <input type="datetime-local" name="startTime" value="${param.startTime}">

                        <label>End Time (Optional):</label>
                        <input type="datetime-local" name="endTime" value="${param.endTime}">

                        <label>Min Capacity:</label>
                        <input type="number" name="capacity" value="${param.capacity}">

                        <button type="submit" class="button">Search</button>
                        <a href="${pageContext.request.contextPath}/rooms" class="button btn-secondary">Clear</a>
                    </form>
                </div>

                <c:if test="${empty rooms}">
                    <p>No rooms available. Please contact admin to add rooms.</p>
                </c:if>
                <table>
                    <thead>
                        <tr>
                            <th>Room Name</th>
                            <th>Capacity</th>
                            <th>Description</th>
                            <th>Status (${filterDate})</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="room" items="${rooms}">
                            <tr>
                                <td>${room.name}</td>
                                <td>${room.capacity}</td>
                                <td>${room.description}</td>
                                <td>
                                    <c:set var="isOccupied" value="false" />
                                    <c:set var="conflictFound" value="false" />

                                    <%-- Direct Availability Check if Time Provided --%>
                                        <c:if test="${not empty filterStart and not empty filterEnd}">
                                            <c:forEach var="res" items="${dailyReservations}">
                                                <c:if test="${res.room.id == room.id}">
                                                    <% String startStr=(String) request.getAttribute("filterStart");
                                                        String endStr=(String) request.getAttribute("filterEnd");
                                                        java.time.LocalDateTime
                                                        userStart=java.time.LocalDateTime.parse(startStr);
                                                        java.time.LocalDateTime
                                                        userEnd=java.time.LocalDateTime.parse(endStr);
                                                        com.reservation.model.Reservation
                                                        r=(com.reservation.model.Reservation)
                                                        pageContext.getAttribute("res"); if
                                                        (r.getStartTime().isBefore(userEnd) &&
                                                        r.getEndTime().isAfter(userStart)) { %>
                                                        <c:set var="conflictFound" value="true" />
                                                        <% } %>
                                                </c:if>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${conflictFound}">
                                                    <span style="color: red; font-weight: bold;">&#10060; Occupée</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: green; font-weight: bold;">&#9989;
                                                        Disponible</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <br><small>Schedule:</small>
                                        </c:if>

                                        <%-- Always show schedule --%>
                                            <ul style="list-style: none; padding: 0;">
                                                <c:forEach var="res" items="${dailyReservations}">
                                                    <c:if test="${res.room.id == room.id}">
                                                        <li style="color: red;">Occupied: ${res.startTime.toLocalTime()}
                                                            - ${res.endTime.toLocalTime()}</li>
                                                        <c:set var="isOccupied" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${not isOccupied}">
                                                    <li style="color: green;">Available all day</li>
                                                </c:if>
                                            </ul>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/reservations/book?roomId=${room.id}"
                                        class="button">Book</a>
                                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                        <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                                            class="button">Edit</a>
                                        <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                                            class="button" onclick="return confirm('Are you sure?')">Delete</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>