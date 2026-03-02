# 🐋 Whale Stock

Whale Stock is a premium, high-performance Inventory Management System built with Flutter. It provides a sleek, modern dashboard for real-time stock tracking, advanced data visualization, and efficient local-first data management.

## ✨ Key Features

- **📊 Dynamic Analytics**: Real-time charts for Inventory Growth and Category Distribution powered by `fl_chart`.
- **📦 Smart Inventory**: Full CRUD operations for products with automated SKU generation and category assignments.
- **📁 Local-First Storage**: Blazing fast data persistence using `Hive` (NoSQL), ensuring offline capability and instant load times.
- **🎨 Premium UI/UX**: State-of-the-art dark mode design featuring glassmorphism elements, subtle micro-animations, and responsive layouts.
- **📑 Professional Reports**: Export inventory data to professional formats (Excel) for business analysis.
- **🚀 Efficient Workflow**: Streamlined Add/Edit product flows with intelligent form validation and custom dropdowns.

## 🛠️ Technology Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database**: [Hive](https://pub.dev/packages/hive)
- **Charting**: [FL Chart](https://pub.dev/packages/fl_chart)
- **Theming**: Custom Premium Design System (Dark/Light support)
- **Utilities**: `intl`, `path_provider`, `excel`

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AhmedHelmy18/Whale-Stock.git
   ```
2. Navigate to the project directory:
   ```bash
   cd Whale-Stock
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the build runner (for Hive models):
   ```bash
   flutter pub run build_runner build
   ```
5. Run the application:
   ```bash
   flutter run
   ```

---

Developed with ❤️ by Ahmed Helmy.
