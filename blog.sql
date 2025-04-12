CREATE DATABASE blog;

USE blog;

-- Users Table
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Posts Table
CREATE TABLE posts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Comments Table
CREATE TABLE comments(
    id INT PRIMARY KEY AUTO_INCREMENT,
    comment TEXT NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- Insert sample data into users
INSERT INTO users(email,password) VALUES ('panda@gmail.com', 'panda');

-- Insert sample data into posts
INSERT INTO posts(title, content, user_id) VALUES ('First Post', 'This is the content of the first post.', 1);

-- Insert sample data into comments
INSERT INTO comments(comment, user_id, post_id) VALUES ('This is a comment on the first post.', 1, 1);


-- Get all posts with user information
SELECT user.id AS UserID, user.email AS UserEmail,
       post.id AS PostID, post.title AS PostTitle,
       comment.id AS comment_id, comment.comment AS comment
FROM users AS user
JOIN posts AS post ON user.id = post.user_id
JOIN comments AS comment ON post.id = comment.post_id
WHERE comment.user_id = user.id;