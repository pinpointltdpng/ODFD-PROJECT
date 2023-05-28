import pandas as pd
from surprise import Reader, Dataset, SVD
from surprise.model_selection import train_test_split
import joblib


# Load the dataset
data = pd.read_csv('raw_ids.csv')
data_names = pd.read_csv('raw.csv')

# Define the reader object
reader = Reader(rating_scale=(1, 5))

# Load the dataset into Surprise's format
dataset = Dataset.load_from_df(data[['users_id', 'restaurant_id', 'ratings']], reader)

# Split the dataset into train and test sets
train_set, test_set = train_test_split(dataset, test_size=0.2, random_state=42)

# Build the collaborative filtering model (SVD algorithm)
model = SVD()

# Train the model on the training set
model.fit(train_set)

# Save model
joblib.dump(model, 'recommender_model.pkl')