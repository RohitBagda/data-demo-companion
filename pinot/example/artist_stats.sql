/*
Business Question: Who are the highest selling artists in terms of event revenue and what is the average ticket price, 
maximum ticket price, total number of tickets sold and total number of events for each artist
*/

SELECT
    a.name as artist_name,
    DISTINCTCOUNT(e.id) as total_events,
    SUM(t.price) as total_revenue,
    AVG(t.price) as avg_ticket_price,
    MAX(t.price) as max_ticket_price,
    COUNT(t.id) as total_tickets_sold
FROM artist a
JOIN event e ON a.id = e.artistid
JOIN ticket t ON t.eventid = e.id
GROUP BY artist_name
ORDER BY total_revenue DESC;