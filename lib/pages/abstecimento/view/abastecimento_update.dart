import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../abstecimento/abastecimento_viewmodel.dart';
import '../../../data/models/abastecimento_model.dart';

class AbastecimentoUpdate extends StatefulWidget{
  final AbastecimentoModel abstecimento;
  const AbastecimentoUpdate({
    super.key, 
    required this.abstecimento
  });

  @override
  State<AbastecimentoUpdate> createState() => _AbastecimentoUpdateState();
}

class _AbastecimentoUpdateState extends State<AbastecimentoUpdate>{
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController valor;
  late TextEditingController litrosController;
  late TextEditingController precoPorLitroController;
  late TextEditingController tipoCombustivelController;
  late TextEditingController quilometragemController;

  late String tipoCombustivel;
  late DateTime dataSelecionada;

  @override
  void initState() {
    super.initState();
    valor = TextEditingController(text: widget.abstecimento.valorPago.toString());
    litrosController = TextEditingController(text: widget.abstecimento.litros.toString());
    precoPorLitroController = TextEditingController(text: widget.abstecimento.precoPorLitro.toString());
    tipoCombustivel = widget.abstecimento.tipoCombustivel;
    dataSelecionada = widget.abstecimento.data;
  }

  @override
  Widget build(BuildContext context){
    final abstecimentoViewModel = context.read<AbastecimentoViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Atualizar Abastecimento")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: litrosController,
                  decoration: const InputDecoration(
                    labelText: "Litros"),
                  validator: (validar) {
                    if (validar == null || validar.isEmpty) {
                      return 'Digite a quantidade de litros';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: precoPorLitroController,
                  decoration: const InputDecoration(
                    labelText: "Preço por litro"),
                  validator: (validar) {
                    if (validar == null || validar.isEmpty) {
                      return 'Digite o preço por litro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: quilometragemController,
                  decoration: const InputDecoration(
                    labelText: "Quilometragem"),
                  validator: (validar){
                    if(validar == null || validar.isEmpty) {
                      return 'Digite a quilometragem';
                    }
                    return null;
                  },   
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: valor,
                  decoration: const InputDecoration(
                    labelText: "Valor pago"),
                  validator: (validar){
                    if(validar == null || validar.isEmpty) {
                      return 'Digite o valor pago';
                    }
                    return null;
                  },   
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
                    if(!_formKey.currentState!.validate()) return;

                    final atualizado = AbastecimentoModel(
                      id: widget.abstecimento.id,
                      data: dataSelecionada,
                      posto: widget.abstecimento.posto,
                      veiculoId: widget.abstecimento.veiculoId,
                      valorPago: double.parse(valor.text),
                      litros: double.parse(litrosController.text),
                      precoPorLitro: double.parse(precoPorLitroController.text),
                      tipoCombustivel: tipoCombustivel,
                      consumo: double.parse(litrosController.text) / double.parse(quilometragemController.text),
                      quilometragem: double.parse(quilometragemController.text),
                    );
                    await abstecimentoViewModel.adicionarAbastecimento(atualizado);
                    if(context.mounted) Navigator.pop(context);
                  },
                  child: const Text("Atualizar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}