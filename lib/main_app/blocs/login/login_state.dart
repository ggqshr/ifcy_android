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
    this.passwordVisible = true,
  });

  factory LoginState.empty() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      passwordVisible: true,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      passwordVisible: true,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      passwordVisible: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      passwordVisible: true,
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
      passwordVisible: true,
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
    return 'LoginState{isUserNameValid: $isUserNameValid, isPasswordValid: $isPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, passwordVisible: $passwordVisible}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          isUserNameValid == other.isUserNameValid &&
          isPasswordValid == other.isPasswordValid &&
          isSubmitting == other.isSubmitting &&
          isSuccess == other.isSuccess &&
          isFailure == other.isFailure &&
          passwordVisible == other.passwordVisible;

  @override
  int get hashCode =>
      isUserNameValid.hashCode ^
      isPasswordValid.hashCode ^
      isSubmitting.hashCode ^
      isSuccess.hashCode ^
      isFailure.hashCode ^
      passwordVisible.hashCode;
}
