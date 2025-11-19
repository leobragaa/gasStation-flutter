import 'package:flutter/material.dart';
import 'package:gas_station_p2/data/repositories/repositorio.dart';
import 'package:provider/provider.dart';
import '../pages/cadastro/cadastro_viewmodel.dart';
import '../pages/login/login_viewmodel.dart';
import '../pages/login/login.dart';
import '../core/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/dashboard/home.dart';
import '../pages/veiculos/veiculo_viewmodel.dart';
import '../pages/abstecimento/abastecimento_viewmodel.dart';
import '../pages/veiculos/view/veiculo.dart';
import '../pages/veiculos/view/veiculo_page.dart';
import '../pages/abstecimento/view/abastecimento.dart';
import '../data/repositories/veiculo_repository.dart';
import '../data/repositories/abstecimento_repository.dart';

class AppWidget extends StatelessWidget{
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),
        ChangeNotifierProvider(create: (c) => LoginViewModel(c.read<AuthRepository>())),
        ChangeNotifierProvider(create: (c) => CadastroViewModel(c.read<AuthRepository>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gas Station",
        theme: AppTheme.theme,

        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
      if(snapshot.hasData){
        final uid = snapshot.data!.uid;
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => VeiculoViewModel(
                      VeiculoRepository(userId: uid),
                    ),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AbastecimentoViewModel(
                      AbastecimentoRepository(userId: uid),
                    ),
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Gas Station",
                  theme: AppTheme.theme,
                  home: const HomeScreen(),
                  routes: {
                    "/veiculo": (context) => const VeiculoScreen(),
                    "/abastecer": (context) => const AbastecimentoScreen(),
                    "/adicionar_veiculo": (context) => const VeiculoForm(),
                    "/veiculo_adicionar": (context) => const HomeScreen(),
                  }
                ) 
              );
            }
            return const LoginScreen();
          }  
        ),
      ),
    );
  }
}

