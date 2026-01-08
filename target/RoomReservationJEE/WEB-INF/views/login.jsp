<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html>

        <head>
            <title>Login</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <div class="card" style="max-width: 400px; margin: 100px auto; padding: 2.5rem;">
                    <div style="text-align: center; margin-bottom: 2rem;">
                        <h1 style="color: var(--primary); margin-bottom: 0.5rem;">RoomRes</h1>
                        <h2 style="font-size: 1.5rem;">Welcome Back</h2>
                        <p class="text-muted">Enter your credentials to access your account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div
                            style="background-color: var(--danger-bg); color: var(--danger); padding: 0.75rem; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.9rem;">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth/login" method="post">
                        <div class="form-group">
                            <label class="text-sm">Username</label>
                            <input type="text" name="username" class="form-input" required placeholder="Enter username">
                        </div>
                        <div class="form-group">
                            <label class="text-sm">Password</label>
                            <input type="password" name="password" class="form-input" required placeholder="••••••••">
                        </div>
                        <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">Sign In</button>
                    </form>

                    <div style="text-align: center; margin-top: 1.5rem;" class="text-sm text-muted">
                        Don't have an account? <a href="${pageContext.request.contextPath}/auth/register"
                            style="color: var(--primary); font-weight: 600;">create one</a>
                    </div>
                </div>
            </div>
        </body>

        </html>