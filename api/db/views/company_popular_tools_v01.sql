SELECT *
FROM
(
  SELECT companies.id AS company_id, popular_tools.tool_id AS tool_id, popular_tools.popularity,
  RANK() OVER (PARTITION BY companies.id ORDER BY popular_tools.popularity DESC) as rank
  FROM companies
  INNER JOIN stacks ON stacks.company_id = companies.id
  INNER JOIN popular_tools ON stacks.tool_id = popular_tools.tool_id
  INNER JOIN tool_categories ON tool_categories.id = popular_tools.tool_category_id
  WHERE (tool_categories.name = 'Language' OR tool_categories .name = 'Framework')
) AS company_popular_tools
WHERE rank = 1
