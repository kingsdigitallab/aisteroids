import pandas as pd

# Read CSV
df = pd.read_csv("src/data/historical_data.csv")

# Clean up dollar signs and convert to float
for col in ["last", "open", "high", "low"]:
    df[col] = df[col].str.replace("$", "").astype(float)

# Create Lua file content
lua_content = "local HistoricalData = {\n"

# Group by date and convert to Lua table syntax
for date, group in df.groupby("date"):
    lua_content += f" {{\n"
    for _, row in group.iterrows():
        lua_content += "    {\n"
        lua_content += f"      stock = '{row['stock']}',\n"
        lua_content += f"      date = '{row['date']}',\n"
        lua_content += f"      last = {row['last']},\n"
        lua_content += f"      volume = {row['volume']},\n"
        lua_content += f"      open = {row['open']},\n"
        lua_content += f"      high = {row['high']},\n"
        lua_content += f"      low = {row['low']}\n"
        lua_content += "    },\n"
    lua_content += "  },\n"

lua_content += "}\n\nreturn HistoricalData"

# Write to Lua file
with open("src/data/historical_data.lua", "w") as f:
    f.write(lua_content)
