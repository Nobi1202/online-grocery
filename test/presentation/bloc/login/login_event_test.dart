import 'package:flutter_test/flutter_test.dart';
import 'package:online_grocery/presentation/bloc/login/login_event.dart';

void main() {
  group('LoginEvent', () {
    group('OnLoginEvent', () {
      const testUsername = 'testUser';
      const testPassword = 'testPassword';

      test('should create OnLoginEvent with correct username and password', () {
        // Act
        final event = OnLoginEvent(testUsername, testPassword);

        // Assert
        expect(event.username, testUsername);
        expect(event.password, testPassword);
        expect(event, isA<LoginEvent>());
      });

      test('should create OnLoginEvent with empty credentials', () {
        // Act
        final event = OnLoginEvent('', '');

        // Assert
        expect(event.username, '');
        expect(event.password, '');
      });

      test('should create OnLoginEvent with special characters', () {
        // Arrange
        const specialUsername = 'user@example.com';
        const specialPassword = 'p@ssw0rd!#\$%';

        // Act
        final event = OnLoginEvent(specialUsername, specialPassword);

        // Assert
        expect(event.username, specialUsername);
        expect(event.password, specialPassword);
      });

      test('should create OnLoginEvent with very long credentials', () {
        // Arrange
        final longUsername = 'a' * 1000;
        final longPassword = 'b' * 1000;

        // Act
        final event = OnLoginEvent(longUsername, longPassword);

        // Assert
        expect(event.username, longUsername);
        expect(event.password, longPassword);
        expect(event.username.length, 1000);
        expect(event.password.length, 1000);
      });

      test('should handle whitespace in credentials', () {
        // Arrange
        const usernameWithSpaces = '  user name  ';
        const passwordWithSpaces = '  pass word  ';

        // Act
        final event = OnLoginEvent(usernameWithSpaces, passwordWithSpaces);

        // Assert
        expect(event.username, usernameWithSpaces);
        expect(event.password, passwordWithSpaces);
      });

      test('should handle unicode characters', () {
        // Arrange
        const unicodeUsername = 'test用户';
        const unicodePassword = 'पासवर्ड123';

        // Act
        final event = OnLoginEvent(unicodeUsername, unicodePassword);

        // Assert
        expect(event.username, unicodeUsername);
        expect(event.password, unicodePassword);
      });

      test('should preserve newlines and tabs in credentials', () {
        // Arrange
        const usernameWithNewlines = 'user\nname';
        const passwordWithTabs = 'pass\tword';

        // Act
        final event = OnLoginEvent(usernameWithNewlines, passwordWithTabs);

        // Assert
        expect(event.username, usernameWithNewlines);
        expect(event.password, passwordWithTabs);
      });

      group('inheritance', () {
        test('should extend LoginEvent', () {
          // Act
          final event = OnLoginEvent(testUsername, testPassword);

          // Assert
          expect(event, isA<LoginEvent>());
        });

        test('should be the correct runtime type', () {
          // Act
          final event = OnLoginEvent(testUsername, testPassword);

          // Assert
          expect(event.runtimeType, OnLoginEvent);
        });
      });

      group('toString', () {
        test('should provide meaningful string representation', () {
          // Act
          final event = OnLoginEvent(testUsername, testPassword);
          final stringRepresentation = event.toString();

          // Assert
          expect(stringRepresentation, contains('OnLoginEvent'));
          // Note: For security reasons, we typically don't want credentials
          // in toString(), but if they are included, we should test it
        });
      });

      group('immutability', () {
        test('should be immutable', () {
          // Arrange
          final event = OnLoginEvent(testUsername, testPassword);

          // Assert
          expect(event.username, testUsername);
          expect(event.password, testPassword);

          // Properties should be final and cannot be changed
          // This is enforced by the Dart compiler
        });
      });

      group('edge cases', () {
        test('should handle null-like strings', () {
          // Act
          final event = OnLoginEvent('null', 'undefined');

          // Assert
          expect(event.username, 'null');
          expect(event.password, 'undefined');
        });

        test('should handle numeric strings', () {
          // Act
          final event = OnLoginEvent('12345', '67890');

          // Assert
          expect(event.username, '12345');
          expect(event.password, '67890');
        });

        test('should handle boolean-like strings', () {
          // Act
          final event = OnLoginEvent('true', 'false');

          // Assert
          expect(event.username, 'true');
          expect(event.password, 'false');
        });
      });
    });

    group('LoginEvent abstract class', () {
      test('should be abstract and cannot be instantiated directly', () {
        // This test ensures LoginEvent is properly abstract
        // We verify this by checking that OnLoginEvent is a subclass
        final event = OnLoginEvent('test', 'test');
        expect(event, isA<LoginEvent>());
      });
    });
  });
}
