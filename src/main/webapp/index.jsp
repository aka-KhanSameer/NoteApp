<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Note" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Notes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        .dark-mode {
            background-color: #121212 !important;
            color: #e0e0e0 !important;
        }

        .dark-mode .card,
        .dark-mode .modal-content,
        .dark-mode .modal-header,
        .dark-mode .modal-body {
            background-color: #1e1e1e !important;
            color: #ffffff !important;
        }

        .dark-mode .btn-close {
            filter: invert(1);
        }

        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            height: auto;
            min-height: 200px;
            overflow: hidden;
        }

        .card:hover {
            transform: scale(1.03) translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
        }

        .card-title, .card-text {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
        }

        .action-buttons {
            margin-top: 1rem;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>NOTES</h2>
        <div>
            <a href="note?action=new" class="btn btn-success me-2">➕ Add Note</a>
            <button id="darkModeToggle" class="btn btn-outline-dark">🌙 Toggle Dark Mode</button>
        </div>
    </div>

    <input type="text" id="searchInput" class="form-control mb-4" placeholder="🔍 Search notes..." onkeyup="filterNotes()">

    <div class="row">
        <%
            List<Note> noteList = (List<Note>) request.getAttribute("noteList");
            for(Note note : noteList) {
        %>
        <div class="col-md-4 mb-4 note-card">
            <div class="card shadow-sm animate__animated animate__fadeInUp"
                 data-title="<%= note.getTitle() %>"
                 data-content="<%= note.getContent().replace("\"", "&quot;") %>"
                 onclick="openNoteModal(this)">
                <div class="card-body">
                    <h5 class="card-title"><%= note.getTitle() %></h5>
                    <p class="card-text"><%= note.getContent() %></p>

                    <div class="action-buttons">
                        <a href="note?action=edit&id=<%= note.getId() %>" class="btn btn-sm btn-primary">✏️ Edit</a>
                        <a href="note?action=delete&id=<%= note.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Delete this note?')">🗑️ Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="noteModal" tabindex="-1" aria-labelledby="noteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="noteModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="noteModalContent"></div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function filterNotes() {
        const input = document.getElementById("searchInput").value.toLowerCase();
        const cards = document.querySelectorAll(".note-card");

        cards.forEach(card => {
            const title = card.querySelector(".card-title").innerText.toLowerCase();
            const content = card.querySelector(".card-text").innerText.toLowerCase();
            card.style.display = (title.includes(input) || content.includes(input)) ? "block" : "none";
        });
    }

    const toggle = document.getElementById("darkModeToggle");
    const body = document.body;

    toggle.addEventListener("click", () => {
        body.classList.toggle("dark-mode");
        localStorage.setItem("darkMode", body.classList.contains("dark-mode"));
    });

    if (localStorage.getItem("darkMode") === "true") {
        body.classList.add("dark-mode");
    }

    function openNoteModal(card) {
        const title = card.getAttribute("data-title");
        const content = card.getAttribute("data-content");

        document.getElementById("noteModalLabel").innerText = title;
        document.getElementById("noteModalContent").innerText = content;

        const modal = new bootstrap.Modal(document.getElementById("noteModal"));
        modal.show();
    }
</script>
</body>
</html>
