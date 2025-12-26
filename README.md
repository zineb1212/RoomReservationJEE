# Room Reservation System (JEE)

Welcome! This is a **Room Reservation System** built with **Java Enterprise Edition (JEE) 10**.
It allows users to search for available rooms, check schedules, and manage bookings with a modern, responsive interface.

## 🚀 Features
- **Modern UI**: Clean, responsive design with an Indigo/Blue theme.
- **Availability Search**: Filter rooms by **Date**, **Time Range**, and **Capacity**.
- **Real-time Status**: Instantly see if a room is **✅ Available** or **❌ Occupied** for your selected time.
- **Schedule View**: View the daily schedule of occupied slots for every room.
- **Admin Dashboard**: Manage rooms (Create, Edit, Delete).
- **Reservation Management**: Users can Book, Cancel, and Edit their own reservations.

---

## 🛠️ Prerequisites
Before running this project, ensure you have the following installed on your PC:
1.  **Java JDK 17** (or higher).
2.  **Maven 3.8+** (for building the project).
3.  **Application Server**: A Jakarta EE 10 compatible server.
    -   Recommended: **WildFly 27+** (or newer).

---

## 📦 How to Run

### Step 1: Build the Project
Open a terminal (Command Prompt or PowerShell) in the project folder and run:
```sh
mvn clean package
```
*Success?* You should see `BUILD SUCCESS` and a file named `RoomReservationJEE.war` inside the `target/` folder.

### Step 2: Start the Server
1.  Navigate to your WildFly server folder.
2.  Run the startup script:
    -   **Windows**: `bin\standalone.bat`
    -   **Mac/Linux**: `bin/standalone.sh`

### Step 3: Deploy
1.  Copy the generated `target/RoomReservationJEE.war` file.
2.  Paste it into the `standalone/deployments/` folder inside your WildFly directory.
3.  The server will automatically detect and deploy it.

### Step 4: Access the App
Open your browser and go to:
👉 **[http://localhost:8080/RoomReservationJEE](http://localhost:8080/RoomReservationJEE)**

---

## 🔑 Login Credentials

The database is pre-loaded with sample users and rooms.

### Admin Account
- **Username**: `admin`
- **Password**: `admin`
- *Access*: Can manage rooms and see all reservations.

### User Account
- **Username**: `user`
- **Password**: `user`
- *Access*: Can search and book rooms.

---

## ⚙️ Configuration
The application is pre-configured to use the **WildFly Default DataSource**.
- **DataSource JNDI**: `java:jboss/datasources/ExampleDS` (H2 Database).
- **Persistence Unit**: `RoomReservationPU`.
- **Note**: Ensure your WildFly instance has the `ExampleDS` enabled (it is enabled by default in `standalone.xml`).

---

## 🧩 Architecture
- **Frontend**: JSP, JSTL, CSS3 (Modern Design).
- **Backend**: Jakarta Servlets, EJB (Stateless).
- **Database**: H2 In-Memory (Data resets when server stops).
- **Persistence**: Hibernate (JPA).
