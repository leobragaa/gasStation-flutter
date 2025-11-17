class CadastroState {
  final String? emailError;
  final String? passwordError;
  final bool isLoading;
  final String? nameError;
  final String? confirmPasswordError;

  CadastroState({
    this.emailError,
    this.passwordError,
    this.isLoading = false,
    this.nameError,
    this.confirmPasswordError,
  });

  CadastroState copyWith({
    String? emailError,
    String? passwordError,
    bool? isLoading,
    String? nameError,
    String? confirmPasswordError,
  }) {
    return CadastroState(
      emailError: emailError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
      nameError: nameError,
      confirmPasswordError: confirmPasswordError,
    );
  }
}
