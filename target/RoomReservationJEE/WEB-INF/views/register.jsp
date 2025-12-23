<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Register</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <div class="container">
            <div class="card" style="max-width: 400px; margin: 50px auto;">
                <h2>Register</h2>
                <form action="${pageContext.request.contextPath}/auth/register" method="post">
                    <label>Username</label>
                    <input type="text" name="username" required>
                    <label>Password</label>
                    <input type="password" name="password" required>
                    <button type="submit" class="button">Register</button>
                </form>
                <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login</a></p>
            </div>
        </div>
    </body>

    </html>