import 'package:flutter_test/flutter_test.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';

void main() {
  group('UserLoginSchema', () {
    const testUsername = 'testUser';
    const testPassword = 'testPassword';

    group('constructor', () {
      test('should create UserLoginSchema with correct properties', () {
        // Act
        final schema = UserLoginSchema(
          username: testUsername,
          password: testPassword,
        );

        // Assert
        expect(schema.username, testUsername);
        expect(schema.password, testPassword);
      });

      test('should create UserLoginSchema with required parameters', () {
        // This test ensures the constructor requires both username and password
        expect(
          () => UserLoginSchema(username: testUsername, password: testPassword),
          returnsNormally,
        );
      });
    });

    group('toJson', () {
      test('should convert UserLoginSchema to JSON correctly', () {
        // Arrange
        final schema = UserLoginSchema(
          username: testUsername,
          password: testPassword,
        );
        final expectedJson = {
          'username': testUsername,
          'password': testPassword,
        };

        // Act
        final json = schema.toJson();

        // Assert
        expect(json, expectedJson);
        expect(json['username'], testUsername);
        expect(json['password'], testPassword);
      });

      test('should handle empty strings correctly', () {
        // Arrange
        final schema = UserLoginSchema(username: '', password: '');
        final expectedJson = {'username': '', 'password': ''};

        // Act
        final json = schema.toJson();

        // Assert
        expect(json, expectedJson);
      });

      test('should handle special characters correctly', () {
        // Arrange
        const specialUsername = 'user@example.com';
        const specialPassword = 'p@ssw0rd!';
        final schema = UserLoginSchema(
          username: specialUsername,
          password: specialPassword,
        );

        // Act
        final json = schema.toJson();

        // Assert
        expect(json['username'], specialUsername);
        expect(json['password'], specialPassword);
      });
    });

    group('fromJson', () {
      test('should create UserLoginSchema from JSON correctly', () {
        // Arrange
        final json = {'username': testUsername, 'password': testPassword};

        // Act
        final schema = UserLoginSchema.fromJson(json);

        // Assert
        expect(schema.username, testUsername);
        expect(schema.password, testPassword);
      });

      test('should handle empty strings from JSON correctly', () {
        // Arrange
        final json = {'username': '', 'password': ''};

        // Act
        final schema = UserLoginSchema.fromJson(json);

        // Assert
        expect(schema.username, '');
        expect(schema.password, '');
      });

      test('should handle special characters from JSON correctly', () {
        // Arrange
        const specialUsername = 'user@example.com';
        const specialPassword = 'p@ssw0rd!';
        final json = {'username': specialUsername, 'password': specialPassword};

        // Act
        final schema = UserLoginSchema.fromJson(json);

        // Assert
        expect(schema.username, specialUsername);
        expect(schema.password, specialPassword);
      });
    });

    group('JSON serialization roundtrip', () {
      test('should maintain data integrity through toJson/fromJson cycle', () {
        // Arrange
        final originalSchema = UserLoginSchema(
          username: testUsername,
          password: testPassword,
        );

        // Act
        final json = originalSchema.toJson();
        final reconstructedSchema = UserLoginSchema.fromJson(json);

        // Assert
        expect(reconstructedSchema.username, originalSchema.username);
        expect(reconstructedSchema.password, originalSchema.password);
      });

      test('should handle complex credentials through roundtrip', () {
        // Arrange
        const complexUsername = 'complex.user+test@example.com';
        const complexPassword = 'C0mpl3x!P@ssw0rd#123';
        final originalSchema = UserLoginSchema(
          username: complexUsername,
          password: complexPassword,
        );

        // Act
        final json = originalSchema.toJson();
        final reconstructedSchema = UserLoginSchema.fromJson(json);

        // Assert
        expect(reconstructedSchema.username, originalSchema.username);
        expect(reconstructedSchema.password, originalSchema.password);
      });
    });
  });
}
