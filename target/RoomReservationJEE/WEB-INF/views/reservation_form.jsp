<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>${reservation != null ? 'Edit Reservation' : 'Book Room'} - RoomRes</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body {
                        background-color: #f3f4f6;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .main-container {
                        flex: 1;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 2rem;
                    }

                    .auth-card {
                        background: white;
                        padding: 2.5rem;
                        border-radius: 16px;
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                        width: 100%;
                        max-width: 500px;
                    }

                    .auth-header {
                        text-align: center;
                        margin-bottom: 2rem;
                    }

                    .auth-header h2 {
                        font-size: 1.5rem;
                        color: var(--gray-900);
                        margin-bottom: 0.5rem;
                    }

                    .room-info-badge {
                        background: #e0e7ff;
                        color: var(--primary);
                        padding: 0.5rem 1rem;
                        border-radius: 9999px;
                        font-weight: 600;
                        display: inline-block;
                        margin-bottom: 1.5rem;
                        font-size: 0.875rem;
                    }
                </style>
            </head>

            <body>

                <!-- Simple Header -->
                <header style="background: white; border-bottom: 1px solid #e5e7eb; padding: 1rem 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <a href="${pageContext.request.contextPath}/rooms"
                            style="font-weight: 700; font-size: 1.25rem; color: var(--primary); text-decoration: none;">RoomRes</a>
                        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">Back to
                            Dashboard</a>
                    </div>
                </header>

                <div class="main-container">
                    <div class="auth-card">
                        <div class="auth-header">
                            <div><span class="room-info-badge">&#128682; ${room.name}</span></div>
                            <h2>${reservation != null ? 'Reschedule Booking' : 'New Reservation'}</h2>
                            <p class="text-muted text-sm">Update your reservation details below.</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div
                                style="background: #fee2e2; border: 1px solid #ef4444; color: #b91c1c; padding: 0.75rem; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.875rem;">
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/reservations" method="post">
                            <input type="hidden" name="roomId" value="${room.id}">
                            <c:if test="${reservation != null}">
                                <input type="hidden" name="id" value="${reservation.id}">
                            </c:if>

                            <div class="form-group">
                                <label class="form-label">Start Date & Time</label>
                                <input type="datetime-local" name="startTime" class="form-input"
                                    value="${reservation != null ? reservation.startTime : ''}" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">End Date & Time</label>
                                <input type="datetime-local" name="endTime" class="form-input"
                                    value="${reservation != null ? reservation.endTime : ''}" required>
                                <p class="text-muted text-sm" style="margin-top: 0.5rem;">Max duration: 3 hours</p>
                            </div>

                            <div style="margin-top: 2rem;">
                                <button type="submit" class="btn btn-primary" style="width: 100%;">
                                    ${reservation != null ? 'Save Changes' : 'Confirm Booking'}
                                </button>
                                <c:if test="${reservation != null}">
                                    <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary"
                                        style="width: 100%; margin-top: 0.75rem; text-align: center; display: block;">Cancel</a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>

            </body>

            </html>