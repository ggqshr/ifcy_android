import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isUserNameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool passwordVisible;

  bool get isFormValid => isUserNameValid && isPasswordValid;

  LoginState({
    @required this.isUserNameValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    this.passwordVisible = false,
  });

  factory LoginState.empty() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      passwordVisible: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      passwordVisible: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      passwordVisible: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      passwordVisible: false,
    );
  }

  LoginState update({
    bool isUserNameValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isUserNameValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      passwordVisible: false,
    );
  }

  LoginState showPassword() {
    return copyWith(passwordVisible: !this.passwordVisible);
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool passwordVisible,
  }) {
    return LoginState(
      isUserNameValid: isEmailValid ?? this.isUserNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  String toString() {
    return 'LoginState{isEmailValid: $isUserNameValid, isPasswordValid: $isPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure}';
  }
}
