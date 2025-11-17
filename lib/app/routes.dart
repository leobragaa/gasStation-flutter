import 'package:flutter/material.dart';
import '../pages/login/login.dart';
import '../pages/cadastro/cadastro.dart';

final Map<String, WidgetBuilder> routes = {
  "/login": (context) => const LoginScreen(),
  "/cadastro": (context) => const CadastroScreen(),
};