# 🛒 Customer Purchase Behavior Analyzer

## 🎯 Objective

Conduct **Data Preprocessing and Feature Engineering** on a real-world dataset.

The aim is to **understand, clean, transform, and analyze** the dataset before it can be used for machine learning.

This project emphasizes **data profiling, handling multiple formats, and performing EDA**.

---

## 📄 Problem Statement

The dataset contains **customer purchase behavior** collected from multiple sources:

- CSV
- JSON
- SQL Database

The goal is to **frame a machine learning problem** (predict customer spending behavior / churn risk) and perform **data preprocessing and profiling** to make the dataset ML-ready.

Applied concepts of **data analysis, data cleaning, outlier handling, feature engineering, and exploratory data analysis (EDA)** to extract insights.

---

# 📂 Project Files

| 📄 File | 📌 Description |
|---------|----------------|
| 📓 **customer_purchase_behavior_analyzer.ipynb** | Main Jupyter Notebook |
| 📊 **users.csv** | Customer Dataset (200 × 6) |
| 📄 **sales.json** | Transaction Records (1000 × 6) |
| 🗄️ **inventory.sql** | SQL Product Table (50 × 5) |
| 📦 **final_cleaned_dataset.csv** | Final ML-Ready Dataset (1000 × 44) |
| 🌐 **eda_report.html** | Auto-Generated Profiling Report |
| 📑 **README.md** | Project Documentation |

---

[![▶ Watch Video](https://img.shields.io/badge/▶%20Watch%20Video-4285F4?style=for-the-badge&logo=google-drive&logoColor=white)](https://drive.google.com/file/d/105owbjKRvUrn78amJytR0mLc5PKPeUdj/view?usp=sharing)


---

## 🛠️ Tools Used

<div>

<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"/>
<img src="https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white"/>
<img src="https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white"/>
<img src="https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white"/>
<img src="https://img.shields.io/badge/JSON-000000?style=for-the-badge&logo=json&logoColor=white"/>
<img src="https://img.shields.io/badge/SQLite3-003B57?style=for-the-badge&logo=sqlite&logoColor=white"/>
<img src="https://img.shields.io/badge/SciPy-8CAAE6?style=for-the-badge&logo=scipy&logoColor=white"/>
<img src="https://img.shields.io/badge/scikit_learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white"/>
<img src="https://img.shields.io/badge/ydata_profiling-FF4088?style=for-the-badge&logo=python&logoColor=white"/>

</div>

---

## 📌 Project Overview

| Item | Value |
|---|---|
| Data sources | `users.csv`, `sales.json`, `inventory.sql` |
| Raw shapes | Users `200 × 6`, Sales `1000 × 6`, Products `50 × 5` |
| Final dataset | `1000 rows × 44 columns` |
| New features created | 24 |
| Output files | `final_cleaned_dataset.csv`, `eda_report.html` |

---

#### 🛠️ Imported Libraries

```python
import pandas as pd
import numpy as np
import json
import sqlite3
from scipy import stats
from scipy.stats.mstats import winsorize
from sklearn.impute import SimpleImputer, KNNImputer
from sklearn.preprocessing import StandardScaler, MinMaxScaler, LabelEncoder, OrdinalEncoder
from ydata_profiling import ProfileReport
```

---

## 📊 Part A : Fundamentals

Framed the ML problem, identified the target behavior (customer spend tier / churn risk), and documented the data dictionary for all three sources before touching the data.

---

## 📶 Part B : Data Acquisition

### 1️⃣ Import datasets from different sources :

- 📂 Load CSV file using pandas .
- 🗂️ Parse a JSON file .
- 🔗 Connect to a SQL table and fetch records .

```python
import pandas as pd
df_users = pd.read_csv("users.csv")
print(df_users.shape)
df_users.head()
---------------------------------------------------------
import json
with open("sales.json") as file_obj:
    sales_records = json.load(file_obj)
df_sales = pd.json_normalize(sales_records)
df_sales.info()
---------------------------------------------------------
import sqlite3
conn = sqlite3.connect(":memory:")
conn.executescript(open("inventory.sql").read())
df_products = pd.read_sql_query("SELECT * FROM products", conn)
df_products.head()
```

##### 📊 Insight: All three sources load cleanly — `amount` is numeric and `date` is already `datetime64`.

---

### 🗂️ Merged the data :-

```python
combined_df = (
    df_sales
    .merge(df_products, on="product_id", how="left")
    .merge(df_users, on="user_id", how="left")
)
combined_df.info()
```

---

## 🧹 Part C : Data Understanding & Cleaning

### 2️⃣ Perform initial exploration :

- 📝 Use .head() , .info() , .describe() to explore
- 🔍 Identify missing values and duplicates

```python
print(combined_df.head())
print(combined_df.info())
print(combined_df.describe(include="all"))
print(combined_df.isnull().sum())
print(combined_df.duplicated().sum())
```

### 3️⃣ Apply data cleaning.

- 🔍 Handle missing data.
- 🧠 Correct inconsistent data types.
- 🗑️ Drop duplicates and invalid entries.

```python
num_imputer = SimpleImputer(strategy="mean")
combined_df[["amount", "price", "stock", "age"]] = num_imputer.fit_transform(
    combined_df[["amount", "price", "stock", "age"]]
)

cat_imputer = SimpleImputer(strategy="most_frequent")
combined_df[["gender", "city", "payment_type", "category"]] = cat_imputer.fit_transform(
    combined_df[["gender", "city", "payment_type", "category"]]
)

knn = KNNImputer(n_neighbors=5)
combined_df[["amount"]] = knn.fit_transform(combined_df[["amount"]])

combined_df["date"] = pd.to_datetime(combined_df["date"], errors="coerce")
combined_df.loc[combined_df["amount"] < 0, "amount"] = combined_df["amount"].mean()
combined_df = combined_df.drop_duplicates()

print("After cleaning:", combined_df.shape)
```

##### 🧠 Insight: Raw data was already clean — 0 missing values, 0 negatives, 0 duplicates.
##### ✅ Conclusion: Imputation steps act as a safety net for future data refreshes.

---

### 4️⃣ Outlier Handling

| Method | Outliers in `amount` |
|---|---|
| Z-score (>3) | 15 |
| IQR (1.5×) | 53 |

```python
z = np.abs(stats.zscore(combined_df["amount"]))
print("Z-score outliers:", (z > 3).sum())

q1, q3 = combined_df["amount"].quantile([0.25, 0.75])
iqr = q3 - q1
mask = (combined_df["amount"] < q1 - 1.5 * iqr) | (combined_df["amount"] > q3 + 1.5 * iqr)
print("IQR outliers:", mask.sum())

combined_df["amount"] = winsorize(combined_df["amount"], limits=[0.01, 0.01])
combined_df["price"] = winsorize(combined_df["price"], limits=[0.01, 0.01])
```

##### 📦 Insight: **IQR** was chosen because purchase amounts are right-skewed and Z-score assumes normality.
##### ✅ Conclusion: Winsorization at the 1st/99th percentile capped extremes without deleting a single row.

---

## 🧮 Part D : Data Transformation & Feature Engineering

### 5️⃣ Encoding & Skewness Treatment

- Date splitting → `sale_day/month/year`, `reg_day/month/year`.
- **Label Encoding** for binary flags (e.g. `is_wallet_payment`).
- **One-Hot / Ordinal Encoding** for nominal and ordered categories.

| Column | Skewness |
|---|---|
| `amount` | ≈ 1.49 |
| `amount_sqrt` | ≈ 0.76 |
| `amount_log` | ≈ 0.065 ✅ best |

```python
combined_df["amount_sqrt"] = np.sqrt(combined_df["amount"])
combined_df["amount_log"] = np.log1p(combined_df["amount"])
print(combined_df[["amount", "amount_sqrt", "amount_log"]].skew())
```

##### 📈 Insight: Log transformation reduced skewness from 1.49 to 0.065.
##### ✅ Conclusion: `amount_log` is the most model-friendly version of the spend variable.

---

### 6️⃣ Feature Scaling

```python
combined_df["amount_standard_scaled"] = StandardScaler().fit_transform(combined_df[["amount"]])
combined_df["amount_minmax_scaled"] = MinMaxScaler().fit_transform(combined_df[["amount"]])
print(combined_df[["amount_standard_scaled", "amount_minmax_scaled"]].describe())
```

##### 📊 Insight: `StandardScaler` → mean ≈ 0 with unit variance; `MinMaxScaler` → clean 0–1 range.

---

### 7️⃣ Feature Construction (RFM-style)

- `purchase_frequency` — transactions per customer.
- `avg_monthly_spend` — total spend ÷ active months.
- `days_since_last_purchase` — recency vs. latest date in data.
- `spend_<category>` — category-wise total expenditure per customer.
- `spending_group` (+ encoded) — customer spend tier.

```python
freq = combined_df.groupby("user_id")["amount"].count().rename("purchase_frequency")
recency = (combined_df["date"].max() - combined_df.groupby("user_id")["date"].max()).dt.days
combined_df = combined_df.merge(freq, on="user_id").merge(
    recency.rename("days_since_last_purchase"), on="user_id"
)
combined_df["spending_group"] = pd.qcut(
    combined_df["amount"], 3, labels=["Low", "Medium", "High"]
)
```

##### 🧠 Insight: 24 engineered features add behavioral, temporal, and categorical depth beyond the raw inputs.

---

### 8️⃣ Final Dataset Preparation

```python
combined_df.to_csv("final_cleaned_dataset.csv", index=False)
print("Final shape:", combined_df.shape)
```

##### ✅ Conclusion: Final dataset (**1000 × 44**) is clean, feature-rich, and ready for modeling.

---

## 🧮 Part E : Data Profiling

### 9️⃣ Generate a Profiling Report that summarizes:

- Missing Values.
- Descriptive stat.
- Correlations.
- Warnings on potential data quality issues.

```python
from ydata_profiling import ProfileReport
report = ProfileReport(combined_df, title="Customer Purchase Profiling Report", explorative=True)
report.to_file("eda_report.html")
print("Report saved.")
```

---

## 📂 Project Workflow

1. **Data Acquisition** → Import data from CSV, JSON, and SQL
2. **Data Cleaning** → Handle missing values, duplicates, and inconsistencies
3. **Outlier Handling** → Z-score vs IQR comparison + winsorization
4. **Feature Engineering** → Encoding, skewness fixes, scaling, RFM features
5. **Data Profiling** → Generate profiling report for better understanding
6. **Problem Framing** → Define ML task (spend tier / churn prediction)

---

## 📈 Results & Insights

- ✅ Raw data was already clean — imputation steps were precautionary
- 📉 IQR outperformed Z-score for this right-skewed spend distribution
- ✨ Log transformation was the most effective skewness fix (1.49 → 0.065)
- 🧠 24 engineered features covering recency, frequency, and monetary behavior
- 🚀 Final dataset (**1000 × 44**) exported as `final_cleaned_dataset.csv`

---

## 📌 Expected Outcomes

- A **structured dataset** ready for machine learning models
- **EDA visualizations** (distributions, correlations, category comparisons)
- **Profiling report** generated via `ydata_profiling`
- Documentation of **data cleaning and preprocessing steps**

---

## ⚙️ Installation & Setup

Clone the repository and install dependencies:

```bash
git clone https://github.com/yourusername/customer-purchase-behavior-analyzer.git
cd customer-purchase-behavior-analyzer
pip install pandas numpy scipy scikit-learn ydata-profiling
```

Run the notebook:

```bash
jupyter notebook customer_purchase_behavior_analyzer.ipynb
```

Keep `users.csv`, `sales.json`, and `inventory.sql` in the same folder as the notebook.

---

## 📂 Suggested Structure

```text
.
├── customer_purchase_behavior_analyzer.ipynb
├── users.csv
├── sales.json
├── inventory.sql
├── final_cleaned_dataset.csv   # generated
└── eda_report.html             # generated
```

---

## 🙏 Thank You

Thank you for taking the time to explore this project!

Your feedback, suggestions, and contributions are always welcome.

⭐ If you found this project helpful, don’t forget to **star the repository** and share it with others.
