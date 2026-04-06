import pandas as pd

tables = [
    "DEPARTMENT",
    "DOCTOR",
    "PATIENT",
    "PROCEDURE",
    "APPOINTMENT",
    "DIAGNOSIS",
    "APPOINTMENT_PROCEDURE",
]

def format_value(x):
    if pd.isna(x):
        return "NULL"
    if isinstance(x, (int, float)):
        return str(int(x)) if float(x).is_integer() else str(x)
    
    s = str(x).replace("'", "''")
    return f"'{s}'"

with open("data.sql", "w") as f:
    for name in tables:
        df = pd.read_csv(f"data/{name}.csv")
        cols = ", ".join(df.columns.str.lower())

        f.write(f"INSERT INTO {name.lower()} ({cols}) VALUES\n")

        rows = []
        for _, row in df.iterrows():
            values = ", ".join([format_value(x) for x in row])
            rows.append(f"({values})")

        f.write(",\n".join(rows))
        f.write(";\n\n")