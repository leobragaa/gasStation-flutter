import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../veiculos/veiculo_viewmodel.dart';
import '../abastecimento_viewmodel.dart';
import '../../../data/models/veiculo_model.dart';
import '../../../data/models/abastecimento_model.dart';



class AbastecimentoForm extends StatefulWidget{
  const AbastecimentoForm({super.key});

  @override
  State<AbastecimentoForm> createState() => _AbastecimentoFormState();
}

class _AbastecimentoFormState extends State<AbastecimentoForm>{
  final litros = TextEditingController();
  final precoPorLitro = TextEditingController();
  final posto = TextEditingController();
  final quilometragem = TextEditingController();
  final valorPago = TextEditingController();


  String? veiculoSelecionadoId;
  String tipoCombustivel = "Gasolina";
  DateTime dataSelecionada = DateTime.now();

  Future<void> selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataSelecionada) {
      setState(() {
        dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final abstecimentoViewModel = context.read<AbastecimentoViewModel>();
    final veiculoViewModel = context.watch<VeiculoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Abastecimento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            StreamBuilder<List<VeiculoModel>>(
              stream: veiculoViewModel.veiculosStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erro: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("Nenhum veículo cadastrado.");
                } else {
                  final veiculos = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: veiculoSelecionadoId,
                    hint: const Text("Selecione o Veículo"),
                    items: veiculos.map((veiculo) {
                      return DropdownMenuItem(
                        value: veiculo.id,
                        child: Text("${veiculo.marca} ${veiculo.modelo} (${veiculo.placa})"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        veiculoSelecionadoId = value;
                      });
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: litros,
              decoration: const InputDecoration(
                labelText: "Litros",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: precoPorLitro,
              decoration: const InputDecoration(
                labelText: "Preço por litro",
              ),
            ),
            const SizedBox(height: 10),
              TextField(
              controller: quilometragem,
              decoration: const InputDecoration(
                labelText: "Quilometragem",
              ),
            ),
            const SizedBox(height: 10),
              TextField(
              controller: valorPago,
              decoration: const InputDecoration(
                labelText: "Valor pago",
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
            TextField(
              controller: posto,
              decoration: const InputDecoration(
                labelText: "Posto",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (veiculoSelecionadoId == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Selecionando Veiculo")
                    ),
                   );
                  return; 
                }
                
                final litrosValor = double.parse(litros.text);
                final precoPorLitroValor = double.parse(precoPorLitro.text);
                final quilometragemValor = double.parse(quilometragem.text);
                final valorPagoValor = double.parse(valorPago.text);
                final consumo = litrosValor / quilometragemValor;

                final newAbastecimento = AbastecimentoModel(
                  id: "",
                  veiculoId: veiculoSelecionadoId!,
                  data: dataSelecionada,
                  litros: litrosValor,
                  precoPorLitro: precoPorLitroValor,
                  tipoCombustivel: tipoCombustivel,
                  posto: posto.text,
                  quilometragem: quilometragemValor,
                  valorPago: valorPagoValor,
                  consumo: consumo,
                );

                await abstecimentoViewModel.adicionarAbastecimento(newAbastecimento);
                if(context.mounted) Navigator.pop(context);
              },
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  } 
}
