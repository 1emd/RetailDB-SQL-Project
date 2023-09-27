2.1. Получение информации о сумме товаров, заказанных для каждого клиента:
SELECT Customers.Name AS "Customer Name", SUM(Products.Price * OrderItems.Quantity) AS "Total"
FROM Customers
INNER JOIN Orders ON Customers.ID = Orders.Customer_ID
INNER JOIN OrderItems ON Orders.ID = OrderItems.Order_ID
INNER JOIN Products ON OrderItems.Product_ID = Products.ID
GROUP BY Customers.Name;

2.2. Найти количество дочерних элементов первого уровня вложенности для категорий номенклатуры:
SELECT Categories.Name, COUNT(DISTINCT Products.ID) AS "Count"
FROM Categories
LEFT JOIN Categories AS ParentCategories ON Categories.ID = ParentCategories.Parent_Category
LEFT JOIN Products ON (ParentCategories.ID IS NULL AND Products.Category_ID = Categories.ID) OR (ParentCategories.ID IS NOT NULL AND Products.Category_ID = ParentCategories.ID)
GROUP BY Categories.Name;
