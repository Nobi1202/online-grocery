import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_grocery/data/datasources/local/secure_storage.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/domain/core/failures.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';
import 'package:online_grocery/domain/repositories/auth_repository.dart';
import 'package:online_grocery/domain/usecase/login_user_usecase.dart';
import 'package:online_grocery/presentation/bloc/login/login_bloc.dart';
import 'package:online_grocery/presentation/bloc/login/login_event.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

import 'login_integration_test.mocks.dart';

@GenerateMocks([IAuthRepository, SecureStorage, FailureMapper])
void main() {
  group('Login Integration Test', () {
    late MockIAuthRepository mockAuthRepository;
    late MockSecureStorage mockSecureStorage;
    late MockFailureMapper mockFailureMapper;
    late LoginUserUsecase loginUserUsecase;
    late TestableLoginBlocIntegration loginBloc;

    // Test data
    const testUsername = 'validUser';
    const testPassword = 'validPassword';
    const testInvalidUsername = 'invalidUser';
    const testInvalidPassword = 'invalidPassword';
    const testAccessToken = 'valid_access_token';
    const testRefreshToken = 'valid_refresh_token';

    const validUserLoginEntity = UserLoginEntity(
      id: 1,
      username: testUsername,
      email: 'valid@example.com',
      firstName: 'Valid',
      lastName: 'User',
      gender: 'male',
      image: 'valid_user_image.jpg',
      accessToken: testAccessToken,
      refreshToken: testRefreshToken,
    );

    setUp(() {
      mockAuthRepository = MockIAuthRepository();
      mockSecureStorage = MockSecureStorage();
      mockFailureMapper = MockFailureMapper();

      loginUserUsecase = LoginUserUsecase(mockAuthRepository);
      loginBloc = TestableLoginBlocIntegration(
        loginUserUsecase,
        mockSecureStorage,
        mockFailureMapper,
      );
    });

    group('Successful Login Flow', () {
      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should complete entire login flow successfully',
        build: () {
          // Mock successful repository response
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(validUserLoginEntity));

          // Mock successful token storage
          when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenAnswer((_) async {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, isSuccess: true),
        ],
        verify: (_) {
          // Verify usecase was called with correct parameters
          final captured = verify(
            mockAuthRepository.login(captureAny),
          ).captured;
          final userLoginSchema = captured.first as UserLoginSchema;
          expect(userLoginSchema.username, testUsername);
          expect(userLoginSchema.password, testPassword);

          // Verify tokens were saved
          verify(mockSecureStorage.saveToken(testAccessToken)).called(1);
          verify(
            mockSecureStorage.saveRefreshToken(testRefreshToken),
          ).called(1);
        },
      );

      test(
        'should save tokens in correct order during successful login',
        () async {
          // Arrange
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(validUserLoginEntity));
          when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenAnswer((_) async {});

          // Act
          loginBloc.add(OnLoginEvent(testUsername, testPassword));
          await Future.delayed(const Duration(milliseconds: 100));

          // Assert
          verifyInOrder([
            mockSecureStorage.saveToken(testAccessToken),
            mockSecureStorage.saveRefreshToken(testRefreshToken),
          ]);
        },
      );
    });

    group('Failed Login Flows', () {
      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle invalid credentials gracefully',
        build: () {
          const unauthorizedFailure = UnauthorizedFailure(
            cause: 'Invalid credentials',
          );
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(unauthorizedFailure));
          when(
            mockFailureMapper.mapFailureToMessage(unauthorizedFailure),
          ).thenReturn('Invalid username or password');

          return loginBloc;
        },
        act: (bloc) =>
            bloc.add(OnLoginEvent(testInvalidUsername, testInvalidPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Invalid username or password',
          ),
        ],
        verify: (_) {
          // Verify tokens were not saved
          verifyNever(mockSecureStorage.saveToken(any));
          verifyNever(mockSecureStorage.saveRefreshToken(any));

          // Verify error mapping was called
          verify(mockFailureMapper.mapFailureToMessage(any)).called(1);
        },
      );

      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle network failures',
        build: () {
          const networkFailure = NetworkFailure(
            cause: 'No internet connection',
          );
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(networkFailure));
          when(
            mockFailureMapper.mapFailureToMessage(networkFailure),
          ).thenReturn('Please check your internet connection');

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Please check your internet connection',
          ),
        ],
      );

      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle server errors',
        build: () {
          const serverFailure = ServerFailure(
            statusCode: 500,
            message: 'Internal server error',
          );
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(serverFailure));
          when(
            mockFailureMapper.mapFailureToMessage(serverFailure),
          ).thenReturn('Server error occurred. Please try again later.');

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Server error occurred. Please try again later.',
          ),
        ],
      );
    });

    group('Edge Cases', () {
      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle empty credentials',
        build: () {
          const unauthorizedFailure = UnauthorizedFailure();
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(unauthorizedFailure));
          when(
            mockFailureMapper.mapFailureToMessage(unauthorizedFailure),
          ).thenReturn('Username and password are required');

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent('', '')),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Username and password are required',
          ),
        ],
      );

      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle token storage failures gracefully',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(validUserLoginEntity));
          when(
            mockSecureStorage.saveToken(any),
          ).thenThrow(Exception('Storage failed'));
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenAnswer((_) async {});

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Exception: Storage failed',
          ),
        ],
      );

      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle refresh token storage failures',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(validUserLoginEntity));
          when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenThrow(Exception('Refresh token storage failed'));

          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Exception: Refresh token storage failed',
          ),
        ],
      );
    });

    group('Multiple Events', () {
      blocTest<TestableLoginBlocIntegration, LoginState>(
        'should handle multiple login attempts',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(validUserLoginEntity));
          when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenAnswer((_) async {});

          return loginBloc;
        },
        act: (bloc) {
          bloc.add(OnLoginEvent(testUsername, testPassword));
          bloc.add(OnLoginEvent(testUsername, testPassword));
        },
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, isSuccess: true),
          const LoginState(isLoading: true, isSuccess: true),
          const LoginState(isLoading: false, isSuccess: true),
        ],
      );
    });

    tearDown(() {
      loginBloc.close();
    });
  });
}

// Testable version for integration tests
class TestableLoginBlocIntegration extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase userLoginUsecase;
  final SecureStorage secureStorage;
  final FailureMapper failureMapper;

  TestableLoginBlocIntegration(
    this.userLoginUsecase,
    this.secureStorage,
    this.failureMapper,
  ) : super(const LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await userLoginUsecase(
        UserLoginSchema(username: event.username, password: event.password),
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMsg: failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (success) {
          secureStorage.saveToken(success.accessToken);
          secureStorage.saveRefreshToken(success.refreshToken);
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
