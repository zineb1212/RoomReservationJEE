package com.reservation.controller;

import com.reservation.model.Room;
import com.reservation.service.RoomService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import com.reservation.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    @EJB
    private RoomService roomService;

    @EJB
    private com.reservation.service.ReservationService reservationService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String action = req.getParameter("action");
        if ((action != null) && (user.getRole() == User.Role.ADMIN)) {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("/WEB-INF/views/room_form.jsp").forward(req, resp);
                    return;
                case "edit":
                    Long id = Long.parseLong(req.getParameter("id"));
                    Room room = roomService.findById(id);
                    req.setAttribute("room", room);
                    req.getRequestDispatcher("/WEB-INF/views/room_form.jsp").forward(req, resp);
                    return;
                case "delete":
                    Long deleteId = Long.parseLong(req.getParameter("id"));
                    roomService.deleteRoom(deleteId);
                    resp.sendRedirect(req.getContextPath() + "/rooms");
                    return;
            }
        }

        // Always list all rooms
        List<Room> rooms = roomService.getAllRooms();

        String startStr = req.getParameter("startTime");
        String endStr = req.getParameter("endTime");
        String capStr = req.getParameter("capacity");
        String dateStr = req.getParameter("date");

        if (dateStr == null || dateStr.isEmpty()) {
            // Default to Today
            dateStr = java.time.LocalDate.now().toString();
        }

        // Pass params back to view (including the calculated default date)
        req.setAttribute("filterStart", startStr);
        req.setAttribute("filterEnd", endStr);
        req.setAttribute("filterCapacity", capStr);
        req.setAttribute("filterDate", dateStr);

        // Always fetch reservations for the selected or default date
        java.time.LocalDate date = java.time.LocalDate.parse(dateStr);
        List<com.reservation.model.Reservation> dailyReservations = reservationService.getReservationsByDate(date);
        req.setAttribute("dailyReservations", dailyReservations);

        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("/WEB-INF/views/rooms.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || user.getRole() != User.Role.ADMIN) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        int capacity = Integer.parseInt(req.getParameter("capacity"));
        String description = req.getParameter("description");

        Room room;
        if (idStr != null && !idStr.isEmpty()) {
            room = roomService.findById(Long.parseLong(idStr));
        } else {
            room = new Room();
        }

        room.setName(name);
        room.setCapacity(capacity);
        room.setDescription(description);

        if (room.getId() == null) {
            roomService.createRoom(room);
        } else {
            roomService.updateRoom(room);
        }

        resp.sendRedirect(req.getContextPath() + "/rooms");
    }
}
