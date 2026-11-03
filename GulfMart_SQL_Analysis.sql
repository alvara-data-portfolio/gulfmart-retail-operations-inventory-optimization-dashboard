-- Query 1: Preview Sales Data
SELECT *
FROM Sales
LIMIT 10;

-- Query 2: Sales Performance by Channel
SELECT 
    SalesChannel,
    COUNT(*) AS TotalSalesTransactions,
    ROUND(SUM(SalesAmountAED), 2) AS TotalSalesAED
FROM Sales
GROUP BY SalesChannel
ORDER BY TotalSalesAED DESC;

-- Query 3: Sales Performance by Branch
SELECT 
    BranchID,
    COUNT(*) AS TotalTransactions,
    ROUND(SUM(SalesAmountAED), 2) AS TotalSalesAED
FROM Sales
GROUP BY BranchID
ORDER BY TotalSalesAED DESC;

-- Query 4: Top 10 Products by Sales
SELECT 
    ProductID,
    ROUND(SUM(SalesAmountAED), 2) AS TotalSalesAED
FROM Sales
GROUP BY ProductID
ORDER BY TotalSalesAED DESC
LIMIT 10;

-- Query 5: Monthly Sales Trend
SELECT 
    strftime('%Y-%m', OrderDate) AS SalesMonth,
    ROUND(SUM(SalesAmountAED), 2) AS TotalSalesAED
FROM Sales
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY SalesMonth;

-- Query 6: Sales Performance by Product Category
SELECT 
    p.Category,
    COUNT(s.SalesLineID) AS TotalTransactions,
    ROUND(SUM(s.SalesAmountAED), 2) AS TotalSalesAED
FROM Sales s
JOIN Products p 
    ON s.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalSalesAED DESC;

-- Query 7: Top 10 Products with Product Names
SELECT 
    p.ProductName,
    p.Category,
    ROUND(SUM(s.SalesAmountAED), 2) AS TotalSalesAED
FROM Sales s
JOIN Products p
    ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category
ORDER BY TotalSalesAED DESC
LIMIT 10;

-- Query 8: Inventory Status by Branch

SELECT
    BranchID,
    COUNT(*) AS TotalProducts,
    SUM(StockOnHand) AS TotalStock
FROM Inventory
GROUP BY BranchID
ORDER BY TotalStock ASC;

-- Query 9: Low Stock Products

SELECT
    ProductID,
    BranchID,
    StockOnHand,
    ReorderLevel
FROM Inventory
WHERE StockOnHand <= ReorderLevel
ORDER BY StockOnHand ASC;

-- Query 10: Low Stock Products by Branch

SELECT
    BranchID,
    COUNT(*) AS LowStockProducts
FROM Inventory
WHERE StockOnHand <= ReorderLevel
GROUP BY BranchID
ORDER BY LowStockProducts DESC;

-- Query 11: Inventory Value by Branch

SELECT
    BranchID,
    ROUND(SUM(StockOnHand * UnitCostAED), 2) AS TotalInventoryValueAED
FROM Inventory
GROUP BY BranchID
ORDER BY TotalInventoryValueAED DESC;

-- Query 12: Purchase Order Analysis

SELECT 
    s.SupplierName,
    COUNT(DISTINCT po.PurchaseOrderID) AS TotalPurchaseOrders,
    ROUND(SUM(po.PurchaseOrderValueAED), 2) AS TotalPurchaseValueAED
FROM PurchaseOrders po
JOIN Suppliers s
    ON po.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY TotalPurchaseValueAED DESC;


-- Query 13: Supplier Performance Analysis

SELECT 
    s.SupplierName,
    COUNT(DISTINCT po.PurchaseOrderID) AS TotalPurchaseOrders,
    ROUND(SUM(po.PurchaseOrderValueAED), 2) AS TotalPurchaseValueAED
FROM PurchaseOrders po
JOIN Suppliers s
    ON po.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY TotalPurchaseValueAED DESC;

-- Query 14: Delivery Performance Analysis

SELECT 
    DeliveryStatus,
    COUNT(*) AS TotalOrders
FROM PurchaseOrders
GROUP BY DeliveryStatus
ORDER BY TotalOrders DESC;

-- Query 15: Check Inventory Records by Branch

SELECT 
    BranchID,
    COUNT(*) AS TotalInventoryRecords,
    SUM(StockOnHand) AS TotalStockOnHand
FROM Inventory
GROUP BY BranchID
ORDER BY BranchID;