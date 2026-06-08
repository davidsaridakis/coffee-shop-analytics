"""
Purpose:
Convert the raw data from .xlsx to .csv

Dataset:
Coffee Shop Sales (source: Kaggle)
"""
# Import libraries
import pandas as pd
from pathlib import Path

# Set path
BASE_DIR = Path(__file__).resolve().parent.parent
excel_file = BASE_DIR / "data" / "coffee_shop_sales.xlsx"

# Load file
df_raw = pd.read_excel(excel_file)

# Output file as CSV
output_file = BASE_DIR / "data" / "raw_cafe_transactions.csv"
df_raw.to_csv(output_file, index=False)

print(f"Success. Raw file saved to {output_file}")