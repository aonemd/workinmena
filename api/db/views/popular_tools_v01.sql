SELECT tools.id AS tool_id, COUNT(tools.id) AS popularity, tools.tool_category_id AS tool_category_id
FROM stacks
INNER JOIN tools ON tools.id = stacks.tool_id
GROUP BY tools.id
ORDER BY COUNT(tools.id) DESC
