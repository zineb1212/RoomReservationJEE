<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>${room != null ? 'Edit Room' : 'New Room'}</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <h2>${room != null ? 'Edit Room' : 'New Room'}</h2>

                <div class="card" style="max-width: 600px; margin: 50px auto;">
                    <h2 style="margin-bottom: 1.5rem;">${room != null ? 'Edit Room' : 'Create New Room'}</h2>

                    <form action="${pageContext.request.contextPath}/rooms" method="post">
                        <c:if test="${room != null}">
                            <input type="hidden" name="id" value="${room.id}">
                        </c:if>

                        <div class="form-group">
                            <label class="text-sm">Room Name</label>
                            <input type="text" name="name" class="form-input" value="${room.name}" required
                                placeholder="e.g. Conference Room A">
                        </div>

                        <div class="form-group">
                            <label class="text-sm">Capacity</label>
                            <input type="number" name="capacity" class="form-input" value="${room.capacity}" required
                                placeholder="e.g. 10">
                        </div>

                        <div class="form-group">
                            <label class="text-sm">Description</label>
                            <textarea name="description" class="form-input" rows="4"
                                placeholder="Room amenities...">${room.description}</textarea>
                        </div>

                        <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </body>

        </html>