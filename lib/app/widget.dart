import 'package:flutter/material.dart';
import 'package:gas_station_p2/data/repositories/repositorio.dart';
import 'package:provider/provider.dart';
import '../pages/cadastro/cadastro_viewmodel.dart';
import '../pages/login/login_viewmodel.dart';
import '../pages/veiculos/veiculo_viewmodel.dart';
import '../data/repositories/veiculo_repository.dart';
import '../data/repositories/abstecimento_repository.dart';
import '../pages/abstecimento/abastecimento_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes.dart';
import '../core/theme.dart';

class AppWidget extends StatelessWidget{
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),

        ChangeNotifierProvider(
          create: (c) => LoginViewModel(c.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (c) => CadastroViewModel(c.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (c) => VeiculoViewModel(VeiculoRepository(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),

        ChangeNotifierProvider(
          create: (c) => AbastecimentoViewModel(AbastecimentoRepository(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gas Station",
        theme: AppTheme.theme,
        initialRoute: '/login',
        routes: routes,
      ),
    );
  }
}