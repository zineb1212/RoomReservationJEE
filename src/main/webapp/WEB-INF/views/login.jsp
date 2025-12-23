<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html>

        <head>
            <title>Login</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <div class="card" style="max-width: 400px; margin: 50px auto;">
                    <h2>Login</h2>
                    <c:if test="${not empty error}">
                        <p class="error">${error}</p>
                    </c:if>
                    <c:if test="${not empty message}">
                        <p class="success">${message}</p>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/auth/login" method="post">
                        <label>Username</label>
                        <input type="text" name="username" required>
                        <label>Password</label>
                        <input type="password" name="password" required>
                        <button type="submit" class="button">Login</button>
                    </form>
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register">Register</a>
                    </p>
                </div>
            </div>
        </body>

        </html>