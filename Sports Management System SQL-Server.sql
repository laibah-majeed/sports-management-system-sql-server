-- create the database
create database online_sports_scheduling_system;
use online_sports_scheduling_system;

-- create user roles table to store roles like admin, coach, player, viewer
create table user_role (
    role_id int primary key identity(1,1),
    role_name varchar(50) not null
);

-- create user management table to store user details including roles
create table user_management (
    user_id int primary key identity(1,1),
    username varchar(50) unique not null,
    email varchar(100) not null unique,
    password varchar(255) not null,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    phone varchar(20),
    role_id int,
    foreign key (role_id) references user_role(role_id)
);

-- create sports table to hold different sports available
create table sports (
    sport_id int primary key identity(1,1),
    sport_name varchar(100) not null
);

-- create venues table to store venue details for matches
create table venues (
    venue_id int primary key identity(1,1),
    venue_name varchar(100),
    location varchar(255),
    capacity int
);

-- create teams table including team name, associated sport, and coach
create table teams (
    team_id int primary key identity(1,1),
    team_name varchar(100) not null,
    sport_id int,
    coach_id int,
    foreign key (sport_id) references sports(sport_id),
    foreign key (coach_id) references user_management(user_id)
);

-- create players table with player info and team association
create table players (
    player_id int primary key identity(1,1),
    player_name varchar(100),
    age int,
    joined_date date,
    position varchar(50),
    team_id int,
    foreign key (team_id) references teams(team_id)
);

-- create tournaments table for holding tournaments details
create table tournaments (
    tournament_id int primary key identity(1,1),
    tournament_name varchar(100),
    start_date date,
    end_date date,
    sport_id int,
    foreign key (sport_id) references sports(sport_id)
);

-- create junction table for many-to-many relation between tournaments and teams
create table tournament_teams (
    id int primary key identity(1,1),
    tournament_id int,
    team_id int,
    foreign key (tournament_id) references tournaments(tournament_id),
    foreign key (team_id) references teams(team_id)
);

-- create matches table for scheduling matches between teams in a tournament at a venue and time
create table matches (
    match_id int primary key identity(1,1),
    tournament_id int,
    venue_id int,
    match_date date,
    status varchar(50),
    foreign key (tournament_id) references tournaments(tournament_id),
	team1_id int,
    foreign key (team1_id) references teams(team_id),
	team2_id int,
    foreign key (team2_id) references teams(team_id),
    foreign key (venue_id) references venues(venue_id)
);

-- create results table to store match results and winner info
create table results (
    result_id int primary key identity(1,1),
    match_id int,
    winner_team_id int,
    score varchar(50),
    foreign key (match_id) references matches(match_id),
    foreign key (winner_team_id) references teams(team_id)
);

-- create reports table to store incident or match reports related to matches, teams, or players
create table reports (
    report_id int identity(1,1) primary key,
    match_id int null,
    team_id int null,
    player_id int null,
    report_date datetime default getdate(),
    report_text varchar(max) not null,
    foreign key (match_id) references matches(match_id),
    foreign key (team_id) references teams(team_id),
    foreign key (player_id) references players(player_id)
);

-- create notifications table to send notifications to users
create table notifications (
    notification_id int identity(1,1) primary key,
    user_id int not null,
    notification_text varchar(255) not null,
    message_sent datetime default getdate(),
    foreign key (user_id) references user_management(user_id)
);

-- insert initial roles
insert into user_role (role_name) values
('admin'), ('coach'), ('player'), ('viewer');
select * from user_management
-- insert sample users with roles
insert into user_management (username, email, password, first_name, last_name, phone, role_id) values
('admin1', 'admin@gov.pk', 'admin123', 'noman', 'ahmed', '0300-1000001', 1),
('coach1', 'sajid.butt@psb.org.pk', 'coach1', 'sajid', 'butt', '0301-2223344', 2),
('coach2', 'hamid.riaz@lahoresports.pk', 'coach2', 'hamid', 'riaz', '0321-3456789', 2),
('coach3', 'junaid.akhtar@karachiclub.pk', 'coach3', 'junaid', 'akhtar', '0333-9876543', 2),
('coach4', 'iftikhar.ali@sindhsports.pk', 'coach4', 'iftikhar', 'ali', '0345-1122334', 2),
('player1', 'ahmed.nawaz@team.pk', 'player1', 'ahmed', 'nawaz', '0312-1000002', 3),
('player2', 'bilal.shah@team.pk', 'player2', 'bilal', 'shah', '0323-1112233', 3),
('player3', 'zain.ali@team.pk', 'player3', 'zain', 'ali', '0334-2223344', 3),
('player4', 'hassan.javed@team.pk', 'player4', 'hassan', 'javed', '0345-3334455', 3),
('player5', 'hamza.qureshi@team.pk', 'player5', 'hamza', 'qureshi', '0301-4445566', 3),
('player6', 'imran.butt@team.pk', 'player6', 'imran', 'butt', '0310-5556677', 3),
('player7', 'sami.tariq@team.pk', 'player7', 'sami', 'tariq', '0320-6667788', 3),
('player8', 'omar.abbasi@team.pk', 'player8', 'omar', 'abbasi', '0331-7778899', 3),
('player9', 'adeel.hussain@team.pk', 'player9', 'adeel', 'hussain', '0342-8889900', 3),
('player10', 'danish.rafiq@team.pk', 'player10', 'danish', 'rafiq', '0302-9990011', 3),
('viewer1', 'viewer.one@sportsfan.pk', 'viewer1', 'fatima', 'khan', '0313-1231231', 4);

-- insert sports data
insert into sports (sport_name) values ('cricket'), ('badminton');

-- insert venues with location and capacity
insert into venues (venue_name, location, capacity) values
('cricket ground', 'lahore', 30000),
('badminton court', 'karachi', 5000);

-- insert teams with their sport and coach
insert into teams (team_name, sport_id, coach_id) values
('cricket warriors', 1, 2),
('cricket strikers', 1, 3),
('badminton smashers', 2, 4),
('badminton flyers', 2, 5);

-- insert players with details and team association
insert into players (player_name, age, joined_date, position, team_id) values
('ali badminton', 23, '2025-01-01', null, 3),
('sara shuttle', 21, '2025-01-02', null, 4),
('imran bat', 25, '2025-02-01', 'batsman', 1),
('wasim ball', 26, '2025-02-02', 'bowler', 1),
('aamir keeper', 24, '2025-02-03', 'wicketkeeper', 1),
('junaid allround', 28, '2025-02-04', 'allrounder', 1),
('zeeshan bat', 23, '2025-02-05', 'batsman', 2),
('shan ball', 22, '2025-02-06', 'bowler', 2),
('fakhar keeper', 27, '2025-02-07', 'wicketkeeper', 2),
('haris allround', 29, '2025-02-08', 'allrounder', 2);

-- insert tournaments
insert into tournaments (tournament_name, start_date, end_date, sport_id) values
('grand sports cup', '2025-06-01', '2025-06-15', 1);

-- link teams to tournaments
insert into tournament_teams (tournament_id, team_id) values
(1, 1), (1, 2), (1, 3), (1, 4);

-- schedule matches in tournaments with venue and status
insert into matches (tournament_id, team1_id, team2_id, venue_id, match_date, status) values
(1, 1, 2, 1, '2025-06-02', 'scheduled');
(1, 3, 4, 2, '2025-06-03', 'scheduled');

-- insert match results
insert into results (match_id, winner_team_id, score) values
(1, 1, '200/5');

-- insert reports related to matches or players or teams
insert into reports (match_id, team_id, player_id, report_text)
values (1, 1, 1, 'player received a yellow card for misconduct.');

-- insert sample notifications for users
insert into notifications (user_id, notification_text) values 
(1, 'your match schedule has been updated.'),
(2, 'your report has been submitted for review.'),
(3, 'match result is available.'),
(1, 'you have a new message from the admin.');

--selection for all
select * from user_role;
select * from user_management;
select * from sports;
select * from venues;
select * from teams;
select * from players;
select * from tournaments;
select * from tournament_teams;
select * from matches;
select * from results;
select * from reports;
select * from notifications;

-- stored procedure to verify user login
CREATE PROCEDURE sp_userlogin
    @username VARCHAR(50),
    @password VARCHAR(255)
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM user_management 
        WHERE username = @username AND password = @password
    )
    BEGIN
        SELECT 'Login successful.' AS message;
    END
    ELSE
    BEGIN
        SELECT 'User not found. Please check your username and password.' AS message;
    END
END;

 exec sp_userlogin @username='admin1' , @password='admin123';

-- stored procedure to register new users
create procedure sp_register
    @username varchar(50), @password varchar(255), @email varchar(100),
    @first_name varchar(100), @last_name varchar(100), @phone varchar(20),
     @role_id int
as
begin
    insert into user_management (username, password, email, first_name, last_name, phone, role_id)
    values (@username, @password, @email, @first_name, @last_name, @phone, @role_id);
end;

exec sp_register @username = 'admin6',  @password = 'password126',@email = 'admin6@gmail.com',
    @first_name = 'John6',@last_name = 'Doe6',@phone = '031234567890',@role_id = 2;

	select * from user_management
   
-- create indexes for faster search on username and email
create index idxusername on user_management(username);
create index idxemail on user_management(email);
create index idxteam_name on teams(team_name);
create index idxsport_name on sports(sport_name);

-- create view for all coaches details

create view view_coaches as
select user_id, username, first_name, last_name, email, phone
from user_management
where role_id = 2;

create view view_player_info as
select player_id, player_name, age, joined_date, position, team_id
from players;

create view view_user_roles as
SELECT um.user_id, um.username, um.email, um.first_name, um.last_name, ur.role_name
FROM user_management um
inner Join user_role ur ON um.role_id = ur.role_id;


-- example selects from views
select * from view_coaches;
select * from view_player_info;
select * from view_user_roles;

-- select users with their role names
select um.user_id, um.username, um.email, ur.role_name
from user_management um
inner join user_role ur 
on um.role_id = ur.role_id;

-- select players only
select um.user_id, um.username, um.email
from user_management um
inner join user_role ur 
on um.role_id = ur.role_id
where ur.role_name = 'player';

-- search users by partial name or email match
select * from user_management
where username like '%ali%' or first_name like '%ali%' or last_name like '%ali%' or email like '%ali%';

-- count users by role and arranged in order
select ur.role_name, count(um.user_id) as total_users
from user_role ur
left join user_management um 
on ur.role_id = um.role_id
group by ur.role_name 
order by total_users desc ;

-- update example: update email and phone for a user
update user_management set email = 'updated_email@example.com', phone = '03120000000'
where user_id = 3;

-- get team and venue info for matches (team1 and team2)
select t.team_name, v.venue_name, m.match_date
from matches m
inner join venues v on m.venue_id = v.venue_id
inner join teams t on m.team1_id = t.team_id
union
select t.team_name, v.venue_name, m.match_date
from matches m
inner join venues v on m.venue_id = v.venue_id
inner join teams t on m.team2_id = t.team_id;

-- list players with their teams and sports
select p.player_name, t.team_name, s.sport_name
from players p
left join teams t on p.team_id = t.team_id
left join sports s on t.sport_id = s.sport_id;


-- select specific team by id
select * from teams where team_id = 2;

-- get matches played on a specific date for teams
select t.team_name, m.match_date
from matches m
left join teams t 
on m.team1_id = t.team_id or m.team2_id = t.team_id
where m.match_date = '2025-06-02';

-- get teams and venue for badminton matches
select distinct t.team_name, v.venue_name
from teams t
inner join sports s on t.sport_id = s.sport_id
inner join matches m on m.team1_id = t.team_id or m.team2_id = t.team_id
inner join venues v on m.venue_id = v.venue_id
where s.sport_name = 'badminton';

-- get matches and venues for a specific team
select t.team_name, v.venue_name, m.match_date
from matches m
left join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id
left join venues v on m.venue_id = v.venue_id
where t.team_id = 1;

-------update user email safely
begin transaction;

update user_management set email = 'new_email@example.com' where user_id = 1;
save transaction savepoint1;

update user_management set phone = '03120001111' where user_id = 1;
save transaction savepoint2;

update user_management set last_name = 'updatedlastname' where user_id = 1;

rollback transaction savepoint2;

commit;

-- relational algebra 

-- select all usernames and emails
select username, email from user_management;

-- select usernames with alias uname
select username as uname, email from user_management;

-- union of coach ids and user ids
select coach_id as user_id from teams
union
select user_id from user_management;

-- intersection of coach ids and user ids
select coach_id as user_id from teams
intersect
select user_id from user_management;

-- except: users who are not coaches
select user_id from user_management
except
select coach_id from teams;



