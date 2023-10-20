import random
import csv

# Routine to generate dummy variables to parameters.csv

# Define the seasons
seasons = ["fall", "winter", "spring", "summer"]

# Open the CSV file for writing
with open("parameters.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    # Write the header row
    writer.writerow(["index", "temperature", "category"])
    # Generate 1000 records
    for i in range(1, 1001):
        # Randomly assign a season
        season = random.choice(seasons)
        # Generate a random temperature based on the season
        if season == "winter":
            temperature = round(random.uniform(-20.0, 5.0), 1)
        elif season == "spring":
            temperature = round(random.uniform(5.0, 15.0), 1)
        elif season == "summer":
            temperature = round(random.uniform(15.0, 35.0), 1)
        elif season == "fall":
            temperature = round(random.uniform(5.0, 20.0), 1)
        # Write the record to the CSV file
        writer.writerow([i, temperature, season])