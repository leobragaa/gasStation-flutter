class LoginState {
  final String? emailError;
  final String? passwordError;
  final bool isLoading;

  LoginState({
    this.emailError,
    this.passwordError,
    this.isLoading = false,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? isLoading,
  }) {
    return LoginState(
      emailError: emailError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}