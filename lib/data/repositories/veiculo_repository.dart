import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/veiculo_model.dart';

class VeiculoRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String userId;

  VeiculoRepository({required this.userId});

  CollectionReference get _collection => 
    firestore.collection("users").doc(userId).collection("veiculos");

  Future<void> adicionarVeiculo(VeiculoModel veiculo) async {
    await _collection.add(veiculo.toMap());
  }

  Future<void> deletarVeiculo(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<VeiculoModel>> getVeiculos(){
    return _collection.snapshots().map(
      (snapshot){
        return snapshot.docs
          .map((doc) => VeiculoModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      }
    );
  }
}
