/*
Business Question: Finds Top 3 customers with the highest number of unique artists. 
Description: We will find the top 3 customers with the highest number of unique artists as well as the list of unique artists for those customers.
*/

WITH
    -- Find the top customer ids and unique artist count for each customer and limit to top 3.
    topCustomers AS (
        SELECT
            s.customerid as customerId,
            DISTINCTCOUNT(s.artistid) AS artistCount
        FROM "stream" s
        JOIN customer c ON s.customerid = c.id
        GROUP BY s.customerid, c.fullname
        ORDER BY artistCount DESC
        LIMIT 3
    ),
    -- Find all the customer and unique artist combinations along with customer names and artist names
    uniqueCustomerAndArtists AS (
        SELECT DISTINCT
            s.customerid as customerId,
            c.fullname as customerName,
            s.artistid as artistId,
            a.name as artistName
        FROM "stream" s
        JOIN customer c ON s.customerid = c.id
        JOIN artist a ON s.artistid = a.id
    )
-- Find the customer name and each of their unique artist names.
SELECT
    uniqueCustomerAndArtists.customerName,
    arrayagg(uniqueCustomerAndArtists.artistName, 'string', false) as uniqueArtists,
    topCustomers.artistCount as artistCount
FROM uniqueCustomerAndArtists
JOIN topCustomers ON uniqueCustomerAndArtists.customerId = topCustomers.customerId
WHERE uniqueCustomerAndArtists.customerId in (SELECT customerId FROM topCustomers)
GROUP BY uniqueCustomerAndArtists.customerId, uniqueCustomerAndArtists.customerName, artistCount
ORDER BY artistCount DESC, uniqueCustomerAndArtists.customerName;