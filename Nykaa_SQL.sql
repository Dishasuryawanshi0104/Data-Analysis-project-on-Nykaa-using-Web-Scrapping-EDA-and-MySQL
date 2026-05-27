create database nykaadb;
use nykaadb;

-- Changing Column names

ALTER TABLE nykaa
CHANGE `Product Name` product_name text;
ALTER TABLE nykaa
CHANGE `Original Price` original_price int ;
ALTER TABLE nykaa
CHANGE `Offer Price` offer_price int;
ALTER TABLE nykaa
CHANGE `Discount %` discount_percent int;
ALTER TABLE nykaa
CHANGE `Reviews` reviews int;
ALTER TABLE nykaa
CHANGE `Images Links` images_links text;
ALTER TABLE nykaa
CHANGE `Product Category` product_category text;
ALTER TABLE nykaa
CHANGE `Price Segment` price_segment text;

---------------------------------------------------------------------

SELECT *
FROM nykaa;

-- 1. Total Number of Products
SELECT COUNT(*) AS total_products
FROM nykaa;

-- 2. Total Number of Categories
SELECT COUNT(DISTINCT product_category) AS total_categories
FROM nykaa;

-- 3. Display all unique categories
SELECT DISTINCT product_category
FROM nykaa;

-- 4. Find Products with Highest Original Price
SELECT product_name, product_category, original_price
FROM nykaa
ORDER BY original_price DESC
LIMIT 10;

-- 5. Calculate Average Original Price
SELECT AVG(original_price) AS avg_original_price
FROM nykaa;

-- 6. Calculate Average Discount Percentage
SELECT AVG(discount_percent) AS avg_discount
FROM nykaa;

-- 7. Find Products with More Than 50% Discount
SELECT product_name, product_category, discount_percent
FROM nykaa
WHERE discount_percent > 50
ORDER BY discount_percent DESC
LIMIT 10;

-- 8. Find Top Reviewed Products
SELECT product_name, product_category, reviews
FROM nykaa
ORDER BY reviews DESC
LIMIT 10;

-- 9. Total Products in Each Category
SELECT product_category, COUNT(*) AS total_products
FROM nykaa
GROUP BY product_category
ORDER BY total_products DESC;

-- 10. Average Offer Price by Category
SELECT product_category,
       ROUND(AVG(offer_price),2) AS avg_offer_price
FROM nykaa
GROUP BY product_category
ORDER BY avg_offer_price DESC;

 -- 11. Maximum Discount by Category
SELECT product_category,
       MAX(discount_percent) AS max_discount
FROM nykaa
GROUP BY product_category
ORDER BY max_discount DESC;

-- 12. Total Reviews by Category
SELECT product_category,
       SUM(reviews) AS total_reviews
FROM nykaa
GROUP BY product_category
ORDER BY total_reviews DESC;

-- 13. Find Products Where Offer Price is Less Than 500
SELECT product_name, product_category, offer_price
FROM nykaa
WHERE offer_price < 500
ORDER BY offer_price ASC;

-- 14. Find Premium Products
SELECT product_name, original_price, price_segment
FROM nykaa
WHERE original_price > 10000
ORDER BY original_price DESC;

-- 15. Products with No Discount
SELECT product_name, original_price, offer_price, discount_percent
FROM nykaa
WHERE discount_percent = 0;

-- 16. Count Products by Price Segment
SELECT price_segment,
       COUNT(*) AS total_products
FROM nykaa
GROUP BY price_segment
ORDER BY total_products DESC;

-- 17. Average Discount by Price Segment
SELECT price_segment,
       ROUND(AVG(discount_percent),2) AS avg_discount
FROM nykaa
GROUP BY price_segment;

-- 18. Top 5 Categories with Highest Average Reviews
SELECT product_category,
       ROUND(AVG(reviews),2) AS avg_reviews
FROM nykaa
GROUP BY product_category
ORDER BY avg_reviews DESC
LIMIT 5;

-- 19. Find Savings Amount on Products
SELECT product_name,
       original_price,
       offer_price,
       discount_percent,
       (original_price - offer_price) AS savings
FROM nykaa
ORDER BY savings DESC;

-- 20. Top 5 Products with Maximum Savings
SELECT product_name,
       original_price,
       offer_price,
       discount_percent,
       (original_price - offer_price) AS savings
FROM nykaa
ORDER BY savings DESC
LIMIT 5 ;

-- 21. Category-wise Highest Reviewed Product
SELECT product_category,
       MAX(reviews) AS highest_reviews
FROM nykaa
GROUP BY product_category;

-- 22. Products Having Reviews Greater Than Average Reviews
SELECT product_name, reviews
FROM nykaa
WHERE reviews > (
    SELECT AVG(reviews)
    FROM nykaa
)
ORDER BY reviews DESC;

-- 23. Rank Products Based on Discount
SELECT product_name,
       discount_percent,
       RANK() OVER (ORDER BY discount_percent DESC) AS discount_rank
FROM nykaa;

-- 24. Find Most Expensive Product in Each Category
SELECT n1.product_category,
       n1.product_name,
       n1.original_price
FROM nykaa n1
JOIN (
    SELECT product_category,
           MAX(original_price) AS max_price
    FROM nykaa
    GROUP BY product_category
) n2
ON n1.product_category = n2.product_category
AND n1.original_price = n2.max_price;

-- 25. Create Product Performance Labels
SELECT product_name,
       reviews,
       CASE
           WHEN reviews > 100000 THEN 'Best Seller'
           WHEN reviews > 10000 THEN 'Popular'
           WHEN reviews > 1000 THEN 'Average'
           ELSE 'Low Engagement'
       END AS performance_label
FROM nykaa;

-- 26. Category wise total products, average discount, average offer price and total reviews.
SELECT product_category,
       COUNT(*) AS total_products,
       ROUND(AVG(discount_percent),2) AS avg_discount,
       ROUND(AVG(offer_price),2) AS avg_offer_price,
       SUM(reviews) AS total_reviews
FROM nykaa
GROUP BY product_category
ORDER BY total_reviews DESC;

-- 27. Which Categories Generate Maximum Customer Engagement
SELECT product_category,
       SUM(reviews) AS total_reviews,
       COUNT(*) AS total_products,
       ROUND(AVG(reviews),2) AS avg_reviews
FROM nykaa
GROUP BY product_category
ORDER BY total_reviews DESC;

-- 28. Which Price Segment Performs Best
SELECT price_segment,
       COUNT(*) AS total_products,
       SUM(reviews) AS total_reviews,
       ROUND(AVG(reviews),2) AS avg_reviews,
       ROUND(AVG(offer_price),2) AS avg_price
FROM nykaa
GROUP BY price_segment
ORDER BY total_reviews DESC;

-- 29. Luxury Products vs Budget Products Analysis
SELECT price_segment,
       COUNT(*) AS total_products,
       ROUND(AVG(original_price),2) AS avg_original_price,
       ROUND(AVG(discount_percent),2) AS avg_discount,
       SUM(reviews) AS total_reviews
FROM nykaa
GROUP BY price_segment;

-- 30. Pricing and Discount Relationship
SELECT product_name,
       original_price,
       offer_price,
       discount_percent,
       (original_price - offer_price) AS savings
FROM nykaa
ORDER BY discount_percent DESC;

-- 31. Top 5 Most Engaging Categories
SELECT product_category,
       ROUND(AVG(reviews),2) AS avg_reviews
FROM nykaa
GROUP BY product_category
ORDER BY avg_reviews DESC
LIMIT 5;

-- 32. Best Selling Price Range Analysis
SELECT 
    CASE
        WHEN offer_price < 500 THEN 'Budget'
        WHEN offer_price BETWEEN 500 AND 2000 THEN 'Mid-Range'
        ELSE 'Luxury'
    END AS price_range,
    SUM(reviews) AS total_reviews,
    COUNT(*) AS total_products
FROM nykaa
GROUP BY price_range
ORDER BY total_reviews DESC;

-- 33. Top Products by Savings Amount
SELECT product_name,
       original_price,
       offer_price,
       (original_price - offer_price) AS savings
FROM nykaa
ORDER BY savings DESC
LIMIT 10;

-- 34. Premium Products with High Engagement
SELECT product_name,
       original_price,
       reviews
FROM nykaa
WHERE original_price > 10000
AND reviews > 1000
ORDER BY reviews DESC;

-- 35. Category-wise Best Performing Product
SELECT *
FROM (
    SELECT product_category,
           product_name,
           reviews,
           ROW_NUMBER() OVER(
               PARTITION BY product_category
               ORDER BY reviews DESC
           ) AS rank_num
    FROM nykaa
) ranked
WHERE rank_num = 1;