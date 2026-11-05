# Ecommerce Sales & Customer Analytics

An end-to-end data analytics project: raw sales data is cleaned with **Python**, stored and analysed in **MySQL**, and visualised in an interactive **Power BI** dashboard.

**Pipeline:** Raw CSV → Python (pandas) → MySQL → Power BI → Business insights

![Dashboard preview](dashboard/dashboard_preview.png)

## Dataset

Public **Superstore sales** dataset: 9,800 order lines from 2015 to 2018, covering 4,922 orders and 793 customers across 4 US regions and 3 product categories.

## Tools

- **Python** (pandas, SQLAlchemy, PyMySQL) in VS Code notebooks
- **MySQL 8** for storage and analysis
- **Power BI Desktop** for the dashboard

## What I did

1. **Explored and cleaned the data** (pandas)
   - Standardised column names and converted dates from text to real dates
   - Filled 11 missing postal codes and stored postal codes as 5-digit text
   - Added year, month and shipping-time columns
2. **Designed a relational database** (MySQL)
   - Split one wide table into `customers`, `products`, `orders` and `order_items`
   - Defined primary keys and foreign keys
   - Loaded the data with Python and checked row counts and total sales against the source
3. **Analysed the data with SQL**
   - Joins across 3 to 4 tables, `GROUP BY` aggregations and subqueries
   - CTEs and window functions (`RANK`, `NTILE`, `LAG`) for customer ranking and month-over-month growth
4. **Built a Power BI dashboard**
   - KPI cards, monthly trend, sales by region and category, top 10 products
   - Slicers for year, region and customer segment

## Key insights

- **Sales are growing:** total sales rose from about $459K in 2016 to about $722K in 2018.
- **Seasonality:** November, December and September are the strongest months. February is the weakest. The best single month was November 2018 (about $118K).
- **Regions:** West leads with about $710K (31.4% of sales). South is lowest at about $389K.
- **Categories:** Technology is the top category at about 36.6% of sales.
- **Segments:** Consumer brings in the most revenue (about $1.15M), but Home Office customers have the highest average order value ($475 vs $453 for Consumer).
- **Top product:** Canon imageCLASS 2200 Advanced Copier, with about $61.6K in sales.

## Headline numbers

| Total sales | Orders | Customers | Avg order value |
|---|---|---|---|
| $2.26M | 4,922 | 793 | $459.48 |

## Project structure

```
ecommerce-analytics/
├── data/            # raw and cleaned CSV files
├── notebook/        # exploration, cleaning and loading notebooks
├── sql/             # table creation and analysis queries
├── dashboard/       # Power BI file and preview image
└── README.md
```

## How to run

1. Install the libraries: `pip install pandas sqlalchemy pymysql cryptography`
2. Run the notebooks in order: explore and clean, then load to MySQL.
3. Create the tables first with `sql/01_create_tables.sql`.
4. Run the queries in `sql/02_analysis_queries.sql`.
5. Open `dashboard/ecommerce_dashboard.pbix` in Power BI Desktop. It reads `data/powerbi_sales.csv`, which is exported from MySQL.

The database password is entered at run time and is never stored in the code.

## What I learned

- Building an ETL pipeline from raw data to a finished dashboard
- Designing a relational schema and writing joins, CTEs and window functions
- Validating results at every step by checking totals against the source data
