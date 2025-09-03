import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/domain/core/failures.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';
import 'package:online_grocery/domain/repositories/auth_repository.dart';
import 'package:online_grocery/domain/usecase/login_user_usecase.dart';

import 'login_user_usecase_test.mocks.dart';

@GenerateMocks([IAuthRepository])
void main() {
  group('LoginUserUsecase', () {
    late MockIAuthRepository mockAuthRepository;
    late LoginUserUsecase loginUserUsecase;

    // Test data
    const testUsername = 'testUser';
    const testPassword = 'testPassword';
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';

    final testUserLoginSchema = UserLoginSchema(
      username: testUsername,
      password: testPassword,
    );

    const testUserLoginEntity = UserLoginEntity(
      id: 1,
      username: testUsername,
      email: 'test@example.com',
      firstName: 'Test',
      lastName: 'User',
      gender: 'male',
      image: 'test_image_url',
      accessToken: testAccessToken,
      refreshToken: testRefreshToken,
    );

    setUp(() {
      mockAuthRepository = MockIAuthRepository();
      loginUserUsecase = LoginUserUsecase(mockAuthRepository);
    });

    group('call', () {
      test(
        'should return UserLoginEntity when repository call is successful',
        () async {
          // Arrange
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(testUserLoginEntity));

          // Act
          final result = await loginUserUsecase(testUserLoginSchema);

          // Assert
          expect(result, const Right(testUserLoginEntity));
          verify(mockAuthRepository.login(testUserLoginSchema)).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      test(
        'should return ServerFailure when repository returns server error',
        () async {
          // Arrange
          const testServerFailure = ServerFailure(
            statusCode: 401,
            message: 'Invalid credentials',
          );
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(testServerFailure));

          // Act
          final result = await loginUserUsecase(testUserLoginSchema);

          // Assert
          expect(result, const Left(testServerFailure));
          verify(mockAuthRepository.login(testUserLoginSchema)).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      test(
        'should return NetworkFailure when repository returns network error',
        () async {
          // Arrange
          const testNetworkFailure = NetworkFailure();
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(testNetworkFailure));

          // Act
          final result = await loginUserUsecase(testUserLoginSchema);

          // Assert
          expect(result, const Left(testNetworkFailure));
          verify(mockAuthRepository.login(testUserLoginSchema)).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      test(
        'should return UnauthorizedFailure when credentials are invalid',
        () async {
          // Arrange
          const testUnauthorizedFailure = UnauthorizedFailure();
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(testUnauthorizedFailure));

          // Act
          final result = await loginUserUsecase(testUserLoginSchema);

          // Assert
          expect(result, const Left(testUnauthorizedFailure));
          verify(mockAuthRepository.login(testUserLoginSchema)).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      test('should pass correct parameters to repository', () async {
        // Arrange
        final expectedSchema = UserLoginSchema(
          username: 'specificUser',
          password: 'specificPassword',
        );
        when(
          mockAuthRepository.login(any),
        ).thenAnswer((_) async => const Right(testUserLoginEntity));

        // Act
        await loginUserUsecase(expectedSchema);

        // Assert
        verify(mockAuthRepository.login(expectedSchema)).called(1);
      });
    });
  });
}
