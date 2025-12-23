# Room Reservation System (JEE)

This is a Mini-Project for a Room Reservation System built with Jakarta EE (JEE) 10.

## Technologies
- **Presentation**: JSP, Servlets, JSTL
- **Business Logic**: EJB (Stateless Session Beans)
- **Persistence**: JPA (Hibernate), H2 Database (In-memory/Embedded)
- **Build**: Maven

## Architecture
- `com.reservation.model`: JPA Entities (User, Room, Reservation)
- `com.reservation.service`: EJB Services (Business Logic, Transaction Management)
- `com.reservation.controller`: Servlets (HTTP Request Handling)

## Prerequisites
- Java JDK 17+
- Maven 3.8+
- Application Server (WildFly 27+)

## How to Build
Run the following command in the project root:
```sh
mvn clean package
```
This will generate `target/RoomReservationJEE.war`.

## How to Deploy
1. Start your Application Server (e.g., WildFly).
2. Copy `target/RoomReservationJEE.war` to the deployment directory (e.g., `standalone/deployments/` for WildFly).
3. Access the application at `http://localhost:8080/RoomReservationJEE`.

## Default Configuration
- **Database**: H2 In-Memory (`jdbc:h2:mem:roomreservation`). Data is lost on restart.
- **Persistence Unit**: `RoomReservationPU` configured in `src/main/resources/META-INF/persistence.xml`.

## Usage
1. **Register**: Create a new account at `/auth/register`.
2. **Login**: Use your credentials.
3. **Admin**: No default admin is seeded. You can manually insert an ADMIN user in the DB or modify `AuthServlet` to seed one.
4. **Book**: Navigate to 'Rooms', select a room, and choose start/end times.

## Conflict logic
The system prevents booking if:
`(NewStart < ExistingEnd) AND (NewEnd > ExistingStart)`
