import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/theme.dart';
import '../../app/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return Scaffold(
    appBar: AppBar(
      title: const Text('Gas Calculete'),
      backgroundColor: AppTheme.primary,
      foregroundColor: Color(0xFF1E1E1E),
    ),
    drawer: const AppDrawer(),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/gas-station.png",
              height: 180,
            ),
            const SizedBox(height: 20),
            Text(
              "Bem-Vindo, ${user?.email ?? "Usuario"}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/veiculo"),
              child: const Text("Veiculos"),
                
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/abastecer"),
              child: const Text("Registrar Abastecimento"),  
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/historico"),
              child: const Text("Historico"),  
            ),
          ],
        ),
      ),
    );
  }
}