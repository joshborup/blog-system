DROP TABLE IF EXISTS blog_comments;
DROP TABLE IF EXISTS blog_post;
DROP TABLE IF EXISTS users;
-- USER TABLE
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	email TEXT NOT NULL,
	name TEXT NOT NULL,
	date_joined TIMESTAMP DEFAULT NOW()
);
-- USER TABLE DUMMY DATA
INSERT INTO users (email, name)
VALUES ('joshborup@gmail.com', 'josh borup');

-- BLOG POST TABLE
CREATE TABLE blog_post(
	blog_post_id SERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	post TEXT NOT NULL,
	user_id INTEGER REFERENCES users(user_id),
	date_posted TIMESTAMP DEFAULT NOW(),
	tags TEXT[] NOT NULL
);

-- BLOG POST DUMMY DATA
INSERT INTO blog_post(title, post, user_id, tags)
VALUES ('first post', 'this is my first ever blog post', 1, '{"tech", "react", "javascript"}'), ('second post', 'this is my second ever blog post', 1, '{"galaxy", "astronomy", "astrophotography"}');

-- BLOG COMMENT TABLE
CREATE TABLE blog_comments(
	blog_comment_id SERIAL PRIMARY KEY NOT NULL,
	comment VARCHAR(250) NOT NULL,
	blog_post_id INT NOT NULL REFERENCES blog_post(blog_post_id),
	posted_time TIMESTAMP DEFAULT NOW(),
	parent_id INT NOT NULL DEFAULT 0
);

-- indexing parent_id of comments will speed up lookups for comments
CREATE INDEX blog_comments_parent_id_index ON blog_comments(parent_id);

-- first comments

INSERT INTO blog_comments(comment, blog_post_id, parent_id) VALUES ('First comment on article one.', 1, 0 ),('second comment on article one.', 1, 0 ), ('third comment on article one.', 1, 0 );


-- comment replys

INSERT INTO blog_comments(comment, blog_post_id, parent_id) VALUES ('Comment on first comment in article one', 1, 1 ), ('Another comment on first comment in article one', 1, 1);
