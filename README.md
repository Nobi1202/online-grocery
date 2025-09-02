# Online Grocery - Flutter App

A modern, scalable grocery shopping mobile application built with Flutter using Clean Architecture principles and BLoC pattern for state management.

## 🚀 Features

- **User Authentication**: Secure login system with token-based authentication
- **Multi-language Support**: English and Vietnamese localization
- **Shopping Experience**:
  - Browse products in Shop section
  - Explore different categories
  - Manage shopping cart
  - Favorite items management
  - User account management
- **Offline Storage**: Secure local storage for user data and preferences
- **Multiple Environments**: Development, Staging, and Production configurations
- **Clean Architecture**: Well-structured codebase following SOLID principles

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following layers:

### 📁 Project Structure

```
lib/
├── app.dart                    # Main application widget
├── main_dev.dart              # Development environment entry point
├── main_stg.dart              # Staging environment entry point
├── main_prod.dart             # Production environment entry point
├── core/                      # Core utilities and configurations
│   ├── constants/             # App constants
│   ├── enums/                 # Enumerations
│   ├── env/                   # Environment configurations
│   ├── error/                 # Error handling utilities
│   ├── extensions/            # Dart extensions
│   ├── l10n/                  # Localization files
│   ├── logging/               # Logging utilities
│   └── utils/                 # Utility functions
├── data/                      # Data layer
│   ├── core/                  # Data layer utilities
│   ├── datasources/           # Local and remote data sources
│   ├── mappers/               # Data mappers (DTO ↔ Entity)
│   ├── models/                # Data models (DTOs)
│   └── repositories/          # Repository implementations
├── domain/                    # Domain layer (Business Logic)
│   ├── core/                  # Domain utilities
│   ├── entities/              # Business entities
│   ├── repositories/          # Repository interfaces
│   └── usecase/               # Use cases (business logic)
├── di/                        # Dependency Injection
│   ├── injector.dart          # DI configuration
│   ├── env_module.dart        # Environment module
│   └── third_party_module.dart # Third-party dependencies
└── presentation/              # Presentation layer
    ├── bloc/                  # BLoC state management
    ├── error/                 # Error handling for UI
    ├── routes/                # Navigation routing
    ├── screens/               # UI screens
    ├── shared/                # Shared UI components
    └── theme/                 # App theming
```

## 🛠️ Tech Stack

### Core Technologies

- **Flutter SDK**: ^3.7.0
- **Dart**: Latest stable version

### State Management

- **flutter_bloc**: ^9.0.0 - BLoC pattern implementation
- **equatable**: ^2.0.7 - Value equality

### Dependency Injection

- **get_it**: ^8.0.1 - Service locator
- **injectable**: ^2.5.0 - Code generation for DI

### Networking

- **dio**: ^5.7.0 - HTTP client
- **retrofit**: ^4.4.1 - Type-safe HTTP client

### Local Storage

- **shared_preferences**: ^2.3.3 - Simple data persistence
- **flutter_secure_storage**: ^9.2.3 - Secure storage

### UI & UX

- **flutter_screenutil**: ^5.9.3 - Screen adaptation
- **cached_network_image**: ^3.4.1 - Image caching

### Navigation

- **go_router**: ^14.8.1 - Declarative routing

### Internationalization

- **intl**: ^0.19.0 - Internationalization support
- **flutter_localizations**: SDK - Flutter localization

### Utilities

- **dartz**: ^0.10.1 - Functional programming utilities
- **freezed**: ^2.5.8 - Code generation for immutable classes
- **json_annotation**: ^4.9.0 - JSON serialization

### Development Tools

- **build_runner**: ^2.4.14 - Code generation
- **flutter_lints**: ^5.0.0 - Linting rules
- **logger**: ^2.5.0 - Logging utility

## 🚦 Getting Started

### Prerequisites

- Flutter SDK (^3.7.0)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS builds)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd online_grocery
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**

   For development environment:

   ```bash
   flutter run --target lib/main_dev.dart
   ```

   For staging environment:

   ```bash
   flutter run --target lib/main_stg.dart
   ```

   For production environment:

   ```bash
   flutter run --target lib/main_prod.dart
   ```

## 🌍 Internationalization

The app supports multiple languages:

- English (en)
- Vietnamese (vi)

Language files are located in `lib/core/l10n/` and `lib/l10n/`.

To add a new language:

1. Create new `.arb` files in both directories
2. Run code generation
3. Update supported locales in `app.dart`

## 🏛️ Clean Architecture Implementation

### Domain Layer

- **Entities**: Core business models
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic implementation

### Data Layer

- **Models**: Data transfer objects (DTOs)
- **Mappers**: Convert between DTOs and Entities
- **Data Sources**: Remote API and local storage
- **Repository Implementations**: Concrete repository implementations

### Presentation Layer

- **BLoC**: State management using BLoC pattern
- **Screens**: UI components
- **Routes**: Navigation configuration

## 🔧 Configuration

### Environment Setup

The app supports three environments:

- **Development** (`main_dev.dart`)
- **Staging** (`main_stg.dart`)
- **Production** (`main_prod.dart`)

Each environment has its own configuration in `lib/core/env/`.

### Dependencies Injection

Dependencies are configured using `get_it` and `injectable`:

- Singletons for services and repositories
- Factories for use cases
- Lazy singletons for BLoC controllers

## 🧪 Testing

Run tests using:

```bash
flutter test
```

## 📱 Screens

1. **Splash Screen**: App initialization
2. **Get Started**: Welcome screen
3. **Login**: User authentication
4. **Bottom Tab Navigation**:
   - Shop: Product browsing
   - Explore: Category exploration
   - Cart: Shopping cart management
   - Favorites: Favorite items
   - Account: User profile

## 🔐 Security

- Secure token storage using `flutter_secure_storage`
- API authentication with JWT tokens
- Secure HTTP requests with proper interceptors

## 📝 Code Generation

The project uses several code generation tools:

- **Injectable**: Dependency injection
- **Retrofit**: API client generation
- **Freezed**: Immutable classes
- **JSON Serializable**: JSON serialization

Run code generation:

```bash
flutter packages pub run build_runner build
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Follow the coding standards
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions, please open an issue in the GitHub repository.

---

Built with ❤️ using Flutter and Clean Architecture principles.
