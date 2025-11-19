import 'package:flutter/material.dart';
import 'package:gas_station_p2/pages/abstecimento/view/abastecimento.dart';
import 'package:gas_station_p2/pages/dashboard/home.dart';
import 'package:gas_station_p2/pages/veiculos/view/veiculo_page.dart';
import '../pages/login/login.dart';
import '../pages/cadastro/cadastro.dart';
import '../pages/veiculos/view/veiculo.dart';
import '../pages/historico/historico.dart';


final Map<String, WidgetBuilder> routes = {
  "/home": (context) => const HomeScreen(),

  "/login": (context) => const LoginScreen(),
  
  "/cadastro": (context) => const CadastroScreen(),

  "/veiculo": (context) => const VeiculoScreen(),
  
  "/veiculos_adicionar": (context) => const VeiculoForm(),

  "/abastecer": (context) => const AbastecimentoScreen(),
  
  "/historico": (context) => const HistoricoScreen(),
};

