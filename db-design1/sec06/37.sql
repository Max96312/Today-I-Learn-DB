-- ## 일대다(1:N) 다대일(N:1) 관계 - 조인과 뻥튀기

SELECT
    m.name AS member_name,
    t.name AS team_name
FROM
    member m
LEFT JOIN
    team t ON m.team_id = t.team_id;


SELECT * FROM team;


SELECT
    t.name AS team_name,
    m.name AS member_name
FROM
    team t
JOIN
    member m ON t.team_id = m.team_id;