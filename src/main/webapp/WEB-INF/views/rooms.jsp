<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Room Booking</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
            </head>

            <body>

                <!-- Header -->
                <header>
                    <div style="display: flex; align-items: center; gap: 1rem;">
                        <div style="background: var(--primary); padding: 0.5rem; border-radius: 8px;">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                            </svg>
                        </div>
                        <div>
                            <h1 style="font-size: 1.25rem;">Room Booking</h1>
                            <p class="text-muted text-sm" style="margin: 0;">Reserve meeting rooms for your team</p>
                        </div>
                    </div>
                    <nav>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-secondary"
                            style="font-size: 0.875rem;">Log Out</a>
                    </nav>
                </header>

                <!-- Main Content -->
                <c:choose>
                    <%-- ADMIN DASHBOARD --%>
                        <c:when test="${sessionScope.user.role == 'ADMIN'}">
                            <div class="dashboard-grid" style="grid-template-columns: 1fr;">

                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                                    <h1>Admin Dashboard</h1>
                                </div>

                                <!-- Stats Row -->
                                <div class="admin-stats-grid">
                                    <div class="stat-card">
                                        <div>
                                            <span class="text-muted text-sm">Total Bookings</span>
                                            <div class="stat-value">${fn:length(adminReservations)}</div>
                                            <div class="stat-change text-green">+12% from last week</div>
                                        </div>
                                    </div>
                                    <div class="stat-card">
                                        <div>
                                            <span class="text-muted text-sm">Active Rooms</span>
                                            <div class="stat-value">${fn:length(rooms)}</div>
                                            <div class="stat-change text-muted">All operational</div>
                                        </div>
                                    </div>
                                    <div class="stat-card">
                                        <div>
                                            <span class="text-muted text-sm">Scheduling Conflicts</span>
                                            <div class="stat-value">0</div>
                                            <div class="stat-change text-green">Good job!</div>
                                        </div>
                                    </div>
                                    <div class="stat-card">
                                        <div>
                                            <span class="text-muted text-sm">Utilization Rate</span>
                                            <div class="stat-value">72%</div>
                                            <div class="stat-change text-green">Above target</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- TABS CONTROLLER -->
                                <div
                                    style="background: white; border-radius: 12px; padding: 0.5rem; display: flex; gap: 1rem; border: 1px solid var(--gray-200); margin-bottom: 1.5rem;">
                                    <button class="tab-btn active" onclick="switchTab('bookings')">
                                        &#128197; Bookings
                                    </button>
                                    <button class="tab-btn" onclick="switchTab('rooms')">
                                        &#128682; Rooms
                                    </button>
                                </div>

                                <!-- TAB CONTENT: BOOKINGS -->
                                <div id="tab-bookings" class="tab-content" style="display: block;">
                                    <div class="table-wrapper">
                                        <table class="modern-table">
                                            <thead>
                                                <tr>
                                                    <th>Room</th>
                                                    <th>Date & Time</th>
                                                    <th>Booked By</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${adminReservations}">
                                                    <tr>
                                                        <td><strong>${res.room.name}</strong></td>
                                                        <td>
                                                            <div>${res.startTime.toLocalDate()}</div>
                                                            <div class="text-muted text-sm">
                                                                ${res.startTime.toLocalTime()} -
                                                                ${res.endTime.toLocalTime()}</div>
                                                        </td>
                                                        <td>
                                                            ${res.user.username}
                                                        </td>
                                                        <td>
                                                            <span class="status-pill pill-confirmed">Confirmed</span>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                                                style="color: var(--danger); font-weight: 500;"
                                                                onclick="return confirm('Cancel this reservation?')">&#10005;</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- TAB CONTENT: ROOMS -->
                                <div id="tab-rooms" class="tab-content" style="display: none;">
                                    <div style="display: flex; justify-content: flex-end; margin-bottom: 1rem;">
                                        <a href="${pageContext.request.contextPath}/rooms?action=new"
                                            class="btn btn-primary" style="width: auto;">+ New Room</a>
                                    </div>
                                    <div class="table-wrapper">
                                        <table class="modern-table">
                                            <thead>
                                                <tr>
                                                    <th>Room Name</th>
                                                    <th>Capacity</th>
                                                    <th>Description</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="room" items="${rooms}">
                                                    <tr>
                                                        <td><strong>${room.name}</strong></td>
                                                        <td>${room.capacity} people</td>
                                                        <td>${room.description}</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                                                                style="color: var(--primary); font-weight: 500; margin-right: 1rem;">Edit</a>
                                                            <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                                                                style="color: var(--danger); font-weight: 500;"
                                                                onclick="return confirm('Delete room?')">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <script>
                                    function switchTab(tabName) {
                                        // Hide all tabs
                                        document.getElementById('tab-bookings').style.display = 'none';
                                        document.getElementById('tab-rooms').style.display = 'none';

                                        // Show selected
                                        document.getElementById('tab-' + tabName).style.display = 'block';

                                        // Update buttons
                                        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
                                        event.currentTarget.classList.add('active');
                                    }
                                </script>
                                <style>
                                    .tab-btn {
                                        flex: 1;
                                        background: transparent;
                                        border: none;
                                        padding: 0.75rem;
                                        cursor: pointer;
                                        font-weight: 600;
                                        color: var(--gray-500);
                                        border-radius: 8px;
                                        transition: all 0.2s;
                                    }

                                    .tab-btn.active {
                                        background: white;
                                        color: var(--primary);
                                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                                    }

                                    .tab-btn:hover {
                                        color: var(--primary);
                                    }
                                </style>
                            </div>
                        </c:when>

                        <%-- USER DASHBOARD --%>
                            <c:otherwise>
                                <div class="dashboard-grid">

                                    <!-- Left Column: Filters -->
                                    <div class="left-panel">
                                        <div class="card">
                                            <h3>Select Date</h3>
                                            <form id="filterForm" action="${pageContext.request.contextPath}/rooms"
                                                method="get">
                                                <div class="date-selector">
                                                    <input type="date" id="dateInput" name="date" value="${filterDate}"
                                                        onchange="document.getElementById('filterForm').submit()">
                                                </div>
                                            </form>

                                            <h3 style="margin-top: 2rem;">Quick Start Time</h3>
                                            <p class="text-muted text-sm">Click to set start time</p>
                                            <div class="time-grid" id="timeGrid">
                                                <div class="time-btn" onclick="setStartTime('08:00')">08:00</div>
                                                <div class="time-btn" onclick="setStartTime('09:00')">09:00</div>
                                                <div class="time-btn" onclick="setStartTime('10:00')">10:00</div>
                                                <div class="time-btn" onclick="setStartTime('11:00')">11:00</div>
                                                <div class="time-btn" onclick="setStartTime('12:00')">12:00</div>
                                                <div class="time-btn" onclick="setStartTime('13:00')">13:00</div>
                                                <div class="time-btn" onclick="setStartTime('14:00')">14:00</div>
                                                <div class="time-btn" onclick="setStartTime('15:00')">15:00</div>
                                                <div class="time-btn" onclick="setStartTime('16:00')">16:00</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Middle Column: Create Booking -->
                                    <div class="center-panel">
                                        <div class="card" style="height: 100%;">
                                            <h3>Create Booking</h3>
                                            <c:if test="${not empty error}">
                                                <div
                                                    style="background: #fee2e2; color: #ef4444; padding: 0.5rem; border-radius: 6px; margin-bottom: 1rem;">
                                                    ${error}</div>
                                            </c:if>
                                            <c:if test="${not empty param.error}">
                                                <div
                                                    style="background: #fee2e2; color: #ef4444; padding: 0.5rem; border-radius: 6px; margin-bottom: 1rem;">
                                                    ${param.error}</div>
                                            </c:if>
                                            <c:if test="${param.success != null}">
                                                <div
                                                    style="background: #dcfce7; color: #166534; padding: 0.5rem; border-radius: 6px; margin-bottom: 1rem;">
                                                    Booking Confirmed!</div>
                                            </c:if>

                                            <div
                                                style="background: #f0fdf4; border: 1px solid #bbf7d0; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                                                <div style="font-weight: 600; color: #166534;">&#10003; Date Selected:
                                                    ${filterDate}</div>
                                                <div class="text-sm text-muted">Select a room and set time duration
                                                    below.</div>
                                            </div>

                                            <h4>Select Room</h4>
                                            <div class="rooms-grid">
                                                <c:forEach var="room" items="${rooms}">
                                                    <div class="room-card" data-id="${room.id}"
                                                        onclick="selectRoom(this, '${room.id}')">

                                                        <c:set var="hasBookings" value="false" />
                                                        <div style="margin-bottom: 0.5rem;">
                                                            <strong>${room.name}</strong>
                                                        </div>

                                                        <div class="amenities" style="margin-bottom: 0.5rem;">
                                                            <c:forEach var="res" items="${dailyReservations}">
                                                                <c:if test="${res.room.id == room.id}">
                                                                    <c:set var="hasBookings" value="true" />
                                                                    <span
                                                                        style="background: #fee2e2; color: #991b1b; padding: 2px 6px; border-radius: 4px; font-size: 0.7rem; display: block; margin-bottom: 2px;">
                                                                        Busy: ${res.startTime.toLocalTime()} -
                                                                        ${res.endTime.toLocalTime()}
                                                                    </span>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${not hasBookings}">
                                                                <span class="status-badge status-available"
                                                                    style="float: none;">Available All Day</span>
                                                            </c:if>
                                                        </div>

                                                        <div class="text-muted text-sm">
                                                            &#128100; ${room.capacity} people
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- BOOKING FORM -->
                                            <form action="${pageContext.request.contextPath}/reservations" method="post"
                                                id="bookingForm" onsubmit="return validateBooking()">
                                                <input type="hidden" name="roomId" id="selectedRoomId" required>
                                                <input type="hidden" name="startTime" id="finalStartTime">
                                                <input type="hidden" name="endTime" id="finalEndTime">

                                                <h4>Time & Details</h4>
                                                <div style="display: flex; gap: 1rem; margin-bottom: 1rem;">
                                                    <div class="form-group" style="flex: 1;">
                                                        <label class="text-sm">Start Time</label>
                                                        <input type="time" id="inputStartTime" class="form-input"
                                                            required>
                                                    </div>
                                                    <div class="form-group" style="flex: 1;">
                                                        <label class="text-sm">End Time</label>
                                                        <input type="time" id="inputEndTime" class="form-input"
                                                            required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="text-sm">Meeting Purpose</label>
                                                    <input type="text" class="form-input"
                                                        placeholder="Describe the meeting topic...">
                                                </div>

                                                <button type="submit" class="btn btn-primary">Book Room</button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Right Column: My Bookings -->
                                    <div class="right-panel">
                                        <div class="card">
                                            <h3>Your Bookings</h3>
                                            <c:if test="${empty myReservations}">
                                                <p class="text-muted text-sm">No upcoming bookings.</p>
                                            </c:if>
                                            <c:forEach var="res" items="${myReservations}">
                                                <div class="booking-item">
                                                    <div style="font-weight: 600;">${res.room.name}</div>
                                                    <div class="text-muted text-sm">&#128197;
                                                        ${res.startTime.toLocalDate()}</div>
                                                    <div class="text-muted text-sm">&#128340;
                                                        ${res.startTime.toLocalTime()} - ${res.endTime.toLocalTime()}
                                                    </div>
                                                    <div class="booking-actions">
                                                        <a href="${pageContext.request.contextPath}/reservations?action=edit&id=${res.id}"
                                                            class="edit-btn"
                                                            style="color:var(--primary); font-weight:600; font-size:0.875rem; text-decoration:none; margin-right:0.75rem;">Edit</a>
                                                        <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                                            class="btn-cancel"
                                                            onclick="return confirm('Cancel booking?')">Cancel
                                                            Booking</a>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                </div>
                            </c:otherwise>
                </c:choose>

                <script>
                    let selectedDate = "${filterDate}";

                    function setStartTime(time) {
                        document.getElementById('inputStartTime').value = time;
                        // Auto-set end time to +1 hour for convenience
                        let hour = parseInt(time.split(':')[0]);
                        let nextHour = hour + 1;
                        let nextHourStr = (nextHour < 10 ? '0' : '') + nextHour + ":00";
                        // Handle 24h wrap or limit if needed, for simplicity assumed within day
                        document.getElementById('inputEndTime').value = nextHourStr;
                    }

                    function selectRoom(card, id) {
                        document.querySelectorAll('.room-card').forEach(c => c.classList.remove('selected'));
                        card.classList.add('selected');
                        document.getElementById('selectedRoomId').value = id;
                    }

                    function validateBooking() {
                        let roomId = document.getElementById('selectedRoomId').value;
                        let startVal = document.getElementById('inputStartTime').value;
                        let endVal = document.getElementById('inputEndTime').value;

                        if (!roomId) {
                            alert("Please select a room.");
                            return false;
                        }
                        if (!startVal || !endVal) {
                            alert("Please select start and end times.");
                            return false;
                        }

                        if (endVal <= startVal) {
                            alert("End time must be after start time.");
                            return false;
                        }

                        // Combine date + time
                        document.getElementById('finalStartTime').value = selectedDate + 'T' + startVal;
                        document.getElementById('finalEndTime').value = selectedDate + 'T' + endVal;

                        return true;
                    }
                </script>

            </body>

            </html>