package com.reservation.service;

import com.reservation.model.Room;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class RoomService {

    @PersistenceContext(unitName = "RoomReservationPU")
    private EntityManager em;

    public void createRoom(Room room) {
        em.persist(room);
    }

    public List<Room> getAllRooms() {
        return em.createQuery("SELECT r FROM Room r", Room.class).getResultList();
    }

    public Room findById(Long id) {
        return em.find(Room.class, id);
    }

    public void updateRoom(Room room) {
        em.merge(room);
    }

    public void deleteRoom(Long id) {
        Room room = findById(id);
        if (room != null) {
            em.remove(room);
        }
    }

    public List<Room> findAvailableRooms(java.time.LocalDateTime start, java.time.LocalDateTime end,
            Integer minCapacity) {
        String jpql = "SELECT r FROM Room r WHERE r.capacity >= :minCapacity AND r.id NOT IN (" +
                "SELECT res.room.id FROM Reservation res WHERE " +
                "res.startTime < :endTime AND res.endTime > :startTime)";

        return em.createQuery(jpql, Room.class)
                .setParameter("minCapacity", minCapacity != null ? minCapacity : 0)
                .setParameter("startTime", start)
                .setParameter("endTime", end)
                .getResultList();
    }
}
