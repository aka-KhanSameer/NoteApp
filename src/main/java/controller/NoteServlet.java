package controller;

import java.io.IOException;

import java.sql.SQLException;
import java.util.List;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Note;

public class NoteServlet extends HttpServlet {
    private NoteDAO noteDAO;

    public void init() {
        noteDAO = new NoteDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action == null ? "list" : action) {
                case "new":
                    request.getRequestDispatcher("add.jsp").forward(request, response);
                    break;
                case "insert":
                    insertNote(request, response);
                    break;
                case "delete":
                    deleteNote(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateNote(request, response);
                    break;
                default:
                    listNotes(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward POST to doGet so your existing logic handles it
        doGet(request, response);
    }


    private void listNotes(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        List<Note> list = noteDAO.getAllNotes();
        req.setAttribute("noteList", list);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void insertNote(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (noteDAO.isTitleExists(title)) {
            // Send error message back to add.jsp
            req.setAttribute("error", "A note with this title already exists!");
            req.getRequestDispatcher("add.jsp").forward(req, resp);
        } else {
            noteDAO.addNote(new Note(0, title, content));
            resp.sendRedirect("note");
        }
    }


    private void deleteNote(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        noteDAO.deleteNote(id);
        resp.sendRedirect("note");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Note note = noteDAO.getNoteById(id);
        req.setAttribute("note", note);
        req.getRequestDispatcher("edit.jsp").forward(req, resp);
    }

    private void updateNote(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        noteDAO.updateNote(new Note(id, title, content));
        resp.sendRedirect("note");
    }
}


/* this servlet handles the http requests from user, works as a
 * controller in MVC web app
 * web.xml works as a configuration file (if @WebServlet not used, servlets are mapped here)
 * life cycle (init(), doGet(), doPost())
 * request dispatching - forward to jsp
 */

// run "http://localhost:4040/NotesApp/note" on browser

/* User goes to /note?action=new, shows the add note form (add.jsp)
 * NoteServlet handles it → calls NoteDAO.addNote() → saves in DB → redirects to /note
 * /note defaults to listNotes → gets all notes from DB → shows index.jsp
 * User can also edit, delete, or update notes by clicking links
 */

