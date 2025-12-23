<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html>

        <head>
            <title>Book Room</title>
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
                <div class="card">
                    <h2>${reservation != null ? 'Edit Reservation' : 'Book Room'}: ${room.name}</h2>
                    <c:if test="${not empty error}">
                        <p class="error">${error}</p>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/reservations" method="post">
                        <input type="hidden" name="roomId" value="${room.id}">
                        <c:if test="${reservation != null}">
                            <input type="hidden" name="id" value="${reservation.id}">
                        </c:if>

                        <label>Start Time</label>
                        <input type="datetime-local" name="startTime"
                            value="${reservation != null ? reservation.startTime : ''}" required>

                        <label>End Time</label>
                        <input type="datetime-local" name="endTime"
                            value="${reservation != null ? reservation.endTime : ''}" required>

                        <button type="submit" class="button">${reservation != null ? 'Update' : 'Confirm'}
                            Booking</button>
                    </form>
                </div>
            </div>
        </body>

        </html>