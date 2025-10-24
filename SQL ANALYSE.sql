CREATE TABLE customers (
    customerID TEXT,
    gender TEXT,
    SeniorCitizen INTEGER,
    Partner TEXT,
    Dependents TEXT,
    tenure INTEGER,
    PhoneService TEXT,
    MultipleLines TEXT,
    InternetService TEXT,
    OnlineSecurity TEXT,
    OnlineBackup TEXT,
    DeviceProtection TEXT,
    TechSupport TEXT,
    StreamingTV TEXT,
    StreamingMovies TEXT,
    Contract TEXT,
    PaperlessBilling TEXT,
    PaymentMethod TEXT,
    MonthlyCharges NUMERIC,
    TotalCharges TEXT,
    Churn TEXT
);
UPDATE customers
SET TotalCharges = NULL
WHERE TotalCharges = ' ';
ALTER TABLE customers
ALTER COLUMN TotalCharges TYPE NUMERIC
USING TotalCharges::NUMERIC;
SELECT *
FROM customers
LIMIT 100;

SELECT
  Churn,
  COUNT(*) AS total_customers,
  ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers)), 2) AS percentage
FROM customers
GROUP BY Churn;

SELECT
  Contract,
  COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_count,
  COUNT(*) AS total_count,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

SELECT
  InternetService,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
WHERE InternetService != 'No'
GROUP BY InternetService;

SELECT
  Churn,
  AVG(tenure) AS avg_tenure_months,
  AVG(MonthlyCharges) AS avg_monthly_charge
FROM customers
GROUP BY Churn;

SELECT
  PaymentMethod,
  COUNT(*) AS total_customers,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_percent DESC;

SELECT
  TechSupport,
  COUNT(*) AS total_customers,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY TechSupport
ORDER BY churn_rate_percent DESC;

SELECT
  OnlineSecurity,
  COUNT(*) AS total_customers,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY OnlineSecurity
ORDER BY churn_rate_percent DESC;


SELECT
 OnlineBackup,
  COUNT(*) AS total_customers,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY OnlineBackup
ORDER BY churn_rate_percent DESC;


SELECT
  (CASE
    WHEN MonthlyCharges >= (SELECT AVG(MonthlyCharges) FROM customers) THEN 'High-Value Customer'
    ELSE 'Low-Value Customer'
  END) AS customer_segment,
  
  COUNT(*) AS total_customers,
  ROUND(AVG(MonthlyCharges), 2) AS avg_charge,
  ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
  
FROM customers
GROUP BY customer_segment;

SELECT
    Dependents,
    COUNT(*) AS total_customers,
    ROUND((COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*)), 2) AS churn_rate_percent
FROM customers
GROUP BY Dependents;