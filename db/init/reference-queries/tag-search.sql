SELECT * FROM users
JOIN blog_post ON(users.user_id = blog_post.user_id)
WHERE 'tech' = ANY(tags);