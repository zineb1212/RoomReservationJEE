package com.reservation.service;

import com.reservation.model.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Optional;

@Stateless
public class UserService {

    @PersistenceContext(unitName = "RoomReservationPU")
    private EntityManager em;

    public void register(User user) throws Exception {
        // Check if username exists
        Long count = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.username = :username", Long.class)
                .setParameter("username", user.getUsername())
                .getSingleResult();
        
        if (count > 0) {
            throw new Exception("Username already exists");
        }

        // Hash password
        user.setPassword(hashPassword(user.getPassword()));
        
        // Default role if not set
        if (user.getRole() == null) {
            user.setRole(User.Role.USER);
        }

        em.persist(user);
    }

    public Optional<User> authenticate(String username, String password) {
        try {
            String hashedPassword = hashPassword(password);
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class);
            query.setParameter("username", username);
            query.setParameter("password", hashedPassword);
            
            return Optional.of(query.getSingleResult());
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
