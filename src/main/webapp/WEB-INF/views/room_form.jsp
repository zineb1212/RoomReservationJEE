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

                <form action="${pageContext.request.contextPath}/rooms" method="post">
                    <c:if test="${room != null}">
                        <input type="hidden" name="id" value="${room.id}">
                    </c:if>

                    <div class="form-group">
                        <label for="name">Room Name:</label>
                        <input type="text" id="name" name="name" value="${room.name}" required>
                    </div>

                    <div class="form-group">
                        <label for="capacity">Capacity:</label>
                        <input type="number" id="capacity" name="capacity" value="${room.capacity}" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description">${room.description}</textarea>
                    </div>

                    <button type="submit" class="btn">Save</button>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </body>

        </html>