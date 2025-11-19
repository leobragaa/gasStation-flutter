import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/theme.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

 @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppTheme.primary,
              child: const Text(
                "Menu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pushReplacementNamed(context, "/home"),
            ),

            ListTile(
              leading: const Icon(Icons.car_rental),
              title: const Text("Meus Veículos"),
              onTap: () => Navigator.pushNamed(context, "/veiculo"),
            ),

            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text("Registrar Abastecimento"),
              onTap: () => Navigator.pushNamed(context, "/abastecer"),
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Histórico"),
              onTap: () => Navigator.pushNamed(context, "/historico"),
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Sair",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
