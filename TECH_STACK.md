# Technology Stack Documentation

This document provides detailed information about all libraries and technologies used in the Online Grocery Flutter project, including examples and use cases.

## 📋 Table of Contents

1. [Core Technologies](#core-technologies)
2. [State Management](#state-management)
3. [Dependency Injection](#dependency-injection)
4. [Networking](#networking)
5. [Local Storage](#local-storage)
6. [UI & UX](#ui--ux)
7. [Navigation](#navigation)
8. [Internationalization](#internationalization)
9. [Utilities](#utilities)
10. [Development Tools](#development-tools)
11. [Code Generation](#code-generation)

## 🚀 Core Technologies

### Flutter SDK ^3.7.0

**Purpose**: Cross-platform mobile app development framework

**Why we use it**:

- Single codebase for iOS and Android
- High performance with native compilation
- Rich UI components and animations
- Strong community support

**Example Usage**:

```dart
// Main application widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Online Grocery',
      routerConfig: AppRouter.router,
    );
  }
}
```

### Dart Language

**Purpose**: Programming language for Flutter development

**Key Features**:

- Strong typing with null safety
- Asynchronous programming support
- Object-oriented programming
- Functional programming features

## 🔄 State Management

### flutter_bloc ^9.0.0

**Purpose**: Implementation of the BLoC (Business Logic Component) pattern for state management

**Why we use it**:

- Predictable state management
- Separation of business logic from UI
- Easy testing
- Time-travel debugging

**Example Usage**:

```dart
// BLoC Definition
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // Business logic here
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}

// UI Usage
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator();
        }
        return LoginForm();
      },
    );
  }
}
```

**Vietnamese**:
flutter_bloc được sử dụng để quản lý trạng thái ứng dụng theo mô hình BLoC, giúp tách biệt logic nghiệp vụ khỏi giao diện người dùng.

### equatable ^2.0.7

**Purpose**: Simplifies equality comparisons for Dart objects

**Why we use it**:

- Automatic equality and hashCode implementation
- Reduces boilerplate code
- Essential for BLoC state comparisons

**Example Usage**:

```dart
class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}

// Usage
final user1 = UserEntity(id: 1, name: 'John', email: 'john@example.com');
final user2 = UserEntity(id: 1, name: 'John', email: 'john@example.com');
print(user1 == user2); // true
```

**Vietnamese**:
equatable giúp đơn giản hóa việc so sánh đối tượng trong Dart, tự động tạo phương thức equality và hashCode.

## 🔧 Dependency Injection

### get_it ^8.0.1

**Purpose**: Service locator for dependency injection

**Why we use it**:

- Simple and lightweight
- Support for different registration types
- Easy to test with mocking
- No code generation required

**Example Usage**:

```dart
// Registration
final getIt = GetIt.instance;

void setupDependencies() {
  // Singleton
  getIt.registerSingleton<ApiService>(ApiService());

  // Lazy Singleton
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<ApiService>()),
  );

  // Factory
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(getIt<AuthRepository>()),
  );
}

// Usage
final authRepo = getIt<AuthRepository>();
final loginBloc = getIt<LoginBloc>();
```

**Vietnamese**:
get_it là một service locator đơn giản để quản lý dependency injection, hỗ trợ nhiều loại đăng ký khác nhau.

### injectable ^2.5.0

**Purpose**: Code generation for get_it dependency injection

**Why we use it**:

- Reduces boilerplate code
- Compile-time dependency resolution
- Better error detection
- Supports different environments

**Example Usage**:

```dart
// Service registration with annotations
@injectable
class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);
}

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);
}

// Environment-specific registration
@dev
@Injectable(as: ApiClient)
class DevApiClient implements ApiClient { ... }

@prod
@Injectable(as: ApiClient)
class ProdApiClient implements ApiClient { ... }

// Generated configuration
@injectableInit
Future<void> configureDependencies({required String env}) async {
  await getIt.init(environment: env);
}
```

**Vietnamese**:
injectable tự động tạo code cho get_it, giảm thiểu code boilerplate và hỗ trợ cấu hình môi trường khác nhau.

## 🌐 Networking

### dio ^5.7.0

**Purpose**: Powerful HTTP client for Dart/Flutter

**Why we use it**:

- Interceptors support
- Request/Response transformation
- Automatic JSON serialization
- Error handling
- Request cancellation

**Example Usage**:

```dart
// Basic setup
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 5),
  receiveTimeout: Duration(seconds: 3),
));

// Add interceptors
dio.interceptors.add(LogInterceptor());
dio.interceptors.add(AuthInterceptor());

// Making requests
Future<User> getUser(int id) async {
  try {
    final response = await dio.get('/users/$id');
    return User.fromJson(response.data);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw NetworkException('Connection timeout');
    }
    throw ServerException('Server error: ${e.message}');
  }
}

// POST request
Future<User> createUser(CreateUserRequest request) async {
  final response = await dio.post(
    '/users',
    data: request.toJson(),
  );
  return User.fromJson(response.data);
}
```

**Vietnamese**:
dio là một HTTP client mạnh mẽ cho Dart/Flutter với hỗ trợ interceptors, xử lý lỗi tự động và nhiều tính năng khác.

### retrofit ^4.4.1

**Purpose**: Type-safe HTTP client generator for Dio

**Why we use it**:

- Type-safe API calls
- Automatic request/response handling
- Annotation-based API definition
- Integration with dio

**Example Usage**:

```dart
// API service definition
@RestApi(baseUrl: 'https://api.example.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/users/{id}')
  Future<UserDto> getUser(@Path('id') int id);

  @POST('/users')
  Future<UserDto> createUser(@Body() CreateUserRequest request);

  @PUT('/users/{id}')
  Future<UserDto> updateUser(
    @Path('id') int id,
    @Body() UpdateUserRequest request,
  );

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') int id);

  @GET('/users')
  Future<List<UserDto>> getUsers(
    @Query('page') int page,
    @Query('limit') int limit,
  );
}

// Usage in repository
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends IAuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, UserEntity>> login(LoginRequest request) async {
    try {
      final dto = await _apiService.login(request);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

**Vietnamese**:
retrofit tạo HTTP client type-safe cho dio, sử dụng annotations để định nghĩa API và tự động xử lý request/response.

## 💾 Local Storage

### shared_preferences ^2.3.3

**Purpose**: Simple key-value storage for Flutter

**Why we use it**:

- Simple API for basic data storage
- Cross-platform support
- Automatic persistence
- Good for app settings and preferences

**Example Usage**:

```dart
class PreferencesService {
  static const String _keyUserId = 'user_id';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLanguage = 'language';

  // Save data
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
  }

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, themeMode);
  }

  // Retrieve data
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode);
  }

  // Remove data
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }
}
```

**Vietnamese**:
shared_preferences cung cấp lưu trữ key-value đơn giản cho Flutter, thích hợp cho cài đặt ứng dụng và tùy chọn người dùng.

### flutter_secure_storage ^9.2.3

**Purpose**: Secure storage for sensitive data

**Why we use it**:

- Encrypted storage
- Platform-specific secure storage (Keychain on iOS, Keystore on Android)
- Perfect for tokens and sensitive information
- Simple API

**Example Usage**:

```dart
class SecureStorage {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyLocale = 'locale';

  SecureStorage(this._secureStorage, this._prefs);

  // Token management
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _keyAccessToken, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _keyAccessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _keyRefreshToken, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _keyRefreshToken);
  }

  // Clear all secure data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Locale management (using SharedPreferences for non-sensitive data)
  void saveLocale(String locale) {
    _prefs.setString(_keyLocale, locale);
  }

  String? getLocale() {
    return _prefs.getString(_keyLocale);
  }
}
```

**Vietnamese**:
flutter_secure_storage cung cấp lưu trữ an toàn cho dữ liệu nhạy cảm như token, sử dụng mã hóa và lưu trữ bảo mật của hệ điều hành.

## 🎨 UI & UX

### flutter_screenutil ^5.9.3

**Purpose**: Screen adaptation and responsive design

**Why we use it**:

- Consistent UI across different screen sizes
- Responsive design made easy
- Automatic scaling for fonts and dimensions
- Simple API

**Example Usage**:

```dart
// Initialize in main app
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: HomeScreen(),
        );
      },
    );
  }
}

// Usage in widgets
class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,          // Responsive width
      height: 200.h,         // Responsive height
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,    // Responsive horizontal padding
        vertical: 12.h,      // Responsive vertical padding
      ),
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Text(
            'User Profile',
            style: TextStyle(
              fontSize: 18.sp,  // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Welcome to the app',
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

// Responsive conditions
class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (1.sw > 600) // Screen width greater than 600
            TabletLayout()
          else
            MobileLayout(),
        ],
      ),
    );
  }
}
```

**Vietnamese**:
flutter_screenutil giúp tạo giao diện responsive và thích ứng với nhiều kích thước màn hình khác nhau một cách dễ dàng.

### cached_network_image ^3.4.1

**Purpose**: Image loading and caching from network

**Why we use it**:

- Automatic image caching
- Loading and error placeholders
- Memory management
- Performance optimization

**Example Usage**:

```dart
class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const ProductImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }
}

// Advanced usage with custom cache manager
class CustomCacheManager {
  static const key = 'customCacheKey';

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}

class AdvancedProductImage extends StatelessWidget {
  final String imageUrl;

  const AdvancedProductImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CustomCacheManager.instance,
      placeholder: (context, url) => ShimmerPlaceholder(),
      errorWidget: (context, url, error) => PlaceholderImage(),
    );
  }
}
```

**Vietnamese**:
cached_network_image tự động tải và cache hình ảnh từ mạng, cung cấp placeholder cho trạng thái loading và error.

## 🧭 Navigation

### go_router ^14.8.1

**Purpose**: Declarative routing for Flutter

**Why we use it**:

- Declarative route configuration
- Deep linking support
- Type-safe navigation
- URL-based routing
- Guard routes with conditions

**Example Usage**:

```dart
// Route configuration
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductDetailScreen(productId: productId);
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = AuthService.isLoggedIn;
      final isLoggingIn = state.matchedLocation == RouteName.login;

      if (!isLoggedIn && !isLoggingIn) {
        return RouteName.login;
      }

      if (isLoggedIn && isLoggingIn) {
        return RouteName.home;
      }

      return null;
    },
  );
}

// Route names
class RouteName {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const profile = '/home/profile';
  static const productDetail = '/home/product';
}

// Navigation usage
class NavigationExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.go(RouteName.home),
          child: Text('Go to Home'),
        ),
        ElevatedButton(
          onPressed: () => context.push('/home/profile'),
          child: Text('Push Profile'),
        ),
        ElevatedButton(
          onPressed: () => context.pushNamed(
            'product-detail',
            pathParameters: {'id': '123'},
            queryParameters: {'tab': 'reviews'},
          ),
          child: Text('Go to Product Detail'),
        ),
        ElevatedButton(
          onPressed: () => context.pop(),
          child: Text('Go Back'),
        ),
      ],
    );
  }
}
```

**Vietnamese**:
go_router cung cấp hệ thống định tuyến khai báo cho Flutter với hỗ trợ deep linking và type-safe navigation.

## 🌍 Internationalization

### intl ^0.19.0

**Purpose**: Internationalization and localization support

**Why we use it**:

- Date and number formatting
- Pluralization support
- Message formatting
- Locale-specific formatting

**Example Usage**:

```dart
// Message formatting
class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get welcomeMessage => Intl.message(
    'Welcome to Online Grocery',
    name: 'welcomeMessage',
    desc: 'Welcome message displayed on home screen',
  );

  String itemCount(int count) => Intl.plural(
    count,
    zero: 'No items',
    one: '1 item',
    other: '$count items',
    name: 'itemCount',
    args: [count],
  );

  String priceFormat(double price) => Intl.message(
    '\$${price.toStringAsFixed(2)}',
    name: 'priceFormat',
    args: [price],
  );
}

// Date formatting
class DateHelper {
  static String formatDate(DateTime date, String locale) {
    return DateFormat.yMMMd(locale).format(date);
  }

  static String formatTime(DateTime date, String locale) {
    return DateFormat.jm(locale).format(date);
  }

  static String formatCurrency(double amount, String locale) {
    return NumberFormat.currency(locale: locale, symbol: '\$').format(amount);
  }
}

// Usage in widgets
class LocalizedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Text(l10n.welcomeMessage),
        Text(l10n.itemCount(5)),
        Text(l10n.priceFormat(29.99)),
        Text(DateHelper.formatDate(DateTime.now(), 'en_US')),
      ],
    );
  }
}
```

**Vietnamese**:
intl cung cấp hỗ trợ quốc tế hóa và bản địa hóa, bao gồm định dạng ngày tháng, số và tin nhắn đa ngôn ngữ.

## 🔧 Utilities

### dartz ^0.10.1

**Purpose**: Functional programming utilities for Dart

**Why we use it**:

- Either type for error handling
- Option type for nullable values
- Functional programming patterns
- Immutable data structures

**Example Usage**:

```dart
// Either for error handling
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

typedef ResultFuture<T> = Future<Either<Failure, T>>;

// Repository implementation
class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  ResultFuture<User> getUser(int id) async {
    try {
      final userDto = await _apiService.getUser(id);
      final user = userDto.toEntity();
      return Right(user);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(NetworkFailure('Connection timeout'));
      }
      return Left(ServerFailure('Server error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}

// Usage in BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final result = await _userRepository.getUser(event.userId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }
}

// Option type for nullable values
class UserService {
  Option<User> _currentUser = none();

  Option<User> get currentUser => _currentUser;

  void setUser(User? user) {
    _currentUser = optionOf(user);
  }

  String getUserDisplayName() {
    return _currentUser.fold(
      () => 'Guest User',
      (user) => user.name,
    );
  }
}
```

**Vietnamese**:
dartz cung cấp các tiện ích lập trình hàm cho Dart, bao gồm Either type để xử lý lỗi và Option type cho giá trị nullable.

## 🛠️ Development Tools

### flutter_lints ^5.0.0

**Purpose**: Linting rules for Flutter projects

**Why we use it**:

- Enforces code quality standards
- Catches potential bugs early
- Maintains consistent code style
- Official Flutter linting rules

**Example Configuration**:

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "build/**"

linter:
  rules:
    # Additional custom rules
    avoid_print: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_unnecessary_containers: true
    sized_box_for_whitespace: true
```

### logger ^2.5.0

**Purpose**: Logging utility for debugging and monitoring

**Why we use it**:

- Structured logging
- Multiple log levels
- Customizable output formatting
- Performance monitoring

**Example Usage**:

```dart
// Logger configuration
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

// Usage in application
class AuthService {
  Future<User> login(String username, String password) async {
    AppLogger.info('Starting login process for user: $username');

    try {
      final result = await _apiService.login(username, password);
      AppLogger.info('Login successful for user: $username');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Login failed for user: $username', e, stackTrace);
      rethrow;
    }
  }
}

// Performance logging
class PerformanceLogger {
  static Future<T> measureExecutionTime<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await operation();
      stopwatch.stop();
      AppLogger.info('$operationName completed in ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      AppLogger.error('$operationName failed after ${stopwatch.elapsedMilliseconds}ms', e);
      rethrow;
    }
  }
}
```

**Vietnamese**:
logger cung cấp hệ thống ghi log có cấu trúc với nhiều mức độ khác nhau, hỗ trợ debug và giám sát hiệu suất.

## 🏗️ Code Generation

### build_runner ^2.4.14

**Purpose**: Code generation framework for Dart

**Why we use it**:

- Automates repetitive code generation
- Compile-time code generation
- Supports multiple generators
- Improves development productivity

**Example Usage**:

```bash
# Generate code
flutter packages pub run build_runner build

# Watch for changes and generate automatically
flutter packages pub run build_runner watch

# Clean generated files
flutter packages pub run build_runner clean
```

### freezed ^2.5.8

**Purpose**: Code generation for immutable classes

**Why we use it**:

- Generates immutable classes
- copyWith method generation
- Equality and hashCode
- Union types support
- JSON serialization integration

**Example Usage**:

```dart
// Define freezed class
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    String? avatar,
    @Default(false) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Generated code provides:
// - Immutable properties
// - copyWith method
// - Equality and hashCode
// - toString method
// - JSON serialization

// Usage
final user = User(id: 1, name: 'John', email: 'john@example.com');

// Create copy with changes
final updatedUser = user.copyWith(name: 'John Doe');

// Union types
@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.error(String message) = Error<T>;
  const factory ApiResult.loading() = Loading<T>;
}

// Usage with pattern matching
ApiResult<User> result = ApiResult.success(user);

result.when(
  success: (user) => print('User: ${user.name}'),
  error: (message) => print('Error: $message'),
  loading: () => print('Loading...'),
);
```

**Vietnamese**:
freezed tự động tạo code cho các lớp bất biến với các phương thức copyWith, equality và hỗ trợ union types.

### json_serializable ^6.9.3

**Purpose**: JSON serialization code generation

**Why we use it**:

- Automatic JSON serialization/deserialization
- Type-safe JSON handling
- Custom serialization logic
- Error handling

**Example Usage**:

```dart
// Model definition
@JsonSerializable()
class UserDto {
  final int id;
  final String name;
  final String email;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'is_active')
  final bool isActive;

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.createdAt,
    required this.isActive,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

// Custom serialization
@JsonSerializable()
class ProductDto {
  final int id;
  final String name;
  @JsonKey(fromJson: _priceFromJson, toJson: _priceToJson)
  final double price;
  @JsonKey(includeIfNull: false)
  final String? description;

  const ProductDto({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  static double _priceFromJson(dynamic price) {
    if (price is String) {
      return double.parse(price);
    }
    return price.toDouble();
  }

  static String _priceToJson(double price) {
    return price.toStringAsFixed(2);
  }

  factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
```

**Vietnamese**:
json_serializable tự động tạo code để chuyển đổi giữa JSON và Dart objects một cách type-safe và hiệu quả.

## 📊 Summary

This technology stack provides:

1. **Scalability**: Clean architecture with proper separation of concerns
2. **Maintainability**: Code generation reduces boilerplate and errors
3. **Performance**: Efficient state management and image caching
4. **Developer Experience**: Strong typing, linting, and debugging tools
5. **User Experience**: Responsive UI, smooth navigation, and offline support
6. **Security**: Secure storage for sensitive data
7. **Internationalization**: Multi-language support
8. **Testing**: Architecture supports comprehensive testing strategies

Each technology was chosen to work together harmoniously, creating a robust foundation for building scalable Flutter applications.

---

**Tóm tắt tiếng Việt**:
Ngăn xếp công nghệ này cung cấp một nền tảng vững chắc để xây dựng ứng dụng Flutter có khả năng mở rộng, với kiến trúc sạch, quản lý trạng thái hiệu quả, và trải nghiệm phát triển tốt.
