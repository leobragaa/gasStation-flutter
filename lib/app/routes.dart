import 'package:flutter/material.dart';
import 'package:gas_station_p2/pages/veiculos/view/veiculo_page.dart';
import '../pages/login/login.dart';
import '../pages/cadastro/cadastro.dart';
import '../pages/veiculos/view/veiculo.dart';

final Map<String, WidgetBuilder> routes = {
  "/login": (context) => const LoginScreen(),
  "/cadastro": (context) => const CadastroScreen(),
  "/veiculos": (context) => const VeiculoScreen(),
  "/veiculos_adicionar": (context) => const VeiculoForm(),
};