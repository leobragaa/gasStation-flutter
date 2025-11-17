import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/repositorio.dart';

class CadastroViewModel extends ChangeNotifier{
  final AuthRepository _repositorio;

  bool isLoading = false;
  String? emailError;
  String? passwordError;

  CadastroViewModel(this._repositorio);

  Future<bool> cadastro(String email, String password) async{
    try{
      isLoading = true;
      emailError = null;
      passwordError = null;
      notifyListeners();

      final user = await _repositorio.cadastro(email, password);
      isLoading = false;
      notifyListeners();
      
      return user != null;

    }on FirebaseAuthException catch(e){
      isLoading = false;
      if(e.code == "email-already-in-use"){
        emailError = "Email já cadastrado";
      }else if(e.code == "invalid-email"){
        emailError = "Email Inválido";
      }else if(e.code == "operation-not-allowed"){
        passwordError = "Senha Fraca(Minimo 6 caracteres, 1 letra maiuscula)";
      }else{
        emailError = "Erro ao cadastrar";
      }
      notifyListeners();
      return false;

    }catch(e){
      isLoading = false;
      emailError = "Erro ao cadastrar";
      notifyListeners();
      return false;
    } 
  }
}