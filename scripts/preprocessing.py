"""
Preprocessing script for the coffee shop sales dataset.

Purpose:
Clean and enrich the dataset, and add feature engineering
    - calculate sales_revenue at row-level
    - create binary flag for weekday / weekend 
    - extract hour from transaction times 

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


# Add row-level sales revenue
df['line_revenue'] = (
    df['transaction_qty'] * df['unit_price']
)

# Add binary flag column for weekend (1=weekend, 0=weekday)
df['is_weekend'] = (
    df['transaction_date']
    .dt.weekday
    .isin([5, 6])
    .astype(int)
)

# Parse transaction times
parsed_times = (pd.to_datetime(
    df['transaction_time'].astype(str),
    errors='coerce')
)

# Check for parsing failures
invalid_time_count = parsed_times.isna().sum()
print(f"Invalid transaction times: {invalid_time_count}")

if invalid_time_count > 0:
    raise ValueError(
        f"{invalid_time_count} invalid transaction times detected."
    )

# Extract transaction hour
df['transaction_hour'] = parsed_times.dt.hour


# Export processed dataset
processed_dir = BASE_DIR / "data" / "processed"

processed_dir.mkdir(parents=True, exist_ok=True)

output_file = processed_dir / "cafe_transactions_processed.csv"

df.to_csv(
    output_file,
    index=False,
    encoding='utf-8'
)
print(f"\nProcessed dataset saved to:\n{output_file}")


# Validation checkpoint
print("\nPREPROCESSING VALIDATION")

print("Dataset shape:", df.shape)

print(
    "\nNull values in engineered columns:\n",
    df[
        ['line_revenue', 'is_weekend', 'transaction_hour']
    ].isna().sum()
)