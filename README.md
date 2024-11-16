# Demo App - API Data Fetch with Hive Storage

## Overview
This is a demo mobile application built with **Flutter** to demonstrate efficient data handling by fetching data from an API and storing it locally using **Hive**. By storing the data in Hive, the app reduces server load and provides an optimized user experience.

## Features
### 1. Dynamic Splash Screen
- The splash screen is displayed dynamically and only during the first launch while data is being loaded.

### 2. Screens
- **Product Screen**: Displays a list of products.
- **Product Description Screen**: Provides detailed information about a product.
- **Category Screen**: Displays a list of product categories.
- **Favorite Screen**: Allows users to mark and view favorite items.
- **Profile Screen**: Displays user information.

### 3. Search Functionality
- Search feature is implemented for both products and categories, providing a quick way to find specific items.

### 4. State Management
- The app utilizes **Bloc** for state management in most features except for the search functionality.

## Technology Stack
- **Flutter**: Frontend framework for building the app.
- **Hive**: Lightweight and blazing-fast key-value database for local storage.
- **Bloc**: State management for predictable state transitions.
- **RESTful API**: Data source for the app.

## How It Works
### First Launch
- The app fetches data from the API and stores it in Hive during the splash screen.

### Subsequent Launches
- The app directly loads data from Hive, significantly reducing server requests and enhancing speed.

## Download
Click the link below to download and test the app:  
[Download Demo App]
