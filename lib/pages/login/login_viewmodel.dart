import 'package:flutter/material.dart';
import '../../data/repositories/repositorio.dart';
import 'login_state.dart';

class LoginViewModel extends ChangeNotifier{

  final AuthRepository _repositorio;
  LoginState state = LoginState();


  LoginViewModel(this._repositorio);

  Future<bool> login(String email, String password) async{
    try{
      state = state.copyWith(
        isLoading: true, 
        passwordError: null, 
        emailError: null
      );
      notifyListeners();

      final user = await _repositorio.login(email, password);
      state = state.copyWith(isLoading: false);
      notifyListeners();

      return user != null;
    }catch(e){
      state = state.copyWith(
        isLoading: false, 
        passwordError: "Senha Incorreta", 
        emailError: "Email Incorreto"
      );

      notifyListeners();
      return false; 
    }
  }

  Future<bool> loginWithGoogle() async{
    try{
      state = state.copyWith(isLoading: true, passwordError: null, emailError: null);
      notifyListeners();

      final user = await _repositorio.loginWithGoogle();
      state = state.copyWith(isLoading: false);
      notifyListeners();

      return user != null;
    }catch(e){
      state = state.copyWith(
        isLoading: false, 
        passwordError: null, 
        emailError: null
      );
      notifyListeners();
      return false; 
    }
  }
}