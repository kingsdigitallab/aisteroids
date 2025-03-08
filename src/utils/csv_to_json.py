import json

import pandas as pd

# Read CSV
df = pd.read_csv("src/data/historical_data.csv")

# Clean up dollar signs and convert to float
for col in ["last", "open", "high", "low"]:
    df[col] = df[col].str.replace("$", "").astype(float)

# Group by date and convert to JSON
result = {}
for date, group in df.groupby("date"):
    result[date] = group.drop("date", axis=1).to_dict("records")

# Write to JSON file with pretty printing
with open("src/data/historical_data.json", "w") as f:
    json.dump(result, f, indent=2)
