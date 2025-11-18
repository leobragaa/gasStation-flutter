import 'package:flutter/material.dart';
import '../../data/models/veiculo_model.dart';
import '../../data/repositories/veiculo_repository.dart';

class VeiculoViewModel extends ChangeNotifier{
  final VeiculoRepository repository;

  VeiculoViewModel(this.repository);

  Stream<List<VeiculoModel>> get veiculosStream => repository.getVeiculos();

  Future<void> adicionarVeiculo({
    required String modelo,
    required String marca,
    required String placa,
    required String ano,
    required String tipoCombustivel,
  })async{
    await repository.adicionarVeiculo(
      VeiculoModel(
        id: "", 
        modelo: modelo, 
        marca: marca, 
        placa: placa, 
        ano: int.parse(ano), 
        tipoCombustivel: tipoCombustivel,
      ),
    );
  }
  Future<void> delete(String id) async {
    await repository.deletarVeiculo(id);
    notifyListeners();
  }
}
