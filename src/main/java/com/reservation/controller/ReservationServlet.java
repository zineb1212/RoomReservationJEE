package com.reservation.controller;

import com.reservation.model.Reservation;
import com.reservation.model.Room;
import com.reservation.model.User;
import com.reservation.service.ReservationService;
import com.reservation.service.RoomService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/reservations/*")
public class ReservationServlet extends HttpServlet {

    @EJB
    private ReservationService reservationService;

    @EJB
    private RoomService roomService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/book".equals(path)) {
            if (user.getRole() == User.Role.ADMIN) {
                // Admins cannot book
                resp.sendRedirect(req.getContextPath() + "/rooms");
                return;
            }
            // Show booking form for a specific room
            String roomId = req.getParameter("roomId");
            Room room = roomService.findById(Long.parseLong(roomId));
            req.setAttribute("room", room);
            req.getRequestDispatcher("/WEB-INF/views/reservation_form.jsp").forward(req, resp);
        } else {
            String action = req.getParameter("action");
            if ("cancel".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                Reservation res = reservationService.findById(id);
                if (res != null) {
                    // Check logic: Admin or Owner
                    if (user.getRole() == User.Role.ADMIN || res.getUser().getId().equals(user.getId())) {
                        reservationService.cancelReservation(id);
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/rooms");
                return;
            } else if ("edit".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                Reservation res = reservationService.findByIdWithDetails(id);
                // Security check
                if (res != null && (user.getRole() == User.Role.ADMIN || res.getUser().getId().equals(user.getId()))) {
                    req.setAttribute("reservation", res);
                    req.setAttribute("room", res.getRoom());
                    req.getRequestDispatcher("/WEB-INF/views/reservation_form.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/reservations");
                }
                return;
            }

            // List user reservations
            List<Reservation> reservations;
            if (user.getRole() == User.Role.ADMIN) {
                reservations = reservationService.getAllReservations();
            } else {
                reservations = reservationService.getUserReservations(user.getId());
            }
            req.setAttribute("reservations", reservations);
            req.getRequestDispatcher("/WEB-INF/views/reservations.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        try {
            Long roomId = Long.parseLong(req.getParameter("roomId"));
            String startStr = req.getParameter("startTime");
            String endStr = req.getParameter("endTime");

            LocalDateTime start = LocalDateTime.parse(startStr);
            LocalDateTime end = LocalDateTime.parse(endStr);

            if (start.isBefore(LocalDateTime.now())) {
                throw new Exception("Cannot book in the past");
            }

            if (end.isBefore(start)) {
                throw new Exception("End time must be after start time");
            }

            String idStr = req.getParameter("id");
            Reservation res;

            if (idStr != null && !idStr.isEmpty()) {
                // Update
                Long id = Long.parseLong(idStr);
                res = reservationService.findById(id);
                // Security check
                if (res == null || (user.getRole() != User.Role.ADMIN && !res.getUser().getId().equals(user.getId()))) {
                    throw new Exception("Unauthorized to edit");
                }
                // Update fields
                res.setStartTime(start);
                res.setEndTime(end);
                // Note: Room assumed unchanged for simple edit, otherwise need to handle room
                // change too.
                // For now, we assume editing dates for the same room as per UI flow.

                reservationService.updateReservation(res);
            } else {
                // Create
                if (user.getRole() == User.Role.ADMIN) {
                    throw new Exception("Admins cannot make reservations.");
                }
                Room room = roomService.findById(roomId);
                res = new Reservation();
                res.setRoom(room);
                res.setUser(user);
                res.setStartTime(start);
                res.setEndTime(end);

                reservationService.makeReservation(res);
            }

            resp.sendRedirect(req.getContextPath() + "/rooms?success=true");

        } catch (Exception e) {
            String errorMessage = URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/rooms?error=" + errorMessage);
        }
    }
}
