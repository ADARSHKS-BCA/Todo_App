# 📝 TaskMaster - Production Grade Productivity App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Hive](https://img.shields.io/badge/Hive-Persistence-orange?style=for-the-badge)
![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-purple?style=for-the-badge)

A powerful, reliable, and aesthetically pleasing To-Do application built with Flutter. Designed for daily use, TaskMaster combines a clean, production-grade UI with robust local persistence and smart task management features.

## ✨ Key Features

- **🔐 Adaptive Authentication**
  - Unified Login & Sign Up flow with smooth animations.
  - Real-time form validation and error handling.
  
- **📊 Status-Driven Dashboard**
  - "No-Fluff" Home Screen focusing on what matters: **Overdue**, **Today**, and **Upcoming**.
  - Live counters and interactive filters (All / Pending / Completed).
  - Smart sorting logic triggers automatically (Overdue > Today > Upcoming).

- **⚡ efficient Task Management**
  - **Progressive Creation**: Quick-add flow with Priority, Date, and Category selection.
  - **Swipe-to-Delete**: Intuitive gestures with **Undo** capability.
  - **Instant Feedback**: Micro-interactions for completion and state changes.

- **🎨 Modern Design System**
  - **"Deep Indigo" Theme**: High-contrast, accessibility-focused color palette.
  - **Dark Mode Support**: Fully responsive dark theme for night-time productivity.
  - **Responsive UI**: Optimized for Web and Mobile form factors.

- **💾 Offline First**
  - Powered by **Hive**, tasks are persisted locally and load instantly.
  - App state survives restarts seamlessly.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Riverpod](https://riverpod.dev/) (ConsumerWidget, StateNotifier)
- **Local Storage**: [Hive](https://docs.hivedb.dev/) (NoSQL, lightweight, fast)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) (Declarative routing)
- **Authentication**: [Firebase Auth](https://firebase.google.com/docs/auth) (Integrated structure)
- **Styling**: Google Fonts (`Outfit`), Flutter Animate

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest Stable)
- Dart SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ADARSHKS-BCA/Todo_App.git
   cd Todo_App
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation (for Hive)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**
   ```bash
   # For Chrome
   flutter run -d chrome

   # For Mobile (Emulator required)
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── core/                # Core utilities, theme, and router
├── data/
│   ├── models/          # Hive Models (TaskModel)
│   └── repositories/    # Data persistence logic
├── presentation/
│   ├── providers/       # Riverpod StateNotifiers
│   ├── screens/         # UI Screens (Home, Auth, AddTask)
│   └── widgets/         # Reusable widgets (TaskCard, SummaryHeader)
└── main.dart            # & initialization
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---
*Built with ❤️ by Adarsh*
