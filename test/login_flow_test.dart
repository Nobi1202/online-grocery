import 'package:flutter_test/flutter_test.dart';

// Domain Layer Tests
import 'domain/entities/user_login_entity_test.dart' as user_login_entity_test;
import 'domain/usecase/login_user_usecase_test.dart' as login_user_usecase_test;

// Data Layer Tests
import 'data/models/user_login_schema_test.dart' as user_login_schema_test;

// Presentation Layer Tests
import 'presentation/bloc/login/login_event_test.dart' as login_event_test;
import 'presentation/bloc/login/login_state_test.dart' as login_state_test;
import 'presentation/bloc/login/login_bloc_test.dart' as login_bloc_test;

// Integration Tests
import 'integration/login_integration_test.dart' as login_integration_test;

/// Main test suite for the complete login flow
///
/// This test suite covers all layers of the clean architecture:
/// - Domain Layer: Entities and Use Cases
/// - Data Layer: Models and Schemas
/// - Presentation Layer: BLoC, Events, and States
/// - Integration: End-to-end login flow
///
/// Run this test with: `flutter test test/login_flow_test.dart`
/// Run all tests with: `flutter test`
void main() {
  group('Complete Login Flow Test Suite', () {
    group('Domain Layer Tests', () {
      user_login_entity_test.main();
      login_user_usecase_test.main();
    });

    group('Data Layer Tests', () {
      user_login_schema_test.main();
    });

    group('Presentation Layer Tests', () {
      login_event_test.main();
      login_state_test.main();
      login_bloc_test.main();
    });

    group('Integration Tests', () {
      login_integration_test.main();
    });
  });
}
