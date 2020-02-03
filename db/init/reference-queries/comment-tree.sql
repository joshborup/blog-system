WITH RECURSIVE cte (blog_comment_id, comment, path, parent_id, depth)  AS (
    SELECT  blog_comment_id,
	comment,
        array[blog_comment_id] AS path,
        parent_id,
        1 AS depth
    FROM    blog_comments
    WHERE   parent_id=0
    AND blog_post_id=1

    UNION ALL

    SELECT  blog_comments.blog_comment_id,
        blog_comments.comment,
        cte.path || blog_comments.blog_comment_id,
        blog_comments.parent_id,
        cte.depth + 1 AS depth
    FROM    blog_comments
    JOIN cte ON blog_comments.parent_id = cte.blog_comment_id
    )
    SELECT blog_comment_id, comment, path, depth FROM cte
ORDER BY path;