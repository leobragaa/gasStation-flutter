import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../veiculo_viewmodel.dart';
import '../../../data/models/veiculo_model.dart';
import 'veiculo.dart';

class VeiculoScreen extends StatelessWidget{
  const VeiculoScreen({super.key});

  @override
  Widget build(BuildContext context){
    final viewModel = context.watch<VeiculoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Veiculos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VeiculoForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
      
      body: StreamBuilder<List<VeiculoModel>>(
        stream: viewModel.veiculosStream,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));

          } else if (!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text("Nenhum veículo cadastrado."));

          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              
              itemBuilder: (context, index){
                final veiculo = data[index];

                return Dismissible(
                  key: Key(veiculo.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await viewModel.delete(veiculo.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${veiculo.modelo} removido")),
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
                      title: Text("${veiculo.marca} ${veiculo.modelo}"),
                      subtitle: Text("Placa: ${veiculo.placa} - Ano: ${veiculo.ano} - Combustível: ${veiculo.tipoCombustivel}"),
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
        