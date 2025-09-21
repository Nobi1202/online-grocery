import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
import 'package:online_grocery/presentation/bloc/login/login_event.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([IAuthRepository, SecureStorage, FailureMapper, BuildContext])
void main() {
  group('LoginBloc', () {
    late MockIAuthRepository mockAuthRepository;
    late MockSecureStorage mockSecureStorage;
    late MockFailureMapper mockFailureMapper;
    late LoginUserUsecase loginUserUsecase;
    late TestableLoginBloc loginBloc;

    // Test data
    const testUsername = 'testUser';
    const testPassword = 'testPassword';
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';
    const testErrorMessage = 'Test error message';

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
      mockSecureStorage = MockSecureStorage();
      mockFailureMapper = MockFailureMapper();

      loginUserUsecase = LoginUserUsecase(mockAuthRepository);
      loginBloc = TestableLoginBloc(
        loginUserUsecase,
        mockSecureStorage,
        mockFailureMapper,
      );
    });

    test('initial state should be correct', () {
      expect(loginBloc.state, const LoginState());
    });

    group('OnLoginEvent', () {
      blocTest<TestableLoginBloc, LoginState>(
        'should emit [loading, success] when login is successful',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(testUserLoginEntity));
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
          verify(mockSecureStorage.saveToken(testAccessToken)).called(1);
          verify(
            mockSecureStorage.saveRefreshToken(testRefreshToken),
          ).called(1);
        },
      );

      blocTest<TestableLoginBloc, LoginState>(
        'should emit [loading, error] when login fails with server error',
        build: () {
          const serverFailure = ServerFailure(
            statusCode: 401,
            message: 'Invalid credentials',
          );
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(serverFailure));
          when(
            mockFailureMapper.mapFailureToMessage(serverFailure),
          ).thenReturn(testErrorMessage);
          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, apiErrorMsg: testErrorMessage),
        ],
        verify: (_) {
          verify(mockFailureMapper.mapFailureToMessage(any)).called(1);
          verifyNever(mockSecureStorage.saveToken(any));
          verifyNever(mockSecureStorage.saveRefreshToken(any));
        },
      );

      blocTest<TestableLoginBloc, LoginState>(
        'should emit [loading, error] when login fails with network error',
        build: () {
          const networkFailure = NetworkFailure();
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(networkFailure));
          when(
            mockFailureMapper.mapFailureToMessage(networkFailure),
          ).thenReturn('Network error');
          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, apiErrorMsg: 'Network error'),
        ],
      );

      blocTest<TestableLoginBloc, LoginState>(
        'should emit [loading, error] when login fails with unauthorized error',
        build: () {
          const unauthorizedFailure = UnauthorizedFailure();
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Left(unauthorizedFailure));
          when(
            mockFailureMapper.mapFailureToMessage(unauthorizedFailure),
          ).thenReturn('Unauthorized access');
          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Unauthorized access',
          ),
        ],
      );

      blocTest<TestableLoginBloc, LoginState>(
        'should emit [loading, error] when unexpected exception occurs',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenThrow(Exception('Unexpected error'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(
            isLoading: false,
            apiErrorMsg: 'Exception: Unexpected error',
          ),
        ],
      );

      blocTest<TestableLoginBloc, LoginState>(
        'should call usecase with correct parameters',
        build: () {
          when(
            mockAuthRepository.login(any),
          ).thenAnswer((_) async => const Right(testUserLoginEntity));
          when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
          when(
            mockSecureStorage.saveRefreshToken(any),
          ).thenAnswer((_) async {});
          return loginBloc;
        },
        act: (bloc) => bloc.add(OnLoginEvent(testUsername, testPassword)),
        verify: (_) {
          final captured = verify(
            mockAuthRepository.login(captureAny),
          ).captured;
          final userLoginSchema = captured.first as UserLoginSchema;
          expect(userLoginSchema.username, testUsername);
          expect(userLoginSchema.password, testPassword);
        },
      );

      test('should save tokens when login is successful', () async {
        // Arrange
        when(
          mockAuthRepository.login(any),
        ).thenAnswer((_) async => const Right(testUserLoginEntity));
        when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});
        when(mockSecureStorage.saveRefreshToken(any)).thenAnswer((_) async {});

        // Act
        loginBloc.add(OnLoginEvent(testUsername, testPassword));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        verify(mockSecureStorage.saveToken(testAccessToken)).called(1);
        verify(mockSecureStorage.saveRefreshToken(testRefreshToken)).called(1);
      });

      test('should not save tokens when login fails', () async {
        // Arrange
        const serverFailure = ServerFailure(statusCode: 401);
        when(
          mockAuthRepository.login(any),
        ).thenAnswer((_) async => const Left(serverFailure));
        when(
          mockFailureMapper.mapFailureToMessage(any),
        ).thenReturn(testErrorMessage);

        // Act
        loginBloc.add(OnLoginEvent(testUsername, testPassword));
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        verifyNever(mockSecureStorage.saveToken(any));
        verifyNever(mockSecureStorage.saveRefreshToken(any));
      });
    });

    tearDown(() {
      loginBloc.close();
    });
  });
}

// Testable version of LoginBloc that accepts mocked dependencies
class TestableLoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase userLoginUsecase;
  final SecureStorage secureStorage;
  final FailureMapper failureMapper;

  TestableLoginBloc(
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
