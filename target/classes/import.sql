-- Insert Users (Passwords are hashed SHA-256)
-- admin / admin -> jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=
-- user / user   -> BPiZbadjt6lpsQKO4wB1aerzpjVIbdqyEdUSyFud+Ps=

INSERT INTO users (username, password, role) VALUES ('admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', 'ADMIN');
INSERT INTO users (username, password, role) VALUES ('user', 'BPiZbadjt6lpsQKO4wB1aerzpjVIbdqyEdUSyFud+Ps=', 'USER');

-- Insert Rooms
INSERT INTO rooms (name, capacity, description) VALUES ('Conference Room A', 10, 'Main conference room with projector');
INSERT INTO rooms (name, capacity, description) VALUES ('Meeting Room B', 5, 'Small meeting room');
INSERT INTO rooms (name, capacity, description) VALUES ('Training Room C', 20, 'Large room for training sessions');
