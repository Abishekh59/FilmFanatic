package util;

import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class SecurityUtil {

    // Method to hash the password using SHA-256
    public static String hashPassword(String password) {
        try {
            if (password == null || password.trim().isEmpty()) {
                throw new IllegalArgumentException("Password cannot be null or empty.");
            }

            // Trim the password to remove unwanted spaces
            password = password.trim();
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b)); // Convert each byte to a hexadecimal format
            }
            return sb.toString(); // Return the hashed password as a string
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    // Method to check if the entered password matches the stored hashed password
    public static boolean checkPassword(String plainPassword, String storedHashedPassword) {
        // Hash the plain password and compare it with the stored hashed password
        String hashedPassword = hashPassword(plainPassword);
        return hashedPassword != null && hashedPassword.equals(storedHashedPassword);
    }
}
