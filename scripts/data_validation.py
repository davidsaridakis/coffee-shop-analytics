"""
Data validation script for the coffee shop sales dataset.

Purpose:
Validate data quality before exploratory analysis by checking:
        - dataset structure and data types
        - duplicate records
        - unit price integrity
        - transaction date and time coverage
        - transaction quantities anomalies

Dataset:
Coffee Shop Sales (source: Kaggle)
"""

# import libraries
import pandas as pd
from pathlib import Path

# Establish path and load data file
BASE_DIR = Path(__file__).resolve().parent.parent
data_file = BASE_DIR / "data" / "coffee_shop_sales.xlsx"

df = pd.read_excel(data_file)


# Dataset-level sanity check
print("Shape:\n", df.shape)
print("Column names:\n", df.columns)
print("Data types:\n", df.dtypes)
print("Number of duplicate rows:\n", df.duplicated().sum())
print("\n") 
df.info()


# Column-level sanity checks

# --- Unit Price ---
print("\nUNIT PRICE")
print(
    df['unit_price'].agg(['min', 'max', 'mean']).round(2)
)

print("\nNegative or zero priced product(s):",
      (df['unit_price'] <= 0).sum())

print(
    "\nHighest proed product(s):",
    df.loc[
        df['unit_price'] == df['unit_price'].max(), 
        "product_detail"
    ].unique()
)

print(
    "\nLowest priced prodcut(s):",
    df.loc[
        df['unit_price'] == df['unit_price'].min(),
        "product_detail"
    ].unique()
)


# --- Dates and Times ---
print("\nDATES AND TIMES")

date_time_cols = ['transaction_date', 'transaction_time']
for col in date_time_cols:
    print(f"\n{col.upper()}")
    print(df[col].agg(['min', 'max', 'nunique']))


# --- Transaction Quantity ---
print("\nTRANSACTION QUANTITY")

print(df['transaction_qty'].agg(['min', 'max', 'mean']).round(2))

print(
    "\nNumber of zero or negative quantities:",
    (df['transaction_qty'] <= 0).sum()
)


print("\nSuspiciously high quantities (>100):",
      (df['transaction_qty'] > 100).sum()
)