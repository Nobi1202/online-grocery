# Clean Architecture in Flutter - Complete Guide

This document provides a comprehensive guide to Clean Architecture implementation in Flutter, covering both general concepts and the specific implementation in this Online Grocery project.

## 📋 Table of Contents

1. [What is Clean Architecture?](#what-is-clean-architecture)
2. [Core Principles](#core-principles)
3. [Architecture Layers](#architecture-layers)
4. [Project Implementation](#project-implementation)
5. [Dependency Flow](#dependency-flow)
6. [Benefits](#benefits)
7. [Best Practices](#best-practices)

## 🏗️ What is Clean Architecture?

Clean Architecture, introduced by Robert C. Martin (Uncle Bob), is a software architecture pattern that emphasizes separation of concerns and independence of frameworks, databases, and external agencies. It creates a system that is:

- **Independent of frameworks**: The architecture doesn't depend on specific frameworks
- **Testable**: Business rules can be tested without UI, database, or external elements
- **Independent of UI**: UI can change without changing the business rules
- **Independent of database**: Business rules are not bound to the database
- **Independent of external agencies**: Business rules don't know about the outside world

## 🎯 Core Principles

### SOLID Principles

1. **Single Responsibility Principle (SRP)**: Each class should have only one reason to change
2. **Open-Closed Principle (OCP)**: Software entities should be open for extension but closed for modification
3. **Liskov Substitution Principle (LSP)**: Objects should be replaceable with instances of their subtypes
4. **Interface Segregation Principle (ISP)**: Clients should not be forced to depend on interfaces they don't use
5. **Dependency Inversion Principle (DIP)**: High-level modules should not depend on low-level modules

### Additional Principles

- **Separation of Concerns**: Each layer has a specific responsibility
- **Dependency Rule**: Dependencies point inward toward higher-level policies
- **Abstraction**: Use interfaces and abstract classes to define contracts

## 🏛️ Architecture Layers

Clean Architecture consists of several concentric layers, each with specific responsibilities:

### 1. Domain Layer (Core/Business Logic)

The innermost layer containing business logic and rules.

**Components:**

- **Entities**: Core business objects
- **Use Cases**: Application-specific business rules
- **Repository Interfaces**: Contracts for data access

**Characteristics:**

- No dependencies on external layers
- Contains pure business logic
- Framework-independent
- Highly testable

### 2. Data Layer

Handles data retrieval and storage from various sources.

**Components:**

- **Repository Implementations**: Concrete implementations of repository interfaces
- **Data Sources**: Remote (API) and Local (Database, SharedPreferences)
- **Models/DTOs**: Data transfer objects
- **Mappers**: Convert between DTOs and Entities

**Characteristics:**

- Implements domain interfaces
- Handles data transformation
- Manages different data sources
- Contains framework-specific code

### 3. Presentation Layer (UI)

Handles user interface and user interactions.

**Components:**

- **Widgets/Screens**: UI components
- **State Management**: BLoC, Provider, Riverpod, etc.
- **View Models**: Presentation logic
- **Routes**: Navigation management

**Characteristics:**

- Depends on domain layer
- Handles user interactions
- Manages UI state
- Framework-specific

## 🚀 Project Implementation

### Directory Structure

```
lib/
├── core/                      # Shared utilities and configurations
│   ├── constants/             # Application constants
│   ├── enums/                 # Enumerations
│   ├── env/                   # Environment configurations
│   ├── error/                 # Error handling utilities
│   ├── extensions/            # Dart extensions
│   ├── l10n/                  # Localization files
│   ├── logging/               # Logging utilities
│   └── utils/                 # Utility functions
├── domain/                    # 🎯 DOMAIN LAYER
│   ├── core/                  # Domain utilities
│   │   ├── failures.dart      # Error definitions
│   │   ├── result.dart        # Result wrapper
│   │   └── usecase.dart       # Base use case classes
│   ├── entities/              # Business entities
│   │   ├── user_login_entity.dart
│   │   ├── user_info_entity.dart
│   │   ├── cart_item_entity.dart
│   │   └── favorite_item_entity.dart
│   ├── repositories/          # Repository interfaces
│   │   ├── auth_repository.dart
│   │   └── cart_repository.dart
│   └── usecase/               # Use cases (business logic)
│       ├── login_user_usecase.dart
│       ├── get_user_info_usecase.dart
│       ├── get_cart_items_usecase.dart
│       └── get_favorite_items_usecase.dart
├── data/                      # 💾 DATA LAYER
│   ├── core/                  # Data layer utilities
│   │   ├── exceptions.dart    # Custom exceptions
│   │   ├── guard.dart         # Error handling wrapper
│   │   ├── interceptors.dart  # HTTP interceptors
│   │   ├── dio_failure_mapper.dart
│   │   └── dio_logger.dart
│   ├── datasources/           # Data sources
│   │   ├── local/             # Local data sources
│   │   │   └── secure_storage.dart
│   │   └── remote/            # Remote data sources
│   │       ├── api_service.dart
│   │       └── api_service.g.dart
│   ├── models/                # Data models (DTOs)
│   │   ├── request/           # Request DTOs
│   │   └── response/          # Response DTOs
│   ├── mappers/               # Data mappers
│   │   ├── user_login_mapper.dart
│   │   ├── user_info_mapper.dart
│   │   ├── list_of_cart_items_mapper.dart
│   │   └── list_of_favorite_items_mapper.dart
│   └── repositories/          # Repository implementations
│       ├── auth_respository_impl.dart
│       └── cart_repository_impl.dart
├── presentation/              # 🖼️ PRESENTATION LAYER
│   ├── bloc/                  # State management
│   │   ├── account/           # Account BLoC
│   │   ├── cart/              # Cart BLoC
│   │   ├── favorite/          # Favorite BLoC
│   │   ├── locale/            # Locale BLoC
│   │   └── login/             # Login BLoC
│   ├── screens/               # UI screens
│   │   ├── splash/
│   │   ├── get_started/
│   │   ├── login/
│   │   ├── bottom_tab/
│   │   ├── shop/
│   │   ├── explore/
│   │   ├── cart/
│   │   ├── favourite/
│   │   └── account/
│   ├── shared/                # Shared UI components
│   ├── theme/                 # App theming
│   ├── routes/                # Navigation routing
│   └── error/                 # Error handling for UI
└── di/                        # 🔧 DEPENDENCY INJECTION
    ├── injector.dart          # Main DI configuration
    ├── injector.config.dart   # Generated DI configuration
    ├── env_module.dart        # Environment module
    └── third_party_module.dart # Third-party dependencies
```

### Layer Implementation Details

#### 1. Domain Layer Implementation

**Entities** - Pure business objects:

```dart
class UserLoginEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const UserLoginEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, username, email, firstName, lastName];
}
```

**Repository Interfaces** - Abstract contracts:

```dart
abstract class IAuthRepository {
  ResultFuture<UserLoginEntity> login(UserLoginSchema userLoginSchema);
  ResultFuture<UserInfoEntity> getUserInfo();
}
```

**Use Cases** - Business logic:

```dart
@injectable
class LoginUserUsecase extends UseCaseAsync<UserLoginEntity, UserLoginSchema> {
  final IAuthRepository _authRepository;

  LoginUserUsecase(this._authRepository);

  @override
  Future<Either<Failure, UserLoginEntity>> call(UserLoginSchema params) {
    return _authRepository.login(params);
  }
}
```

#### 2. Data Layer Implementation

**Repository Implementation**:

```dart
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends IAuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  ResultFuture<UserLoginEntity> login(UserLoginSchema userLoginSchema) {
    return guardDio<UserLoginEntity>(() async {
      final dto = await _apiService.login(userLoginSchema);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<UserInfoEntity> getUserInfo() {
    return guardDio<UserInfoEntity>(() async {
      final dto = await _apiService.getUserInfo();
      return dto.toEntity();
    });
  }
}
```

**Data Sources** - API Service:

```dart
@RestApi()
@injectable
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<UserLoginDto> login(@Body() UserLoginSchema userLoginSchema);

  @GET('/auth/me')
  Future<UserInfoDto> getUserInfo();
}
```

**Mappers** - Convert DTOs to Entities:

```dart
extension UserLoginMapper on UserLoginDto {
  UserLoginEntity toEntity() {
    return UserLoginEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
```

#### 3. Presentation Layer Implementation

**BLoC State Management**:

```dart
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _userLoginUsecase = getIt<LoginUserUsecase>();
  final SecureStorage _secureStorage = getIt<SecureStorage>();
  final FailureMapper _failureMapper;

  LoginBloc(@factoryParam this._failureMapper) : super(const LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await _userLoginUsecase(
        UserLoginSchema(username: event.username, password: event.password),
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMsg: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (success) {
          _secureStorage.saveToken(success.accessToken);
          _secureStorage.saveRefreshToken(success.refreshToken);
          emit(state.copyWith(isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMsg: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
```

## 🔄 Dependency Flow

The dependency flow follows the **Dependency Inversion Principle**:

```
Presentation Layer
       ↓ (depends on)
Domain Layer (Interfaces)
       ↑ (implements)
Data Layer (Implementations)
```

### Key Points:

1. **Presentation Layer** depends on **Domain Layer** interfaces
2. **Data Layer** implements **Domain Layer** interfaces
3. **Domain Layer** has no dependencies on outer layers
4. Dependencies point inward (toward higher-level policies)

### Dependency Injection

Using `get_it` and `injectable` for dependency management:

```dart
// Registration
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends IAuthRepository { ... }

@injectable
class LoginUserUsecase extends UseCaseAsync<UserLoginEntity, UserLoginSchema> { ... }

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> { ... }

// Usage
final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies({required String env}) async {
  await getIt.init(environment: env);
}
```

## ✅ Benefits

### 1. Testability

- Each layer can be tested independently
- Easy to mock dependencies
- Business logic is isolated and testable

### 2. Maintainability

- Clear separation of concerns
- Easy to locate and modify specific functionality
- Reduced coupling between components

### 3. Scalability

- Easy to add new features
- Components can be developed independently
- Clear boundaries between layers

### 4. Flexibility

- Easy to change implementations
- Framework-independent business logic
- Support for multiple data sources

### 5. Code Reusability

- Business logic can be reused across different platforms
- Shared entities and use cases
- Platform-specific implementations

## 🎯 Best Practices

### 1. Domain Layer Best Practices

- Keep entities pure (no external dependencies)
- Use value objects for complex data types
- Make use cases single-purpose and focused
- Define clear repository interfaces

### 2. Data Layer Best Practices

- Use DTOs for external data representation
- Implement proper error handling
- Use mappers to convert between DTOs and entities
- Handle network and database exceptions

### 3. Presentation Layer Best Practices

- Keep widgets focused on UI rendering
- Use state management patterns (BLoC, Provider, etc.)
- Handle loading and error states properly
- Separate presentation logic from business logic

### 4. General Best Practices

- Follow SOLID principles
- Use dependency injection
- Implement proper logging
- Write comprehensive tests
- Use code generation where appropriate
- Maintain consistent naming conventions

### 5. Project-Specific Practices

- Use `freezed` for immutable classes
- Implement proper error handling with `Either<Failure, Success>`
- Use `injectable` for dependency injection
- Follow Flutter/Dart coding standards
- Implement proper localization

## 🧪 Testing Strategy

### Unit Tests

- Test use cases with mocked repositories
- Test repository implementations with mocked data sources
- Test mappers for correct data transformation

### Integration Tests

- Test complete flows from UI to data layer
- Test API integrations
- Test database operations

### Widget Tests

- Test UI components in isolation
- Test user interactions
- Test state management

## 📚 Additional Resources

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://github.com/ShadyBoukhary/flutter_clean_architecture)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Dependency Injection in Flutter](https://pub.dev/packages/get_it)

---

This Clean Architecture implementation provides a solid foundation for building scalable, maintainable, and testable Flutter applications. The separation of concerns ensures that business logic remains independent of frameworks and external dependencies, making the codebase more robust and adaptable to change.
