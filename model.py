import mysql.connector
import pandas as pd

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root123",
    database="crop_recommendation"
)

query = """
SELECT s.nitrogen, s.phosphorus, s.potassium, s.moisture,
       w.temperature, w.humidity, w.rainfall,
       c.crop_name
FROM SOIL_DATA s
JOIN RECOMMENDATION r ON s.soil_id = r.soil_id
JOIN WEATHER_DATA w ON r.weather_id = w.weather_id
JOIN RECOMMENDATION_CROP rc ON r.rec_id = rc.rec_id
JOIN CROP c ON rc.crop_id = c.crop_id;
"""

df = pd.read_sql(query, conn)
print(df.head())

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier

# Features (inputs)
X = df.drop("crop_name", axis=1)

# Target (output)
y = df["crop_name"]

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train model
model = DecisionTreeClassifier()
model.fit(X_train, y_train)

print("Model trained successfully!")

# Example input
sample = [[50, 30, 40, 60, 30, 65, 120]]

prediction = model.predict(sample)

print("Recommended Crop:", prediction[0])

probs = model.predict_proba(sample)
classes = model.classes_

# Get top 3 crops
top3 = sorted(zip(classes, probs[0]), key=lambda x: x[1], reverse=True)[:3]

print("Top 3 Recommended Crops:")
for crop, prob in top3:
    print(crop, ":", round(prob * 100, 2), "%")