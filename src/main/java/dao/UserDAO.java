package dao;

import java.sql.*;
import java.util.ArrayList;  // Add the SecurityUtil import for password hashing
import java.util.Base64;
import java.util.List;
import model.User;
import util.SecurityUtil;

public class UserDAO {
    private final Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO user (username, email, password, role, created_at) VALUES (?, ?, ?, ?, NOW())";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // Use the hashed password from the User object
            
            // Set default role as "User" if not specified
            String role = (user.getRole() != null && !user.getRole().trim().isEmpty()) ? user.getRole() : "User";
            stmt.setString(4, role);

            System.out.println("Registering user with username: " + user.getUsername() + ", role: " + role);
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
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("role"),
                    null,  // Don't pass the password hash
                    rs.getTimestamp("created_at")
                );
                
                // Handle profile image
                byte[] imageBytes = rs.getBytes("profile_image");
                if (imageBytes != null) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    user.setProfileImage(base64Image);
                }
                
                System.out.println("DAO: Created user object with role: " + user.getRole());
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }


    
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractUser(rs);
                }
            }
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user";
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

    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE user SET username = ?, email = ?, profile_image = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            if (user.getProfileImage() != null) {
                byte[] imageBytes = Base64.getDecoder().decode(user.getProfileImage());
                stmt.setBytes(3, imageBytes);
            } else {
                stmt.setNull(3, Types.BLOB);
            }
            stmt.setInt(4, user.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("UserDAO: Rows affected by update: " + rowsAffected);
            return rowsAffected > 0;
        }
    }

    public boolean updatePassword(int userId, String newPassword) throws SQLException {
        String query = "UPDATE user SET password = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteUser: " + e.getMessage());
            return false;
        }
    }

    public int getTotalUsers() throws SQLException {
        String query = "SELECT COUNT(*) FROM user";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    private User extractUser(ResultSet rs) throws SQLException {
        User user = new User(
            rs.getInt("user_id"),
            rs.getString("username"),
            rs.getString("email"),
            null, // Don't include password
            rs.getString("role"),
            rs.getTimestamp("created_at")
        );
        // Handle LONGBLOB data
        byte[] imageBytes = rs.getBytes("profile_image");
        if (imageBytes != null) {
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            user.setProfileImage(base64Image);
        }
        return user;
    }

    public boolean updateProfileImage(int userId, String profileImage) {
        String sql = "UPDATE user SET profile_image = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (profileImage != null) {
                byte[] imageBytes = Base64.getDecoder().decode(profileImage);
                stmt.setBytes(1, imageBytes);
            } else {
                stmt.setNull(1, Types.BLOB);
            }
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getProfileImage(int userId) {
        String sql = "SELECT profile_image FROM user WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("profile_image");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
