import 'package:flutter/material.dart';
import '../../data/models/abastecimento_model.dart';
import '../../data/repositories/abstecimento_repository.dart';

class AbastecimentoViewModel extends ChangeNotifier{
  final AbastecimentoRepository repository;

  AbastecimentoViewModel(this.repository);

  Stream<List<AbastecimentoModel>> get abstecimentosStream => repository.getVeiculos();

  Future<void> adicionarAbastecimento({
    required String veiculoId,
    required DateTime data,
    required double litros,
    required double km,
    required double precoPorLitro,
    required String tipoCombustivel,
    required String posto,
    required double quilometragem,
    required double valorPago,
    required double consumo,
  })async{
    final consumo = km / litros;

    final model = AbastecimentoModel(
      id: "", 
      veiculoId: veiculoId, 
      data: data, 
      litros: litros, 
      precoPorLitro: precoPorLitro, 
      tipoCombustivel: tipoCombustivel, 
      posto: posto, 
      quilometragem: quilometragem, 
      valorPago: valorPago, 
      consumo: consumo,
    );

    await repository.adicionarAbstecimento(model);
    
  }

  Future<void> delete(String id) async {
    await repository.deletarVeiculo(id);
    notifyListeners();
  }
}