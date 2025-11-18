import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/abastecimento_model.dart';
import '../abastecimento_viewmodel.dart';
import '../../abstecimento/view/abstecimento_page.dart';

class AbastecimentoScreen extends StatelessWidget{
  const AbastecimentoScreen({super.key});

  @override
  Widget build(BuildContext context){
    final viewModel = context.watch<AbastecimentoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Abastecimentos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AbastecimentoForm()),
          ),
        child: const Icon(Icons.add),
      ),
      
      body: StreamBuilder<List<AbastecimentoModel>>(
        stream: viewModel.abstecimentosStream,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));

          } else if (!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text("Nenhum abastecimento cadastrado."));

          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              
              itemBuilder: (context, index){
                final abstecimento = data[index];

                return Dismissible(
                  key: Key(abstecimento.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await viewModel.delete(abstecimento.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Abastecimento de ${abstecimento.litros}L removido")),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text("Veículo ID: ${abstecimento.veiculoId}"),
                      subtitle: Text("Data: ${abstecimento.data} - Litros: ${abstecimento.litros}")
                    ),
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
