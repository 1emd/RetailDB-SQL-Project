# Проект по проектированию базы данных и SQL запросам

## Описание
Этот проект был выполнен с целью проектирования базы данных и написания SQL запросов для управления бизнес-операциями. Задачи проекта включают в себя создание сущностей, описывающих номенклатуру товаров, категории товаров, клиентов и заказы. Кроме того, были разработаны SQL запросы для получения информации о заказах и количестве дочерних элементов вложенности для категорий номенклатуры.

## Структура базы данных

### Таблица "Products":
- **ID (Primary Key):** Уникальный идентификатор товара
- **Name:** Название товара
- **Quantity:** Количество в наличии
- **Price:** Цена товара

### Таблица "Categories":
- **ID (Primary Key):** Уникальный идентификатор категории
- **Name:** Название категории
- **Parent Category ID (Foreign Key):** Ссылка на ID родительской категории или NULL, если родительской категории нет

### Таблица "Customers":
- **ID (Primary Key):** Уникальный идентификатор клиента
- **Name:** Имя клиента
- **Address:** Адрес клиента

### Таблица "Orders":
- **ID (Primary Key):** Уникальный идентификатор заказа
- **Customer ID (Foreign Key):** Ссылка на ID клиента из таблицы "Customers"

### Таблица "OrderItems":
- **ID (Primary Key):** Уникальный идентификатор элемента заказа
- **Order ID (Foreign Key):** Ссылка на ID заказа из таблицы "Orders"
- **Product ID (Foreign Key):** Ссылка на ID товара из таблицы "Products"
- **Quantity:** Количество данного товара в заказе

## SQL Запросы
В файле `SQL_Queries.sql` содержится код SQL запросов.

SQL запросы для получения информации о заказах:

**Запрос 1:** Получение информации о сумме товаров, заказанных каждым клиентом

```sql
SELECT Customers.Name AS "Customer Name", SUM(Products.Price * OrderItems.Quantity) AS "Total"
FROM Customers
INNER JOIN Orders ON Customers.ID = Orders.Customer_ID
INNER JOIN OrderItems ON Orders.ID = OrderItems.Order_ID
INNER JOIN Products ON OrderItems.Product_ID = Products.ID
GROUP BY Customers.Name;
```

**Запрос 2:** Нахождение количества дочерних элементов первого уровня вложенности для категорий номенклатуры

```sql
SELECT Categories.Name, COUNT(DISTINCT Products.ID) AS "Count"
FROM Categories
LEFT JOIN Categories AS ParentCategories ON Categories.ID = ParentCategories.Parent_Category
LEFT JOIN Products ON (ParentCategories.ID IS NULL AND Products.Category_ID = Categories.ID) OR (ParentCategories.ID IS NOT NULL AND Products.Category_ID = ParentCategories.ID)
GROUP BY Categories.Name;
```

## Примеры результатов
Пример результатов выполнения SQL запросов:

**Запрос 1:**

| Имя клиента | Общая сумма заказа |
|-------------|---------------------|
| Клиент 1    | 2500                |
| Клиент 2    | 3500                |
| Клиент 3    | 1200                |

**Запрос 2:**

| Наименование категории | Количество товаров |
|------------------------|--------------------|
| Категория 1            | 5                  |
|   - Подкатегория 1.1   | 2                  |
|   - Подкатегория 1.2   | 3                  |
| Категория 2            | 3                  |
|   - Подкатегория 2.1   | 1                  |
|   - Подкатегория 2.2   | 2                  |
| Категория 3            | 0                  |

### Автор:
[Кирилл Хорошилов](https://github.com/1emd)