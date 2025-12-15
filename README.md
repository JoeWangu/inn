# Inspired Nation Network (INN)

> **Find your perfect home.**

![Banner](assets/logo/logo.png)

**INN** is a modern, feature-rich Flutter application designed to connect users with their dream homes, apartments, and rentals. Built with a focus on detailed property management, user experience, and offline-first capabilities, INN provides a seamless platform for exploring and discovering real estate.

## ✨ Key Features

-   🏡 **Comprehensive Listings**: Browse a wide range of houses and apartments with detailed descriptions, amenities, and pricing.
-   🔍 **Smart Search & Filters**: Precisely find what you need by filtering properties based on price range, location, and type.
-   ❤️ **Favorites & Collections**: Save listings to your personal favorites list for quick access later.
-   🔐 **Secure Authentication**: Robust user management with Login and Sign Up functionality, backed by secure token storage.
-   📱 **Responsive Design**: Customized layouts for both Mobile and Desktop experiences.
-   🎨 **Dynamic Theming**: Full support for Light/Dark modes, Material You dynamic colors, and user-customizable theme seeds.
-   📶 **Offline First**: Built with `Drift` for local database caching, ensuring a smooth experience even with spotty connectivity.

## 📸 Screenshots

| Home Page | House Details |
| :---: | :---: |
| ![Home](assets/img_assets/home_preview.png) | ![Details](assets/img_assets/details_preview.png) | 
> *Screenshots are placeholders. Please add `home_preview.png` and `details_preview.png` to `assets/img_assets/`.*

## 🛠️ Technology Stack

-   **Framework**: [Flutter](https://flutter.dev) (Dart)
-   **State Management**: [Riverpod](https://riverpod.dev)
-   **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
-   **Local Database**: [Drift](https://drift.simonbinder.eu) (SQLite)
-   **Networking**: [Dio](https://pub.dev/packages/dio) + [Retrofit](https://pub.dev/packages/retrofit)
-   **Code Generation**: [Freezed](https://pub.dev/packages/freezed) & [JsonSerializable](https://pub.dev/packages/json_serializable)
-   **Testing**: `flutter_test`, `integration_test`, `mockito`

## 🚀 Getting Started

### Prerequisites
-   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
-   An IDE (VS Code or Android Studio) with Flutter/Dart plugins.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/inn.git
    cd inn
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation:**
    This project uses code generation for models, providers, and database tables.
    ```bash
    dart run build_runner build -d
    ```

4.  **Run the App:**
    ```bash
    flutter run
    ```

## 🧪 Testing

To ensure stability, run the test suite:

-   **Unit & Widget Tests**:
    ```bash
    flutter test
    ```
-   **Integration Tests** (End-to-End):
    ```bash
    flutter test integration_test/app_test.dart
    ```

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, development process, and how to submit pull requests.

## 📄 License

This project is licensed under the **GNU GPL v3.0**. See the [LICENSE](LICENSE) file for details.