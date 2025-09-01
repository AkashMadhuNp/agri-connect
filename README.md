🌱 Agro Connect

Agro Connect is a digital companion for nursery owners/admins, helping them manage crops, staff, services, shop, and revenue in one platform. The app integrates real-time weather, location tracking, and Firebase authentication to make nursery management smarter and more efficient.

🚀 Features
🔑 Authentication & User Management

Firebase Email + Password authentication

Proper form validation (Email, Name, Phone, Password, Confirm Password)

Location fetching during signup/login

Persistent login & password reset

🌾 Crop Monitoring

Tabs: Production | Staff | Overview

Production → Production overview, active crops, harvest process tracking

Staff → Staff list (from API), work status, assign tasks (future), call staff (future)

Overview → Production summary + Inventory alerts

🛠️ Service Management

Tabs: Today | Service | Analytics

Today → Scheduled services, consultations, recent service history

Service → Service portfolio, available services for farmers

Analytics → Monthly performance, financial summary

🏪 Shop & Inventory

Tabs: Inventory | Orders | Products

Inventory → Inventory overview, low stock alerts, full inventory

Orders → Order summary, recent farmer/supplier orders

Products → Product catalog, available products for farmers

🌤️ Weather & Alerts

Fetches real-time weather using OpenWeather API

Location-based weather insights for nursery/farm planning

Alerts system: crop issues, inventory low stock, weather warnings, revenue summaries

💰 Revenue Management

Tracks revenue from crops, services, and product sales

Tracks expenses from suppliers and staff payments

Monthly/weekly financial summaries with visual charts

🧩 APIs Used

Firebase Authentication → User login/signup

Firebase Firestore → User & nursery data storage

Firebase Cloud Messaging → Alerts & push notifications

OpenWeather API → Real-time weather data based on location

Geolocator (Flutter) → Fetch current GPS location

Mock API (JSON Placeholder/Custom) → For staff details, inventory, orders




Packages

Core Flutter setup ✅

Firebase Auth & Firestore (firebase_auth, cloud_firestore) ✅

Location services (geolocator) ✅

HTTP for API calls ✅

GetX for state management ✅

Intl for date/time formatting ✅

Cupertino icons ✅

👇

🚧 Limitations

Time Constraint: The task was a 4-day machine test, started from scratch on 28-08-2025 (04:10 PM) and submitted on 01-09-2025, with an estimated 27 working hours.

Real-World Concept Attempt: The focus was to create a practical AgriTech app concept rather than just a prototype.

Design: The Figma design was created primarily for app layout reference. It is not a perfectly polished UI/UX design.

APIs:

Integrated OpenWeather API for real-time weather updates.

Used Mock APIs (2) for crop-related and task-related data.

Functionality:

The application is not fully functional.

Features like authentication, mock API fetching, and weather API UI are partially implemented.

Scope: The assignment was limited to UI implementation and basic integration, not a complete production-ready application.