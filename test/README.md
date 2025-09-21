# Login Flow Unit Tests

This directory contains comprehensive unit tests for the login functionality following clean architecture principles.

## Test Structure

### Domain Layer Tests (`domain/`)

- **`entities/user_login_entity_test.dart`**: Tests for the UserLoginEntity domain model

  - Property validation
  - Equality and immutability tests
  - Edge cases

- **`usecase/login_user_usecase_test.dart`**: Tests for the LoginUserUsecase
  - Successful login scenarios
  - Various failure scenarios (network, server, unauthorized)
  - Parameter validation

### Data Layer Tests (`data/`)

- **`models/user_login_schema_test.dart`**: Tests for the UserLoginSchema request model
  - JSON serialization/deserialization
  - Property validation
  - Edge cases with special characters

### Presentation Layer Tests (`presentation/`)

- **`bloc/login/login_event_test.dart`**: Tests for login events

  - OnLoginEvent property validation
  - Edge cases with credentials

- **`bloc/login/login_state_test.dart`**: Tests for login state management

  - State immutability
  - copyWith functionality
  - Equality comparison

- **`bloc/login/login_bloc_test.dart`**: Tests for the LoginBloc
  - Event handling
  - State transitions
  - Error scenarios
  - Token storage verification

### Integration Tests (`integration/`)

- **`login_integration_test.dart`**: End-to-end login flow tests
  - Complete successful login flow
  - Various failure scenarios
  - Token storage integration
  - Multiple event handling

## Running Tests

### Run All Login Tests

```bash
flutter test test/login_flow_test.dart
```

### Run Specific Test Files

```bash
# Domain layer tests
flutter test test/domain/usecase/login_user_usecase_test.dart
flutter test test/domain/entities/user_login_entity_test.dart

# Data layer tests
flutter test test/data/models/user_login_schema_test.dart

# Presentation layer tests
flutter test test/presentation/bloc/login/login_bloc_test.dart
flutter test test/presentation/bloc/login/login_state_test.dart
flutter test test/presentation/bloc/login/login_event_test.dart

# Integration tests
flutter test test/integration/login_integration_test.dart
```

### Run All Tests

```bash
flutter test
```

### Generate Coverage Report

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Dependencies

The tests use the following packages:

- `flutter_test`: Core testing framework
- `bloc_test`: BLoC testing utilities
- `mockito`: Mock object generation
- `build_runner`: Code generation for mocks

## Mock Generation

Before running tests, generate mocks:

```bash
flutter packages pub run build_runner build
```

## Test Patterns

### Arrange-Act-Assert (AAA)

All tests follow the AAA pattern:

```dart
test('should return success when login is valid', () {
  // Arrange
  final mockRepository = MockAuthRepository();
  when(mockRepository.login(any)).thenAnswer((_) async => Right(validUser));

  // Act
  final result = await usecase(loginRequest);

  // Assert
  expect(result, Right(validUser));
});
```

### BLoC Testing

BLoC tests use `bloc_test` for clean state transition testing:

```dart
blocTest<LoginBloc, LoginState>(
  'should emit loading then success when login succeeds',
  build: () => loginBloc,
  act: (bloc) => bloc.add(OnLoginEvent('user', 'pass')),
  expect: () => [
    LoginState(isLoading: true),
    LoginState(isLoading: false, isSuccess: true),
  ],
);
```

### Mock Verification

Tests verify that dependencies are called correctly:

```dart
verify(mockRepository.login(expectedRequest)).called(1);
verifyNever(mockStorage.saveToken(any));
```

## Test Coverage

The test suite aims for high coverage across:

- ✅ Happy path scenarios
- ✅ Error handling
- ✅ Edge cases
- ✅ Boundary conditions
- ✅ State management
- ✅ Dependency interactions

## Continuous Integration

These tests are designed to run in CI/CD pipelines:

- Fast execution (< 30 seconds)
- No external dependencies
- Deterministic results
- Clear failure messages

## Best Practices Followed

1. **Test Isolation**: Each test is independent
2. **Clear Naming**: Test names describe the scenario and expected outcome
3. **Single Responsibility**: Each test validates one specific behavior
4. **Mock Verification**: Ensures correct dependency usage
5. **Edge Case Coverage**: Tests handle unusual inputs and error conditions
6. **Immutability Testing**: Verifies objects cannot be modified after creation
7. **Type Safety**: Uses strong typing throughout test code
