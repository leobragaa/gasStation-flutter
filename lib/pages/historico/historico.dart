import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/abstecimento/abastecimento_viewmodel.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final abastecimentoViewModel = context.watch<AbastecimentoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Abastecimentos"),
      ),
      body: StreamBuilder(
        stream: abastecimentoViewModel.abstecimentosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum abastecimento registrado."));
          } else {
            final abastecimentos = snapshot.data!;
            return ListView.builder(
              itemCount: abastecimentos.length,
              itemBuilder: (context, index) {
                final abastecimento = abastecimentos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text("Tipo: ${abastecimento.tipoCombustivel} - Litros: ${abastecimento.litros.toStringAsFixed(2)}L"),
                    subtitle: Text(
                        "Valor: R\$${abastecimento.valorPago.toStringAsFixed(2)} - Data: ${abastecimento.data.day}/${abastecimento.data.month}/${abastecimento.data.year}"),
                    trailing: Text("Km: ${abastecimento.quilometragem}"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
