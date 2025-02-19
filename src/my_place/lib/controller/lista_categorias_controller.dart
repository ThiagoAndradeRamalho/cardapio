import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/core/model/categoria_model.dart';

class ListaCategoriaController {
  CollectionReference categoriasRef =
      FirebaseFirestore.instance.collection('categorias');

  final Stream<QuerySnapshot> _categoriasStream =
      FirebaseFirestore.instance.collection('categorias').snapshots();

  List<CategoriaModel> getCategoriasFromDocs(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final categoriaDoc = docs[i];
      return CategoriaModel.fromJson(
        categoriaDoc.id,
        categoriaDoc.data() as Map<String, dynamic>,
      );
    });
  }

  Future<void> deleteCategoria(CategoriaModel categoria) async {
    await categoriasRef.doc(categoria.id).delete();
  }

  Stream<QuerySnapshot> categoriasStream() {
    return _categoriasStream;
  }
}
