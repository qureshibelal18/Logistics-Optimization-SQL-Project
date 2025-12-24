# 📦 Logistics Optimization for Delivery Routes (Amazon Case Study)

A SQL-based logistics analytics project designed to analyze delivery delays, optimize delivery routes, evaluate warehouse and delivery agent performance, and generate actionable business insights using real-world logistics data inspired by Amazon.

---

## 🎯 Project Objectives

- Analyze delivery delays and traffic impact  
- Identify inefficient delivery routes  
- Evaluate warehouse processing performance  
- Measure delivery agent efficiency  
- Generate KPIs for logistics decision-making  

---

## 🛠️ Tools & Technologies

- SQL (MySQL compatible)
- Advanced SQL Concepts:
  - Joins
  - Aggregations
  - Subqueries
  - Common Table Expressions (CTEs)
  - Window Functions (RANK, ROW_NUMBER)
  - Date Functions
  - Data Cleaning Techniques

---

## 🗂️ Database Tables

- Orders  
- Routes  
- Warehouses  
- DeliveryAgents  
- Shipment_Tracking  

---

## 📌 Tasks & Analysis

### Task 1: Data Cleaning & Preparation
- Checked and validated duplicate Order_IDs  
- Replaced NULL traffic delays with route-level averages  
- Converted all date columns to YYYY-MM-DD format  
- Flagged invalid records where delivery date was before order date  

---

### Task 2: Delivery Delay Analysis
- Calculated delivery delay (in days) for each order  
- Identified top 10 most delayed routes  
- Ranked orders by delay within each warehouse using window functions  

---

### Task 3: Route Optimization Insights
- Calculated:
  - Average delivery time per route  
  - Average traffic delay  
  - Distance-to-time efficiency ratio  
- Identified:
  - Least efficient routes  
  - Routes with more than 20% delayed shipments  
- Used CTEs to flag high-priority routes for optimization  

---

### Task 4: Warehouse Performance Analysis
- Identified top 3 warehouses with highest processing time  
- Calculated total vs delayed shipments per warehouse  
- Detected bottleneck warehouses using global averages  
- Ranked warehouses by on-time delivery percentage  

---

### Task 5: Delivery Agent Performance
- Ranked agents per route by on-time delivery percentage  
- Identified agents with on-time delivery below 80%  
- Compared average speed of top 5 and bottom 5 delivery agents  

---

### Task 6: Shipment Tracking Analytics
- Identified last checkpoint for each order  
- Found most common delay reasons  
- Flagged orders with more than two delayed checkpoints  

---

### Task 7: Advanced KPI Reporting
- Average delivery delay per region  
- Global on-time delivery percentage  
- Average traffic delay per route  

---

## 📊 Key Business Insights

- Certain routes show consistently high delays and low efficiency  
- Warehouse processing time directly impacts delivery performance  
- Significant performance gap exists between top and bottom delivery agents  
- Recurrent delay reasons indicate systemic operational issues  

---

## 📽️ Project Walkthrough

Loom Video:  
https://www.loom.com/share/81aeb8bf5bc54c7dbb84299f8565b010

---

## 📚 Skills Demonstrated

- SQL for Data Analytics  
- Business Problem Solving  
- Performance Optimization Analysis  
- KPI Reporting  
- Real-World Logistics Case Study  

---

## 👤 Author

**Md Belal**  
Computer Science Undergraduate  
Aspiring Data Analyst / Data Scientist  

---

⭐ If you find this project useful, feel free to star the repository!
