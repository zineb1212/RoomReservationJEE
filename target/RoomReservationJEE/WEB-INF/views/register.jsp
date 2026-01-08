<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Register</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <div class="container">
            <div class="card" style="max-width: 400px; margin: 100px auto; padding: 2.5rem;">
                <div style="text-align: center; margin-bottom: 2rem;">
                    <h1 style="color: var(--primary); margin-bottom: 0.5rem;">RoomRes</h1>
                    <h2 style="font-size: 1.5rem;">Create Account</h2>
                </div>

                <form action="${pageContext.request.contextPath}/auth/register" method="post">
                    <div class="form-group">
                        <label class="text-sm">Username</label>
                        <input type="text" name="username" class="form-input" required placeholder="Choose a username">
                    </div>
                    <div class="form-group">
                        <label class="text-sm">Password</label>
                        <input type="password" name="password" class="form-input" required
                            placeholder="Choose a password">
                    </div>
                    <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">Sign Up</button>
                </form>

                <div style="text-align: center; margin-top: 1.5rem;" class="text-sm text-muted">
                    Already have an account? <a href="${pageContext.request.contextPath}/auth/login"
                        style="color: var(--primary); font-weight: 600;">Sign in</a>
                </div>
            </div>
        </div>
    </body>

    </html>