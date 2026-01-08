package com.reservation.service;

import com.reservation.model.Reservation;
import com.reservation.model.Room;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.time.LocalDateTime;
import java.util.List;

@Stateless
public class ReservationService {

    @PersistenceContext(unitName = "RoomReservationPU")
    private EntityManager em;

    private static final int MAX_DURATION_HOURS = 3;

    public void makeReservation(Reservation reservation) throws Exception {
        validateDuration(reservation.getStartTime(), reservation.getEndTime());
        if (!isRoomAvailable(reservation.getRoom(), reservation.getStartTime(), reservation.getEndTime())) {
            throw new Exception("Room is not available for the selected time period.");
        }
        em.persist(reservation);
    }

    public void updateReservation(Reservation reservation) throws Exception {
        validateDuration(reservation.getStartTime(), reservation.getEndTime());
        if (!isRoomAvailable(reservation.getRoom(), reservation.getStartTime(), reservation.getEndTime(),
                reservation.getId())) {
            throw new Exception("Room is not available for the selected time period.");
        }
        em.merge(reservation);
    }

    private void validateDuration(LocalDateTime start, LocalDateTime end) throws Exception {
        long hours = java.time.Duration.between(start, end).toHours();
        if (hours > MAX_DURATION_HOURS
                || (hours == MAX_DURATION_HOURS && java.time.Duration.between(start, end).toMinutes() % 60 > 0)) {
            throw new Exception("Reservation cannot exceed " + MAX_DURATION_HOURS + " hours.");
        }
    }

    public boolean isRoomAvailable(Room room, LocalDateTime start, LocalDateTime end) {
        return isRoomAvailable(room, start, end, null);
    }

    public boolean isRoomAvailable(Room room, LocalDateTime start, LocalDateTime end, Long excludeReservationId) {
        // Query to check for overlaps
        // Overlap condition: (StartA < EndB) and (EndA > StartB)
        String jpql = "SELECT COUNT(r) FROM Reservation r " +
                "WHERE r.room = :room " +
                "AND r.startTime < :endTime " +
                "AND r.endTime > :startTime";

        if (excludeReservationId != null) {
            jpql += " AND r.id != :excludeId";
        }

        var query = em.createQuery(jpql, Long.class)
                .setParameter("room", room)
                .setParameter("startTime", start)
                .setParameter("endTime", end);

        if (excludeReservationId != null) {
            query.setParameter("excludeId", excludeReservationId);
        }

        Long count = query.getSingleResult();

        return count == 0;
    }

    public List<Reservation> getAllReservations() {
        return em.createQuery("SELECT r FROM Reservation r JOIN FETCH r.room JOIN FETCH r.user", Reservation.class)
                .getResultList();
    }

    public List<Reservation> getUserReservations(Long userId) {
        return em
                .createQuery(
                        "SELECT r FROM Reservation r JOIN FETCH r.room JOIN FETCH r.user WHERE r.user.id = :userId",
                        Reservation.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    public Reservation findById(Long id) {
        return em.find(Reservation.class, id);
    }

    public Reservation findByIdWithDetails(Long id) {
        try {
            return em
                    .createQuery("SELECT r FROM Reservation r JOIN FETCH r.room JOIN FETCH r.user WHERE r.id = :id",
                            Reservation.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        }
    }

    public void cancelReservation(Long id) {
        Reservation reservation = findById(id);
        if (reservation != null) {
            em.remove(reservation);
        }
    }

    public List<Reservation> getReservationsByDate(java.time.LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.plusDays(1).atStartOfDay();

        return em
                .createQuery("SELECT r FROM Reservation r WHERE r.startTime >= :startOfDay AND r.startTime < :endOfDay",
                        Reservation.class)
                .setParameter("startOfDay", startOfDay)
                .setParameter("endOfDay", endOfDay)
                .getResultList();
    }
}
