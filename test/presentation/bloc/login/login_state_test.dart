import 'package:flutter_test/flutter_test.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';

void main() {
  group('LoginState', () {
    group('constructor', () {
      test('should create initial state with correct default values', () {
        // Act
        const state = LoginState();

        // Assert
        expect(state.isLoading, false);
        expect(state.apiErrorMsg, '');
        expect(state.isSuccess, false);
      });

      test('should create state with custom isLoading value', () {
        // Act
        const state = LoginState(isLoading: true);

        // Assert
        expect(state.isLoading, true);
        expect(state.apiErrorMsg, '');
        expect(state.isSuccess, false);
      });

      test('should create state with custom apiErrorMsg value', () {
        // Arrange
        const errorMsg = 'Test error message';

        // Act
        const state = LoginState(apiErrorMsg: errorMsg);

        // Assert
        expect(state.isLoading, false);
        expect(state.apiErrorMsg, errorMsg);
        expect(state.isSuccess, false);
      });

      test('should create state with custom isSuccess value', () {
        // Act
        const state = LoginState(isSuccess: true);

        // Assert
        expect(state.isLoading, false);
        expect(state.apiErrorMsg, '');
        expect(state.isSuccess, true);
      });

      test('should create state with all custom values', () {
        // Arrange
        const errorMsg = 'Custom error';

        // Act
        const state = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: true,
        );

        // Assert
        expect(state.isLoading, true);
        expect(state.apiErrorMsg, errorMsg);
        expect(state.isSuccess, true);
      });
    });

    group('copyWith', () {
      test('should return new instance with updated isLoading', () {
        // Arrange
        const initialState = LoginState();

        // Act
        final updatedState = initialState.copyWith(isLoading: true);

        // Assert
        expect(updatedState.isLoading, true);
        expect(updatedState.apiErrorMsg, '');
        expect(updatedState.isSuccess, false);
        expect(updatedState, isNot(initialState));
      });

      test('should return new instance with updated apiErrorMsg', () {
        // Arrange
        const initialState = LoginState();
        const errorMsg = 'New error message';

        // Act
        final updatedState = initialState.copyWith(apiErrorMsg: errorMsg);

        // Assert
        expect(updatedState.isLoading, false);
        expect(updatedState.apiErrorMsg, errorMsg);
        expect(updatedState.isSuccess, false);
        expect(updatedState, isNot(initialState));
      });

      test('should return new instance with updated isSuccess', () {
        // Arrange
        const initialState = LoginState();

        // Act
        final updatedState = initialState.copyWith(isSuccess: true);

        // Assert
        expect(updatedState.isLoading, false);
        expect(updatedState.apiErrorMsg, '');
        expect(updatedState.isSuccess, true);
        expect(updatedState, isNot(initialState));
      });

      test('should return new instance with multiple updated fields', () {
        // Arrange
        const initialState = LoginState(
          isLoading: true,
          apiErrorMsg: 'Old error',
        );
        const newErrorMsg = 'New error message';

        // Act
        final updatedState = initialState.copyWith(
          isLoading: false,
          apiErrorMsg: newErrorMsg,
          isSuccess: true,
        );

        // Assert
        expect(updatedState.isLoading, false);
        expect(updatedState.apiErrorMsg, newErrorMsg);
        expect(updatedState.isSuccess, true);
        expect(updatedState, isNot(initialState));
      });

      test(
        'should preserve existing values when copyWith parameters are null',
        () {
          // Arrange
          const errorMsg = 'Existing error';
          const initialState = LoginState(
            isLoading: true,
            apiErrorMsg: errorMsg,
            isSuccess: true,
          );

          // Act
          final updatedState = initialState.copyWith();

          // Assert
          expect(updatedState.isLoading, true);
          expect(updatedState.apiErrorMsg, errorMsg);
          expect(updatedState.isSuccess, true);
          expect(updatedState, initialState); // Should be equal
        },
      );

      test('should update only specified fields and preserve others', () {
        // Arrange
        const errorMsg = 'Existing error';
        const initialState = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: false,
        );

        // Act
        final updatedState = initialState.copyWith(isSuccess: true);

        // Assert
        expect(updatedState.isLoading, true); // Preserved
        expect(updatedState.apiErrorMsg, errorMsg); // Preserved
        expect(updatedState.isSuccess, true); // Updated
      });

      test('should be able to clear apiErrorMsg', () {
        // Arrange
        const initialState = LoginState(apiErrorMsg: 'Some error');

        // Act
        final updatedState = initialState.copyWith(apiErrorMsg: '');

        // Assert
        expect(updatedState.apiErrorMsg, '');
        expect(updatedState.isLoading, false);
        expect(updatedState.isSuccess, false);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const errorMsg = 'Test error';
        const state1 = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: true,
        );
        const state2 = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: true,
        );

        // Act & Assert
        expect(state1, state2);
        expect(state1.hashCode, state2.hashCode);
      });

      test('should not be equal when isLoading differs', () {
        // Arrange
        const state1 = LoginState(isLoading: true);
        const state2 = LoginState(isLoading: false);

        // Act & Assert
        expect(state1, isNot(state2));
      });

      test('should not be equal when apiErrorMsg differs', () {
        // Arrange
        const state1 = LoginState(apiErrorMsg: 'Error 1');
        const state2 = LoginState(apiErrorMsg: 'Error 2');

        // Act & Assert
        expect(state1, isNot(state2));
      });

      test('should not be equal when isSuccess differs', () {
        // Arrange
        const state1 = LoginState(isSuccess: true);
        const state2 = LoginState(isSuccess: false);

        // Act & Assert
        expect(state1, isNot(state2));
      });

      test('should have consistent hashCode for equal states', () {
        // Arrange
        const errorMsg = 'Test error';
        const state1 = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: false,
        );
        const state2 = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: false,
        );

        // Act & Assert
        expect(state1, state2);
        expect(state1.hashCode, state2.hashCode);
      });
    });

    group('props', () {
      test(
        'should include all properties in props for equality comparison',
        () {
          // Arrange
          const state = LoginState(
            isLoading: true,
            apiErrorMsg: 'Test error',
            isSuccess: true,
          );

          // Act
          final props = state.props;

          // Assert
          expect(props, [true, 'Test error', true]);
          expect(props.length, 3);
        },
      );

      test('should use props for equality comparison', () {
        // Arrange
        const state1 = LoginState(
          isLoading: true,
          apiErrorMsg: 'Error',
          isSuccess: false,
        );
        const state2 = LoginState(
          isLoading: true,
          apiErrorMsg: 'Error',
          isSuccess: false,
        );

        // Act & Assert
        expect(state1.props, state2.props);
        expect(state1, state2);
      });
    });

    group('immutability', () {
      test('should be immutable', () {
        // Arrange
        const errorMsg = 'Test error';
        const state = LoginState(
          isLoading: true,
          apiErrorMsg: errorMsg,
          isSuccess: true,
        );

        // Assert
        expect(state.isLoading, true);
        expect(state.apiErrorMsg, errorMsg);
        expect(state.isSuccess, true);

        // Properties should be final and cannot be changed
        // This is enforced by the Dart compiler
      });
    });

    group('toString', () {
      test('should provide meaningful string representation', () {
        // Arrange
        const state = LoginState(
          isLoading: true,
          apiErrorMsg: 'Test error',
          isSuccess: false,
        );

        // Act
        final stringRepresentation = state.toString();

        // Assert
        expect(stringRepresentation, contains('LoginState'));
        expect(stringRepresentation, contains('true'));
        expect(stringRepresentation, contains('Test error'));
        expect(stringRepresentation, contains('false'));
      });
    });
  });
}
