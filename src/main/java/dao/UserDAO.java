package dao;

import model.User;
import Utils.SecurityUtil;  // Add the SecurityUtil import for password hashing
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private final Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO user (username, email, password, role, createdAt) VALUES (?, ?, ?, ?, NOW())";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());

            // 🔥 Password is already hashed before reaching here
            System.out.println("Registering user with hashed password: " + user.getPassword());
            stmt.setString(3, user.getPassword()); // Already hashed
            stmt.setString(4, user.getRole());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in registerUser: " + e.getMessage());
            return false;
        }
    }


    public User authenticateUser(String username, String plainPassword) {
        System.out.println("DAO: looking for username=\"" + username + "\"");
        String sql = "SELECT * FROM user WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("DAO: no such user");
                    return null;
                }

                // 1) Retrieve stored hash
                String storedHash = rs.getString("password");
                System.out.println("DAO: storedHash = " + storedHash);

                // 2) Hash the entered password for comparison
                String inputHash = SecurityUtil.hashPassword(plainPassword);
                System.out.println("DAO: hash(entered) = " + inputHash);

                // 3) Compare
                boolean ok = SecurityUtil.checkPassword(plainPassword, storedHash);
                System.out.println("DAO: passwords match? " + ok);
                if (!ok) {
                    System.out.println("DAO: invalid password");
                    return null;
                }

                // 4) Build User object from result set
                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String role = rs.getString("role");
                Timestamp createdAt = rs.getTimestamp("createdAt");

                System.out.println("DAO: authentication successful for user_id=" + userId);
                return new User(
                    userId,
                    rs.getString("username"),
                    email,
                    storedHash,
                    role,
                    createdAt
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }


    
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE userId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error in getUserById: " + e.getMessage());
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(extractUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllUsers: " + e.getMessage());
        }
        return users;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username=?, email=?, password=?, role=? WHERE userId=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());

            // Hash the password before saving it
            String hashedPassword = SecurityUtil.hashPassword(user.getPassword());
            stmt.setString(3, hashedPassword); // Password should be hashed
            stmt.setString(4, user.getRole());
            stmt.setInt(5, user.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateUser: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE userId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteUser: " + e.getMessage());
            return false;
        }
    }

    private User extractUser(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("userId"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getString("role"),
            rs.getTimestamp("createdAt")
        );
    }
}
