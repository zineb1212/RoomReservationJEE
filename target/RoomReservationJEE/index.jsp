<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Room Reservation System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                /* Landing Page Specific Overrides */
                body {
                    background-color: white;
                    /* Image shows pure white background for hero */
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                /* Header Overrides for Landing layout */
                header {
                    background: white;
                    box-shadow: none;
                    /* Cleaner look as per image, maybe verify if border needed */
                    border-bottom: 1px solid #f3f4f6;
                    padding: 1rem 3rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .brand {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary);
                    text-decoration: none;
                }

                .nav-links {
                    display: flex;
                    align-items: center;
                    gap: 1.5rem;
                }

                .nav-link {
                    color: var(--gray-500);
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 0.95rem;
                }

                .nav-link:hover {
                    color: var(--gray-800);
                }

                /* Hero Section */
                .hero {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    text-align: center;
                    padding: 2rem;
                    margin-top: -50px;
                    /* Slight offset to optical center */
                }

                .hero h1 {
                    font-size: 3.5rem;
                    line-height: 1.1;
                    margin-bottom: 1.5rem;
                    color: black;
                    font-weight: 800;
                }

                .hero p {
                    font-size: 1.25rem;
                    color: var(--gray-500);
                    margin-bottom: 2.5rem;
                }

                .btn-lg {
                    padding: 0.75rem 2rem;
                    font-size: 1rem;
                    border-radius: 8px;
                    width: fit-content;
                }
            </style>
        </head>

        <body>

            <!-- Header -->
            <header>
                <a href="${pageContext.request.contextPath}/" class="brand">RoomRes</a>

                <nav class="nav-links">
                    <a href="${pageContext.request.contextPath}/" class="nav-link"
                        style="color: var(--gray-800);">Home</a>

                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary">Dashboard</a>
                            <a href="${pageContext.request.contextPath}/auth/logout"
                                class="btn btn-secondary">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-secondary"
                                style="border: 1px solid var(--gray-200);">Login</a>
                            <a href="${pageContext.request.contextPath}/auth/register"
                                class="btn btn-primary">Register</a>
                        </c:otherwise>
                    </c:choose>
                </nav>
            </header>

            <!-- Main Content -->
            <main class="hero">
                <h1>Welcome to Room<br>Reservation System</h1>
                <p>Book your meeting rooms efficiently.</p>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-primary btn-lg">Go to
                            Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary btn-lg">Login to
                            Start</a>
                    </c:otherwise>
                </c:choose>
            </main>

        </body>

        </html>