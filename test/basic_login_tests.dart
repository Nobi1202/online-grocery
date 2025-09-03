import 'package:flutter_test/flutter_test.dart';

// Domain Layer Tests
import 'domain/entities/user_login_entity_test.dart' as user_login_entity_test;
import 'domain/usecase/login_user_usecase_test.dart' as login_user_usecase_test;

// Data Layer Tests
import 'data/models/user_login_schema_test.dart' as user_login_schema_test;

// Presentation Layer Tests
import 'presentation/bloc/login/login_event_test.dart' as login_event_test;
import 'presentation/bloc/login/login_state_test.dart' as login_state_test;

/// Basic Login Flow Test Suite
///
/// This test suite includes the core login functionality tests that are working:
/// - Domain Layer: Entities and Use Cases
/// - Data Layer: Models and Schemas
/// - Presentation Layer: Events and States
///
/// These tests validate:
/// ✅ UserLoginEntity properties and equality
/// ✅ UserLoginSchema JSON serialization
/// ✅ LoginUserUsecase with mocked repository
/// ✅ LoginState immutability and copyWith
/// ✅ LoginEvent properties
///
/// Run with: `flutter test test/basic_login_tests.dart`
void main() {
  group('Basic Login Flow Tests', () {
    group('Domain Layer', () {
      user_login_entity_test.main();
      login_user_usecase_test.main();
    });

    group('Data Layer', () {
      user_login_schema_test.main();
    });

    group('Presentation Layer', () {
      login_event_test.main();
      login_state_test.main();
    });
  });
}
