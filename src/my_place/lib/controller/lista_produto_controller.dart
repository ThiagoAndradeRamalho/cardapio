import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/core/model/produto_model.dart';

class ListaProdutoController {
  CollectionReference _produtoRef =
      FirebaseFirestore.instance.collection('produtos');

  final Stream<QuerySnapshot> _produtoStream =
      FirebaseFirestore.instance.collection('produtos').snapshots();

  Stream<QuerySnapshot> get produtosStream => _produtoStream;

  List<ProdutoModel> getProdutosFromData(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      print('entrou de novo');
      final produtoDoc = docs[i];
      return ProdutoModel.fromJson(
        produtoDoc.id,
        produtoDoc.data() as Map<String, dynamic>,
      );
    });
  }

  Future<void> deleteProduto(ProdutoModel produto) async {
    await _produtoRef.doc(produto.id,).delete();
  }
}
