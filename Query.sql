-- How many of the sales reps have more than 5 accounts that they manage?
SELECT COUNT(*) rep_count
FROM (SELECT s.id, COUNT(a.id) AS acc_num
      FROM sales_reps AS s
      JOIN accounts AS a
      ON s.id = a.sales_rep_id
      GROUP BY s.id
      HAVING COUNT(a.id) > 5
      ORDER BY acc_num) AS table1;

-- How many accounts have more than 20 orders?
SELECT COUNT(*) acc	
FROM (SELECT a.id, a.name AS account, COUNT(o.id) order_count
      FROM accounts AS a
      JOIN orders AS o
      ON a.id = o.account_id
      GROUP BY a.id, account
      HAVING COUNT(o.id) > 20
      ORDER BY order_count) AS table1;
      
-- Which account has the most orders?
SELECT a.id, a.name AS account, COUNT(o.id) order_count
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, account
ORDER BY order_count DESC
LIMIT 1;

-- Which accounts spent more than 30,000 usd total across all orders?
SELECT a.id, a.name AS account, SUM(o.total_amt_usd) AS total_order_amount
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, account
HAVING total_order_amount > 30000
ORDER BY total_order_amount;

-- Which accounts spent less than 1,000 usd total across all orders?
SELECT a.id, a.name AS account, SUM(o.total_amt_usd) AS total_order_amount
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, account
HAVING total_order_amount < 1000
ORDER BY total_order_amount;

-- Which account has spent the most with us?
SELECT a.id, a.name AS account, SUM(o.total_amt_usd) total_spent
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, account
ORDER BY total_spent DESC
LIMIT 1;

-- Which account has spent the least with us?
SELECT a.id, a.name AS account, SUM(o.total_amt_usd) total_spent
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, account
ORDER BY total_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.id, a.name AS account, COUNT(w.channel) AS facebook_used
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id AND w.channel = 'facebook'
GROUP BY a.id, account
HAVING facebook_used > 6
ORDER BY facebook_used;

-- Which account used facebook most as a channel? 
SELECT a.id, a.name AS account, COUNT(w.channel) used_facebook
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id AND w.channel = 'facebook'
GROUP BY a.id, account
ORDER BY used_facebook DESC
LIMIT 1;

-- Which channel was most frequently used by most accounts?
SELECT a.id, a.name AS account, w.channel, COUNT(w.channel) channel_used
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY a.id, account, w.channel
ORDER BY channel_used DESC;