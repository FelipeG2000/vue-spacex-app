# 🚀 SpaceX Launches Dashboard - Vue 3
## Vue 3
## API Gateway

A real-time dashboard displaying SpaceX launch data, powered by AWS API Gateway and Lambda functions.

# ✨ Features
- Clean visualization of all SpaceX launches

- Responsive data table with key mission details

- Launch status chart (success/failure/upcoming)

- Real-time data from SpaceX API

- Modern UI with intuitive design

## 🛠 Core Components
## App.vue
Root component that:

* Manages loading state

* Fetches data from API

* Distributes data to child components

## LaunchTable.vue
Interactive table displaying:

* Mission name

* Launch date

* Rocket name

* Launch status

## StatusChart.vue
Data visualization showing:

* Status distribution (success/failure/upcoming)

* Historical trends