class UsuarioModel {
  final String uid;
  final String nome;
  final String email;
  final String? fotoUrl;
  final DateTime criadoEm;

  UsuarioModel({
    required this.uid,
    required this.nome,
    required this.email,
    this.fotoUrl,
    required this.criadoEm,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "nome": nome,
      "email": email,
      "fotoUrl": fotoUrl,
      "criadoEm": criadoEm.toIso8601String(),
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      uid: map["uid"],
      nome: map["nome"],
      email: map["email"],
      fotoUrl: map["fotoUrl"],
      criadoEm: DateTime.parse(map["criadoEm"]),
    );
  }
}
