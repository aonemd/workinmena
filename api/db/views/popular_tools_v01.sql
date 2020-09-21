SELECT COUNT(tools.id) AS popularity, tools.id
FROM stacks INNER JOIN tools ON tools.id = stacks.tool_id
GROUP BY tools.id
ORDER BY COUNT(tools.id) DESC
