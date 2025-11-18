class AbastecimentoModel {
  final String id;
  final String veiculoId;
  final DateTime data;
  final double litros;
  final double precoPorLitro;
  final String tipoCombustivel;
  final String posto;
  final double quilometragem;
  final double valorPago;
  final double consumo;

  AbastecimentoModel({
    required this.id,
    required this.veiculoId,
    required this.data,
    required this.litros,
    required this.valorPago,
    required this.consumo,
    required this.precoPorLitro,
    required this.tipoCombustivel,
    required this.posto,
    required this.quilometragem,
  });

  Map<String, dynamic> toMap() {
    return {
      'veiculoId': veiculoId,
      'data': data.toIso8601String(),
      'litros': litros,
      'precoPorLitro': precoPorLitro,
      'tipoCombustivel': tipoCombustivel,
      'posto': posto,
      'quilometragem': quilometragem,
      'valorPago': valorPago,
      'consumo': consumo,
    };
  }

  factory AbastecimentoModel.fromMap(String id, Map<String, dynamic> map) {
    return AbastecimentoModel(
      id: id,
      veiculoId: map['veiculoId'],
      data: DateTime.parse(map['data']),
      litros: map['litros'],
      precoPorLitro: map['precoPorLitro'],
      valorPago: map['valorPago'],
      tipoCombustivel: map['tipoCombustivel'],
      posto: map['posto'],
      quilometragem: map['quilometragem'],
      consumo: map['consumo'],
      
    );
  }
}