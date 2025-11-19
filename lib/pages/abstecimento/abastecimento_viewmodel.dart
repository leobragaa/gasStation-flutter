import 'package:flutter/material.dart';
import '../../data/models/abastecimento_model.dart';
import '../../data/repositories/abstecimento_repository.dart';

class AbastecimentoViewModel extends ChangeNotifier{
  final AbastecimentoRepository repository;

  AbastecimentoViewModel(this.repository);

  Stream<List<AbastecimentoModel>> get abstecimentosStream => repository.getVeiculos();

  Future<void> adicionarAbastecimento(AbastecimentoModel model) async{
    await repository.adicionarAbstecimento(model);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await repository.deletarVeiculo(id);
    notifyListeners();
  }
}