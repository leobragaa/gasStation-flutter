import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/abastecimento_model.dart';

class AbastecimentoRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userId;

  AbastecimentoRepository({required this.userId});

  CollectionReference get _collection => 
    firestore.collection("users").doc(userId).collection("abstecimentos");

  Future<void> adicionarAbstecimento(AbastecimentoModel abstecimento) async {
    await _collection.add(abstecimento.toMap());
  }

  Future<void> deletarVeiculo(String id) async {
    await _collection.doc().delete();
  }

  Stream <List<AbastecimentoModel>> getVeiculos(){
    return _collection
      .orderBy("data", descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => AbastecimentoModel.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ))
          .toList(),
      );
  }
}