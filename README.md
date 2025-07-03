# Sports Management System — SQL Server Database

This repository contains the SQL Server schema and sample data for an Online Sports Scheduling and Management System.  
It supports user roles (admin, coach, player, viewer), team and player management, tournaments, matches, results, reporting, and notifications.

---

## Features

- User roles and authentication (admin, coach, player, viewer)
- Team and player management
- Sports, venues, tournaments, and match scheduling
- Results and reporting (match incidents, reports)
- Notifications to users
- Views for coaches, players, and role summaries
- Indexes for performance
- Stored procedures for login and registration
- Transactions and relational algebra queries

---

## Tables & Entities

- `user_role` — Roles like admin, coach, player, viewer
- `user_management` — User details
- `sports` — List of sports (e.g., cricket, badminton)
- `venues` — Match venues
- `teams` — Teams and their coaches
- `players` — Players with team association
- `tournaments` — Tournament details
- `tournament_teams` — Teams participating in tournaments
- `matches` — Scheduled matches
- `results` — Match results
- `reports` — Incident or match reports
- `notifications` — User notifications

---
## Example Queries

- List all matches and their venues
- List all coaches and their details (`view_coaches`)
- Register or login users via stored procedures

---

## File Structure

```
sports-management-sql-server/
│
├── Sports Management System SQL-Server.sql
└── README.md
```

---

## Author

**Laiba Majeed**  
- [LinkedIn](https://www.linkedin.com/in/laibah-majeed/)  
- BS Software Engineering Student

---

## Feel free to explore the repository and contribute!
