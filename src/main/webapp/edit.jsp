<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Note" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Note</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <style>
        body.dark-mode {
            background-color: #121212 !important;
            color: #e0e0e0;
        }
        .dark-mode .bg-white {
            background-color: #1e1e1e !important;
            color: #ffffff;
        }
        .dark-mode .form-control,
        .dark-mode .btn {
            background-color: #333 !important;
            color: #fff;
            border-color: #555;
        }
        .dark-mode .form-label {
            color: #ccc;
        }
        .dark-mode .btn-secondary {
            background-color: #444;
        }
        .dark-mode .alert-danger {
            background-color: #6e1e1e;
            color: #fff;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="animate__animated animate__fadeInDown">✏️ Edit Note</h2>
    <%
        Note note = (Note) request.getAttribute("note");
    %>
    <div class="card shadow p-4 bg-white animate__animated animate__fadeInUp">
        <form action="note?action=update" method="post">
            <input type="hidden" name="id" value="<%= note.getId() %>" />
            <div class="mb-3">
                <label class="form-label">Title</label>
                <input type="text" name="title" value="<%= note.getTitle() %>" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Content</label>
                <textarea name="content" class="form-control" rows="5" required><%= note.getContent() %></textarea>
            </div>
            <div class="d-flex justify-content-between">
                <a href="note" class="btn btn-secondary">⬅ Back</a>
                <input type="submit" value="💾 Update" class="btn btn-primary" />
            </div>
        </form>
    </div>
</div>

<script>
    // Apply dark mode if saved
    if (localStorage.getItem("darkMode") === "true") {
        document.body.classList.add("dark-mode");
    }
</script>
</body>
</html>


