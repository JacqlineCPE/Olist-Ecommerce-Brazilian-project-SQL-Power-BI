SELECT *
FROM olist_products_dataset
WHERE product_id IS NULL OR product_category_name IS NULL;

UPDATE olist_products_dataset
SET product_category_name = 'unknown'
WHERE product_category_name IS NULL;

SELECT COUNT(*) AS affected_orders
FROM olist_order_items_dataset OI
WHERE OI.product_id IN (
    SELECT product_id 
    FROM olist_products_dataset 
    WHERE product_category_name = 'unknown'
);

--"What is the total revenue, total shipping cost, and number of orders?"

SELECT 
	ROUND(SUM(PRICE),2) AS Total_revenue,
	ROUND(SUM(freight_value),2) AS Shipping_cost,
	COUNT(DISTINCT order_id) as Total_orders
FROM olist_order_items_dataset;

--"What is the contribution margin (Revenue - Shipping Cost) and margin %?"

WITH margin AS(
	SELECT 
		ROUND(SUM(PRICE),2) AS Total_revenue,
		ROUND(SUM(freight_value),2) AS Shipping_cost,
		(ROUND(SUM(PRICE),2)- ROUND(SUM(freight_value),2)) AS contribution_margin
	FROM olist_order_items_dataset)
SELECT
	contribution_margin,
	ROUND((contribution_margin / Total_revenue) * 100, 2) AS Percent_Margin
FROM margin;
	
--Which product categories generate the most revenue?

SELECT TOP 10
	product_category_name_english, ROUND(SUM(PRICE),2) AS Total_revenue
FROM product_category_name_translation AS PT
JOIN olist_products_dataset AS P
ON PT.product_category_name =P.product_category_name
JOIN olist_order_items_dataset AS OI
ON P.product_id = OI.product_id
GROUP BY product_category_name_english
ORDER BY Total_revenue DESC;

---Which categories have the highest shipping cost as % of revenue?

WITH PERCENT_COST AS(
	SELECT 
		product_category_name_english,ROUND(SUM(PRICE),2) AS Total_revenue, ROUND(SUM(freight_value),2) AS Total_shipping_cost
	FROM  product_category_name_translation AS PT
	JOIN olist_products_dataset AS P
	ON PT.product_category_name =P.product_category_name
	JOIN olist_order_items_dataset AS OI
	ON P.product_id = OI.product_id
	GROUP BY product_category_name_english)
SELECT TOP 10
	product_category_name_english, Total_revenue,
	ROUND((Total_shipping_cost / Total_revenue) * 100,2) AS Percent_Shipping_cost
FROM PERCENT_COST
ORDER BY Percent_Shipping_cost DESC;

-- Question 5: Contribution Margin by Category
WITH margin AS(
	SELECT
		product_category_name_english,
		ROUND(SUM(PRICE),2) AS Total_revenue,
		ROUND(SUM(freight_value),2) AS Shipping_cost,
		ROUND(SUM(PRICE),2)- ROUND(SUM(freight_value),2) AS contribution_margin,
		ROUND(((SUM(PRICE)- SUM(freight_value))/SUM(PRICE))* 100,2)  AS Percent_Margin
	FROM olist_order_items_dataset AS OI
	JOIN olist_products_dataset AS P
	ON OI.product_id=P.product_id
	JOIN product_category_name_translation AS PC
	ON P.product_category_name = PC.product_category_name
	GROUP BY product_category_name_english)
SELECT
	product_category_name_english, Total_revenue, Shipping_cost, contribution_margin, Percent_Margin
FROM margin
ORDER BY Percent_Margin DESC;

--"Which states generate the most revenue?"

SELECT TOP 10
    C.customer_state,
    COUNT(DISTINCT O.order_id) AS total_orders,
    ROUND(SUM(OI.price), 2) AS total_revenue,
    ROUND(SUM(OI.price) / COUNT(DISTINCT O.order_id), 2) AS avg_order_value
FROM olist_orders_dataset AS O
JOIN olist_customers_dataset AS C
    ON O.customer_id = C.customer_id
JOIN olist_order_items_dataset AS OI
    ON O.order_id = OI.order_id
GROUP BY C.customer_state
ORDER BY total_revenue DESC;

--"Which states have the highest shipping cost to revenue ratio?"

WITH state_metrics AS (
    SELECT 
        C.customer_state,
        ROUND(SUM(OI.price), 2) AS total_revenue,
        ROUND(SUM(OI.freight_value), 2) AS total_shipping_cost
    FROM olist_orders_dataset AS O
    JOIN olist_customers_dataset AS C
        ON O.customer_id = C.customer_id
    JOIN olist_order_items_dataset AS OI
        ON O.order_id = OI.order_id
    GROUP BY C.customer_state
)
SELECT 
    customer_state,
    total_revenue,
    total_shipping_cost,
    ROUND((total_shipping_cost / total_revenue) * 100, 2) AS shipping_cost_percent
FROM state_metrics
WHERE total_revenue > 10000  
ORDER BY shipping_cost_percent DESC;

--"What is the average order value by payment installment (1x, 2x, 6x, 12x)?"

SELECT
    payment_installments,
    ROUND(AVG(payment_value), 2) AS avg_order_value,
    COUNT(DISTINCT order_id) AS order_count
FROM olist_order_payments_dataset
GROUP BY payment_installments
ORDER BY payment_installments;

--"What is the average review score for on-time vs. late deliveries?"

SELECT
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'LATE'
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'ON_TIME'
        ELSE 'NOT_DELIVERED'
    END AS Delivery_Performance,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    COUNT(*) AS review_count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percent_of_reviews
FROM olist_orders_dataset AS O
JOIN olist_order_reviews_dataset AS R
    ON O.order_id = R.order_id
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'LATE'
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'ON_TIME'
        ELSE 'NOT_DELIVERED'
    END
ORDER BY avg_review_score DESC;



-- Question 10: Revenue vs Profit Matrix
WITH category_performance AS (
    SELECT 
        product_category_name_english,
        ROUND(SUM(price), 2) AS total_revenue,
        ROUND(SUM(freight_value), 2) AS total_shipping_cost,
        ROUND(SUM(price) - SUM(freight_value), 2) AS contribution_margin,
        ROUND(((SUM(price) - SUM(freight_value)) / SUM(price)) * 100, 2) AS margin_percent
    FROM product_category_name_translation AS PT
    JOIN olist_products_dataset AS P
        ON PT.product_category_name = P.product_category_name
    JOIN olist_order_items_dataset AS OI
        ON P.product_id = OI.product_id
    GROUP BY product_category_name_english
)
SELECT 
    product_category_name_english,
    total_revenue,
    contribution_margin,
    margin_percent,
    CASE 
        WHEN total_revenue > 100000 AND margin_percent < 70 THEN 'High Revenue, Low Margin'
        WHEN total_revenue > 100000 AND margin_percent >= 70 THEN 'High Revenue, High Margin'
        WHEN total_revenue <= 100000 AND margin_percent >= 70 THEN 'Low Revenue, High Margin'
        ELSE 'Low Revenue, Low Margin'
    END AS category_type
FROM category_performance
ORDER BY total_revenue DESC;


-- Check for negative values
SELECT 
    COUNT(*) AS negative_prices
FROM olist_order_items_dataset 
WHERE price < 0;

-- Check for extreme shipping costs
SELECT 
    product_id,
    price,
    freight_value,
    (freight_value / price) * 100 AS shipping_percent
FROM olist_order_items_dataset
WHERE (freight_value / price) > 1  -- Shipping cost more than product price
ORDER BY shipping_percent DESC;

-- Verify category coverage
SELECT 
    COUNT(*) AS total_products,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS no_category
FROM olist_products_dataset;




