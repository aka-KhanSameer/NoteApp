# 📒 NotesApp – Java Web Application

NotesApp is a **Java-based web application** that allows users to **create, view, edit, and delete notes**.  
It is built using **JSP, Servlets, and JDBC**, following the **MVC design pattern** for clean separation of concerns.  

---

## 🚀 Features
- ➕ Add new notes  
- 📖 View all saved notes  
- ✏️ Edit existing notes  
- ❌ Delete notes  
- 🗄️ Data persistence with MySQL (via DAO pattern)  
- 🌐 Simple and user-friendly interface (JSP pages)  

---

## 🛠️ Tech Stack
- **Java (JDK 8+)**  
- **JSP & Servlets**  
- **JDBC + MySQL** (for database connectivity)  
- **Apache Tomcat** (deployment server)  
- **Eclipse/IntelliJ** (IDE recommended)  

---

## 📂 Project Structure
```
NotesApp/
│── src/main/java/
│   ├── controller/        # Servlets handling requests
│   ├── dao/               # Data Access Objects for DB operations
│   ├── model/             # POJO classes
│
│── src/main/webapp/
│   ├── WEB-INF/           # web.xml configuration
│   ├── add.jsp            # Add new note
│   ├── edit.jsp           # Edit note
│   ├── index.jsp          # Home page listing notes
│   ├── redirect.jsp       # Redirection handler
│
│── .classpath, .project   # Eclipse project settings
│── pom.xml (if Maven)     # Dependencies (if applicable)
```

---

## ⚙️ Setup & Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/your-username/NotesApp.git
   cd NotesApp
   ```

2. **Import project in IDE (Eclipse/IntelliJ)**  
   - Select *Import → Existing Java Project*  
   - Configure Tomcat Server in IDE  

3. **Database Setup**  
   - Create MySQL database `notesdb`  
   - Run SQL script:  
     ```sql
     CREATE DATABASE notesdb;
     USE notesdb;

     CREATE TABLE notes (
       id INT PRIMARY KEY AUTO_INCREMENT,
       title VARCHAR(100) NOT NULL,
       content TEXT NOT NULL
     );
     ```
   - Update DB credentials in `NoteDAO.java`  

4. **Run on Server**  
   - Deploy to Apache Tomcat  
   - Access at: `http://localhost:8080/NotesApp/`  

---

## 📸 Screenshots (Optional)
_Add app screenshots here if you want_

---

## 📌 Future Enhancements
- ✅ User authentication (login & signup)  
- ✅ Search notes functionality  
- ✅ Cloud deployment (Heroku/AWS)  

---

## 🤝 Contributing
Pull requests are welcome! For major changes, open an issue first to discuss what you’d like to change.  

---

## 📄 License
This project is licensed under the **MIT License** – free to use and modify.  
