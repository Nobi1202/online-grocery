import 'package:flutter_test/flutter_test.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';

void main() {
  group('UserLoginEntity', () {
    const testId = 1;
    const testUsername = 'testUser';
    const testEmail = 'test@example.com';
    const testFirstName = 'Test';
    const testLastName = 'User';
    const testGender = 'male';
    const testImage = 'test_image_url';
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';

    const testUserLoginEntity = UserLoginEntity(
      id: testId,
      username: testUsername,
      email: testEmail,
      firstName: testFirstName,
      lastName: testLastName,
      gender: testGender,
      image: testImage,
      accessToken: testAccessToken,
      refreshToken: testRefreshToken,
    );

    group('constructor', () {
      test('should create UserLoginEntity with all required properties', () {
        // Act & Assert
        expect(testUserLoginEntity.id, testId);
        expect(testUserLoginEntity.username, testUsername);
        expect(testUserLoginEntity.email, testEmail);
        expect(testUserLoginEntity.firstName, testFirstName);
        expect(testUserLoginEntity.lastName, testLastName);
        expect(testUserLoginEntity.gender, testGender);
        expect(testUserLoginEntity.image, testImage);
        expect(testUserLoginEntity.accessToken, testAccessToken);
        expect(testUserLoginEntity.refreshToken, testRefreshToken);
      });

      test('should create entity with different data types correctly', () {
        // Arrange
        const entity = UserLoginEntity(
          id: 999,
          username: 'anotherUser',
          email: 'another@example.com',
          firstName: 'Another',
          lastName: 'User',
          gender: 'female',
          image: 'another_image_url',
          accessToken: 'another_access_token',
          refreshToken: 'another_refresh_token',
        );

        // Assert
        expect(entity.id, 999);
        expect(entity.username, 'anotherUser');
        expect(entity.email, 'another@example.com');
        expect(entity.firstName, 'Another');
        expect(entity.lastName, 'User');
        expect(entity.gender, 'female');
        expect(entity.image, 'another_image_url');
        expect(entity.accessToken, 'another_access_token');
        expect(entity.refreshToken, 'another_refresh_token');
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, entity2);
        expect(entity1.hashCode, entity2.hashCode);
      });

      test('should not be equal when id is different', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: 1,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: 2,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });

      test('should not be equal when username is different', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: 'user1',
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: 'user2',
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });

      test('should not be equal when email is different', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: 'user1@example.com',
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: 'user2@example.com',
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });

      test('should not be equal when firstName is different', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: 'First',
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: 'Second',
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });

      test('should not be equal when lastName is different', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: 'LastName1',
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: 'LastName2',
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });

      test('should have consistent hashCode for equal entities', () {
        // Arrange
        const entity1 = testUserLoginEntity;
        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, entity2);
        expect(entity1.hashCode, entity2.hashCode);
      });
    });

    group('props', () {
      test('should include correct properties in equality comparison', () {
        // The entity uses id, username, email, firstName, lastName in props
        // based on the implementation in the domain entity

        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: 'different_gender', // Different gender
          image: 'different_image', // Different image
          accessToken: 'different_access_token', // Different access token
          refreshToken: 'different_refresh_token', // Different refresh token
        );

        // Act & Assert
        // Since gender, image, accessToken, and refreshToken are not in props,
        // these entities should still be considered equal
        expect(entity1, entity2);
      });

      test('should not be equal when props-included properties differ', () {
        // Arrange
        const entity1 = UserLoginEntity(
          id: testId,
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        const entity2 = UserLoginEntity(
          id: 999, // Different id (included in props)
          username: testUsername,
          email: testEmail,
          firstName: testFirstName,
          lastName: testLastName,
          gender: testGender,
          image: testImage,
          accessToken: testAccessToken,
          refreshToken: testRefreshToken,
        );

        // Act & Assert
        expect(entity1, isNot(entity2));
      });
    });

    group('immutability', () {
      test('should be immutable', () {
        // Arrange
        const entity = testUserLoginEntity;

        // Assert
        expect(entity.id, testId);
        expect(entity.username, testUsername);
        expect(entity.email, testEmail);
        expect(entity.firstName, testFirstName);
        expect(entity.lastName, testLastName);
        expect(entity.gender, testGender);
        expect(entity.image, testImage);
        expect(entity.accessToken, testAccessToken);
        expect(entity.refreshToken, testRefreshToken);

        // Properties should be final and cannot be changed
        // This is enforced by the Dart compiler
      });
    });
  });
}
