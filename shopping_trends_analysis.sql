SELECT *
FROM "shopping_trends";


-- creating a copy of the dataset

CREATE TABLE "shopping_trends_copy" AS
SELECT * FROM "shopping_trends";

SELECT *
FROM "shopping_trends_copy";


-- Checking if there are any duplicates

WITH duplicate_cte AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY "Customer_ID", "Age", "Gender", 
"Item_Purchased","Category", "Purchase_Amount (USD)", "Location", "Size", 
"Color", "Season", "Review_Rating" ,"Subscription_Status", "Payment_Method",
"Shipping_Type","Discount_Applied", "Promo_Code_used","Previous_Purchases",
"Preferred_Payment_Method", "Frequency_of_Purchases") AS rn
FROM "shopping_trends_copy"
)
SELECT *
FROM duplicate_cte
WHERE rn > 1;


-- Checking if there are any nulls

SELECT *
FROM "shopping_trends_copy"
WHERE "Customer_ID" IS NULL
OR "Age" IS NULL
OR "Gender" IS NULL
OR "Item_Purchased" IS NULL
OR "Category" IS NULL
OR  "Purchase_Amount (USD)" IS NULL
OR "Location" IS NULL
OR "Size"  IS NULL
OR "Color"  IS NULL
OR "Season" IS NULL
OR "Review_Rating" IS NULL
OR "Subscription_Status" IS NULL
OR "Payment_Method" IS NULL
OR "Shipping_Type" IS NULL
OR "Discount_Applied" IS NULL
OR "Promo_Code_used"  IS NULL
OR "Previous_Purchases"  IS NULL
OR "Preferred_Payment_Method" IS NULL
OR "Frequency_of_Purchases"  IS NULL;



-- Checking if there are any blanks

SELECT *
FROM "shopping_trends_copy"
WHERE "Gender" = ''
OR "Item_Purchased" = ''
OR "Category" = ''
OR "Location" = ''
OR "Size" = ''
OR "Color" = ''
OR "Season" = ''
OR "Payment_Method" = ''
OR "Shipping_Type" = ''
OR "Preferred_Payment_Method" = ''
OR "Frequency_of_Purchases" = '';


-- Analyzing the data


-- [1] Total customers

SELECT 
      COUNT(DISTINCT "Customer_ID") AS total_customers
FROM "shopping_trends_copy";


-- [2] Top spending customers

SELECT 
      DISTINCT "Customer_ID" ,
      SUM("Purchase_Amount (USD)") AS total_spent
FROM "shopping_trends_copy"
GROUP BY "Customer_ID"
ORDER BY total_spent DESC
LIMIT 10;


-- [3] Average Spent by customers

SELECT 
      DISTINCT "Customer_ID" ,
      ROUND(AVG("Purchase_Amount (USD)"), 2) AS  avg_spent
FROM "shopping_trends_copy"
GROUP BY "Customer_ID"
ORDER BY avg_spent DESC;


-- [4] Total Spent and Customer Count by Subscription Status

SELECT 
       "Subscription_Status",
        COUNT(DISTINCT"Customer_ID") AS  customer_count,
        SUM("Purchase_Amount (USD)") AS total_spent
FROM "shopping_trends_copy"
GROUP BY "Subscription_Status"
ORDER BY total_spent DESC;


-- [5] Average Spent by Subscription Status

SELECT 
       "Subscription_Status",
        ROUND(AVG("Purchase_Amount (USD)"), 2) AS  avg_spent
FROM "shopping_trends_copy"
GROUP BY "Subscription_Status"
ORDER BY avg_spent DESC;


-- [6] Customer demographics (by gender & age group)

SELECT "Gender",
       CASE 
         WHEN "Age" < 25 THEN 'Under 25'
         WHEN "Age" BETWEEN 25 AND 40 THEN '25-40'
         WHEN "Age" BETWEEN 41 AND 60 THEN '41-60'
         ELSE '60+' END AS age_group,
       COUNT(*) AS customer_count
FROM "shopping_trends_copy"
GROUP BY "Gender", age_group
ORDER BY customer_count DESC;


-- [7] Total Spent and Customer Count by Age

SELECT 
      "Age",
       COUNT(DISTINCT"Customer_ID") AS  customer_count,
       SUM("Purchase_Amount (USD)") AS  total_spent
FROM "shopping_trends_copy"
GROUP BY "Age"
ORDER BY  total_spent DESC;


-- [8] Average Spent and Customer Count by Gender

SELECT 
     "Gender",
      COUNT(DISTINCT"Customer_ID") AS  customer_count,
      ROUND(AVG("Purchase_Amount (USD)"), 2) AS  avg_spent
FROM "shopping_trends_copy"
GROUP BY "Gender"
ORDER BY avg_spent DESC;


-- [9] Total Spent and Customer Count by Gender

SELECT 
     "Gender",
      COUNT(DISTINCT"Customer_ID") AS  customer_count,
      SUM("Purchase_Amount (USD)") AS  totalspent
FROM "shopping_trends_copy"
GROUP BY "Gender"
ORDER BY totalspent DESC;


-- [10] Total spent and Customer Count by Gender and Subscription Status

SELECT 
      "Gender",
      "Subscription_Status",
      COUNT(DISTINCT"Customer_ID") AS  customer_count,
      SUM("Purchase_Amount (USD)") AS  total_spent
FROM "shopping_trends_copy"
GROUP BY "Gender" , "Subscription_Status"
ORDER BY  total_spent DESC;


-- [11] Total Sales and Quantity by Category

SELECT
      "Category",
      COUNT(*) AS quantity,
      SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Category"
ORDER BY total_sales DESC;


-- [12] Total Sales and Quantity by Location and Category

SELECT
     "Location",
     "Category",
     COUNT(*) AS quantity,
     SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Location","Category"
ORDER BY "Location","Category" ,total_sales DESC;


-- [13] Popular colors per category

SELECT 
       "Category",
	   "Color",
       COUNT(*) AS quantity
FROM "shopping_trends_copy"
GROUP BY "Category" , "Color"
ORDER BY "Category", quantity  DESC;


--  [14] Total Sales and Quantity by Items

SELECT
      "Item_Purchased",
      COUNT(*) AS quantity,
      SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Item_Purchased"
ORDER BY total_sales DESC;


--  [15] Total Sales and Quantity by Category and Items

SELECT
      "Category",
      "Item_Purchased",
       COUNT(*) AS quantity,
       SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Category" , "Item_Purchased"
ORDER BY "Category", total_sales DESC ;


-- [16] Customer Count by Location

SELECT
      "Location",
      COUNT(DISTINCT"Customer_ID") AS  customer_count
FROM "shopping_trends_copy"
GROUP BY "Location"
ORDER BY  customer_count DESC ;


-- [17] Total Sales and Transaction count by Location

SELECT
      "Location",
	  COUNT(*) AS transaction_count ,
      SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Location"
ORDER BY total_sales DESC ;


-- [18] Quantity of Items by Location and Category

SELECT
      "Location",
      "Category",
       COUNT(*) AS items_count
FROM "shopping_trends_copy"
GROUP BY "Location" , "Category"
ORDER BY "Location" , items_count DESC ;


-- [19] Quantity of Items by Location and Item name

SELECT
      "Location",
      "Item_Purchased",
       COUNT(*) AS items_count
FROM "shopping_trends_copy"
GROUP BY "Location" , "Item_Purchased"
ORDER BY "Location" , items_count DESC ;


-- [20] Total Sales by Season

SELECT
      "Season",
       SUM("Purchase_Amount (USD)") as total_sales
FROM "shopping_trends_copy"
GROUP BY "Season"
ORDER BY total_sales DESC;


-- [21] Total Sales by Season and Location

SELECT
      "Location",
      "Season",
       SUM("Purchase_Amount (USD)") as total_sales
FROM "shopping_trends_copy"
GROUP BY "Location" , "Season"
ORDER BY "Location", total_sales DESC;


-- [22] Customer Count by Season

SELECT
      "Season",
      COUNT(DISTINCT"Customer_ID") AS  customer_count
FROM "shopping_trends_copy"
GROUP BY "Season"
ORDER BY customer_count DESC;


-- [23] Classifying Items by their Review Rating and adding the new column

SELECT
"Review_Rating",
CASE
WHEN "Review_Rating" < 3 THEN 'Bad'
WHEN "Review_Rating" BETWEEN 3 and 4 THEN 'Good'
ELSE 'Excellent'
END AS  review_rating_class
FROM "shopping_trends_copy"
ORDER BY "Review_Rating";


ALTER TABLE "shopping_trends_copy"
ADD COLUMN review_rating_class VARCHAR(50);

UPDATE "shopping_trends_copy"
SET review_rating_class =(
CASE
WHEN "Review_Rating" < 3 THEN 'Bad'
WHEN "Review_Rating" BETWEEN 3 and 4 THEN 'Good'
ELSE 'Excellent'
END 
)


-- [24] Customer Count by Frequency of Purchases

SELECT
      "Frequency_of_Purchases",
      COUNT(DISTINCT"Customer_ID") AS  customer_count
FROM "shopping_trends_copy"
GROUP BY "Frequency_of_Purchases"
ORDER BY customer_count DESC;


-- [25] Count of Transactions by Payment Method

SELECT
      "Payment_Method",
      COUNT(*) as transaction_count
FROM "shopping_trends_copy"
GROUP BY "Payment_Method"
ORDER BY  transaction_count DESC;


-- [26] Count of Transactions by Shipping Type

SELECT
      "Shipping_Type",
      COUNT(*) as transaction_count
FROM "shopping_trends_copy"
GROUP BY "Shipping_Type"
ORDER BY transaction_count DESC;


-- [27] Impact of discounts

SELECT
       "Discount_Applied",
	    COUNT(*) AS orders,
        SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Discount_Applied"
ORDER BY total_sales DESC;


-- [28] Promo code effectiveness

SELECT 
       "Promo_Code_used",
	    COUNT(*) AS orders,
       SUM("Purchase_Amount (USD)") AS total_sales
FROM "shopping_trends_copy"
GROUP BY "Promo_Code_used"
ORDER BY total_sales DESC;


-- [29] Count of Transactions by Preferred Payment Method

SELECT
      "Preferred_Payment_Method",
       COUNT(*) as transaction_count
FROM "shopping_trends_copy"
GROUP BY "Preferred_Payment_Method"
ORDER BY transaction_count DESC;


-- [30] Preferred Payment Method by Gender

SELECT
      "Gender",
      "Preferred_Payment_Method",
      COUNT(*) as transaction_count
FROM "shopping_trends_copy"
GROUP BY "Gender", "Preferred_Payment_Method"
ORDER BY  transaction_count DESC;







