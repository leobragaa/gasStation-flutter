import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../veiculo_viewmodel.dart';

class VeiculoForm extends StatefulWidget {
  const VeiculoForm({super.key});

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final modelo = TextEditingController();
  final marca = TextEditingController();
  final placa = TextEditingController();
  final ano = TextEditingController();

  String tipoCombustivel = "Gasolina";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<VeiculoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Veiculo")),

      body: Padding(padding: const EdgeInsets.all(16),
        child: ListView(
          children:[
            TextField(
              controller: modelo,
              decoration: const InputDecoration(
                labelText: "Modelo",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: marca,
              decoration: const InputDecoration(
                labelText: "Marca",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: placa,
              decoration: const InputDecoration(
                labelText: "Placa",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ano,
              decoration: const InputDecoration(
                labelText: "Ano",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: tipoCombustivel,
              items: const [
                DropdownMenuItem(value: "Gasolina", child: Text("Gasolina")),
                DropdownMenuItem(value: "Diesel", child: Text("Diesel")),
                DropdownMenuItem(value: "Eletrico", child: Text("Eletrico")),
              ],
              onChanged: (value) {
                setState(() =>
                  tipoCombustivel = value.toString(),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async{
                await viewModel.adicionarVeiculo(
                  modelo: modelo.text,
                  marca: marca.text,
                  placa: placa.text,
                  ano: ano.text,
                  tipoCombustivel: tipoCombustivel,
                );
                Navigator.pop(context);
              },
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  } 
}