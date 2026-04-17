from flask import Flask, render_template, request
import mysql.connector
import pandas as pd
from sklearn.tree import DecisionTreeClassifier

app = Flask(__name__)

# ================= DATABASE CONNECTION ================= #

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root123",
    database="crop_recommendation"
)

# ================= FETCH DATA ================= #

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

# ================= TRAIN MODEL ================= #

X = df.drop("crop_name", axis=1)
y = df["crop_name"]

model = DecisionTreeClassifier()
model.fit(X, y)

# ================= ROUTES ================= #

# 🏠 Home Page
@app.route("/")
def home():
    return render_template("index.html")


# 🤖 Prediction Page
@app.route("/predict", methods=["GET", "POST"])
def predict():
    prediction = None
    confidence = None

    if request.method == "POST":
        try:
            data = [
                float(request.form["nitrogen"]),
                float(request.form["phosphorus"]),
                float(request.form["potassium"]),
                float(request.form["moisture"]),
                float(request.form["temperature"]),
                float(request.form["humidity"]),
                float(request.form["rainfall"])
            ]

            result = model.predict([data])
            prob = model.predict_proba([data])

            prediction = result[0]
            confidence = round(max(prob[0]) * 100, 2)

        except Exception as e:
            prediction = "Error in input"
            confidence = None

    return render_template("predict.html", prediction=prediction, confidence=confidence)


# 🗄️ Database Dashboard
@app.route("/dashboard")
def dashboard():
    soil = pd.read_sql("SELECT * FROM SOIL_DATA", conn)
    weather = pd.read_sql("SELECT * FROM WEATHER_DATA", conn)
    crop = pd.read_sql("SELECT * FROM CROP", conn)

    return render_template(
        "dashboard.html",
        soil=soil.to_dict(orient="records"),
        weather=weather.to_dict(orient="records"),
        crop=crop.to_dict(orient="records")
    )

# 📈 Analytics Page (Charts)
@app.route("/analytics")
def analytics():
    total_records = df.shape[0]
    total_features = df.shape[1] - 1

    # Crop distribution
    crop_counts = df["crop_name"].value_counts()

# Convert to normal Python list (VERY IMPORTANT)
    labels = list(crop_counts.index)
    values = list(crop_counts.values)

# Fix int64 issue
    values = [int(v) for v in values]

    return render_template("analytics.html", labels=labels, values=values)


# 📘 About Page (ER + Workflow)
@app.route("/about")
def about():
    return render_template("about.html")


# ================= RUN APP ================= #

if __name__ == "__main__":
    app.run(debug=True)