package dao;

import java.sql.*;

import java.util.*;
import model.Note;

public class NoteDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/notes_app";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Niet@123"; 

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public List<Note> getAllNotes() throws SQLException {
        List<Note> list = new ArrayList<>();
        String sql = "SELECT * FROM notes ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Note(rs.getInt("id"), rs.getString("title"), rs.getString("content")));
            }
        }
        return list;
    }

    public void addNote(Note note) throws SQLException {
        String sql = "INSERT INTO notes (title, content) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, note.getTitle());
            ps.setString(2, note.getContent());
            ps.executeUpdate();
        }
    }

    public void deleteNote(int id) throws SQLException {
        String sql = "DELETE FROM notes WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Note getNoteById(int id) throws SQLException {
        String sql = "SELECT * FROM notes WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Note(id, rs.getString("title"), rs.getString("content"));
            }
        }
        return null;
    }

    public void updateNote(Note note) throws SQLException {
        String sql = "UPDATE notes SET title = ?, content = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, note.getTitle());
            ps.setString(2, note.getContent());
            ps.setInt(3, note.getId());
            ps.executeUpdate();
        }
    }
    
    public boolean isTitleExists(String title) throws SQLException {
        String sql = "SELECT COUNT(*) FROM notes WHERE title = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

}


/* data access object handles all DB operations using JDBC
 * uses java api to connect to db and uses sql queries for 
 * CRUD operations (SELECT, INSERT, UPDATE, DELETE)
 * this file gives clean seperation of db logic
 */
