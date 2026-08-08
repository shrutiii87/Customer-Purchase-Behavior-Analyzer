# 🛒 Customer Purchase Behavior Analyzer

An end-to-end data preprocessing and feature engineering pipeline built in Python/Pandas that ingests customer, sales, and product data from **three different sources (CSV, JSON, SQL)**, cleans it, handles outliers, engineers RFM-style behavioral features, and exports one analysis-ready dataset.

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

## 🛠️ Tech Stack

- **Python 3**, **Jupyter Notebook**
- `pandas`, `numpy`
- `sqlite3` (SQL source loading)
- `scipy` (Z-score, winsorization)
- `scikit-learn` (`SimpleImputer`, `KNNImputer`, encoders, scalers)
- `ydata-profiling` (optional auto EDA report)

### Installation

```bash
pip install pandas numpy scipy scikit-learn ydata-profiling
```

### Run

```bash
jupyter notebook customer_purchase_behavior_analyzer.ipynb
```

Keep `users.csv`, `sales.json`, and `inventory.sql` in the same folder as the notebook.

---

## 🔄 Pipeline Steps

### 1️⃣ Data Understanding & Loading
- Loads users from CSV, sales from JSON, and products from an in-memory SQLite database built from `inventory.sql`.
- Inspects `head()`, `info()`, dtypes, missing values, and invalid (negative) entries.
- **Result:** all three sources load cleanly; `amount` is numeric and `date` already `datetime64`.

### 2️⃣ Data Cleaning
- **Numerical missing values** → `SimpleImputer(strategy='mean')` on `amount`, `price`, `stock`, `age`.
- **Categorical missing values** → `SimpleImputer(strategy='most_frequent')` on `gender`, `city`, `payment_type`, `category`.
- **Multivariate enhancement** → `KNNImputer(n_neighbors=5)` demonstrated on `amount`.
- **Consistency fixes** → dates parsed with `pd.to_datetime(..., errors='coerce')`, negative values replaced with column means, duplicates dropped.
- **Result:** raw data was already clean — 0 missing values, 0 negatives, 0 duplicates.

### 3️⃣ Outlier Handling
| Method | Outliers in `amount` |
|---|---|
| Z-score (>3) | 15 |
| IQR (1.5×) | 53 |

- **IQR chosen** because purchase amounts are right-skewed and Z-score assumes normality.
- **Winsorization** at the 1st/99th percentile applied to `amount` and `price` to cap extremes without deleting rows (record count preserved).

### 4️⃣ Data Transformation
- Date splitting → `sale_day/month/year`, `reg_day/month/year`.
- **Label Encoding** for binary flags (e.g. `is_wallet_payment`).
- **One-Hot / Ordinal Encoding** for nominal and ordered categories.
- **Skewness treatment:**

| Column | Skewness |
|---|---|
| `amount` | ≈ 1.49 |
| `amount_sqrt` | ≈ 0.76 |
| `amount_log` | ≈ 0.065 ✅ best |

### 5️⃣ Feature Scaling
- `StandardScaler` → mean ≈ 0, unit variance (`amount_standard_scaled`).
- `MinMaxScaler` → 0–1 range (`amount_minmax_scaled`).
- Compared via `describe()` summary statistics.

### 6️⃣ Feature Construction (RFM-style)
- `purchase_frequency` — transactions per customer.
- `avg_monthly_spend` — total spend ÷ active months.
- `days_since_last_purchase` — recency vs. latest date in data.
- `spend_<category>` — category-wise total expenditure per customer.
- `spending_group` (+ encoded) — customer spend tier.

### 7️⃣ Final Dataset Preparation
- Merges sales + products + users, then attaches all engineered customer-level features.
- Prints a summary report: records before/after, features created, missing values before/after, outliers before/after.
- Exports `final_cleaned_dataset.csv`.

### 8️⃣ Bonus
- Auto-generated EDA report via `ydata_profiling.ProfileReport` → `eda_report.html`.

---

## 🏁 Conclusion

- ✅ Raw data was already clean — imputation steps were precautionary.
- 📉 IQR outperformed Z-score for this right-skewed spend distribution; winsorization tamed extremes without shrinking the dataset.
- ✨ Log transformation was the most effective skewness fix.
- 🧠 24 engineered features add behavioral, temporal, and categorical depth beyond the raw inputs.
- 🚀 Final dataset (**1000 × 44**) is clean, feature-rich, and ready for analytics or ML modeling.

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
