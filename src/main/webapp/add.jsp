<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Note</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <!-- Dark Mode Styles -->
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
    <h2 class="mb-4">📝 Add New Note</h2>

    <!-- Show error message -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="note?action=insert" method="post" class="shadow p-4 rounded bg-white">
        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea name="content" class="form-control" rows="5" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">💾 Save Note</button>
        <a href="note" class="btn btn-secondary">⬅ Back</a>
    </form>
</div>

<script>
    // Apply stored dark mode preference
    if (localStorage.getItem("darkMode") === "true") {
        document.body.classList.add("dark-mode");
    }
</script>
</body>
</html>


