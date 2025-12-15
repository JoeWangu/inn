# Contributing to INN

Thank you for your interest in contributing to **Inspired Nation Network (INN)**! We welcome contributions from the community to help make this project better.

## 🤝 How to Contribute

1.  **Fork the Repository**: Create your own copy of the project.
2.  **Clone the Repo**: `git clone https://github.com/your-username/inn.git`
3.  **Create a Branch**: `git checkout -b feature/amazing-feature`
4.  **Make Changes**: Implement your feature or fix using the guidelines below.
5.  **Commit Changes**: `git commit -m "feat: Add amazing feature"` (Use [Conventional Commits](https://www.conventionalcommits.org/))
6.  **Push to Branch**: `git push origin feature/amazing-feature`
7.  **Open a Pull Request**: Submit your PR for review.

## 🛠️ Development Setup

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Latest Stable)
- Dart SDK (Included with Flutter)

### Installation
```bash
# Get dependencies
flutter pub get

# Generate code (Riverpod, Freezed, Drift, etc.)
dart run build_runner build -d
```

### Running the App
```bash
# Debug mode
flutter run

# Profile mode
flutter run --profile
```

## 🧪 Testing

We require tests for all new features.

- **Unit Tests**: Run `flutter test`
    - Logic verification for Repositories, Providers, and Models.
- **Integration Tests**: Run `flutter test integration_test/app_test.dart`
    - End-to-end verification of critical user flows.

## 🎨 Code Style

Please review [CODE_STYLE.md](CODE_STYLE.md) for detailed guidelines on:
- Static Analysis & Linting
- Formatting
- Architecture (Riverpod + Clean Arch)
- Naming Conventions

## 📜 License By contributing, you agree that your contributions will be licensed under the **GNU GPL v3.0**, consistent with the rest of the project.