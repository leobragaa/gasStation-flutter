class Validators {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return "Nome é Obrigatorio";
    }
    return null;
  }

  static String? validateEmail(String? email) {

    if (email == null || email.isEmpty) {
      return "Email é Obrigatorio";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return "Email inválido";
    }
    
    return null;      
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Senha é Obrigatoria";
    }
    if (password.length < 6){
      return "Minimo de 6 caracteres";
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Minimo uma letra maiuscula";
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirmar Senha é Obrigatoria";
    }
    if (password != confirmPassword) {
      return "Senhas não conferem";
    }
    return null;
  }
}
