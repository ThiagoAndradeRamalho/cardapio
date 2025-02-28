import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/core/model/categoria_model.dart';
import 'package:my_place/controller/form_produto_controller.dart';
import 'package:my_place/core/model/produto_model.dart';
import 'package:my_place/pages/home_page.dart';

class ListaCategoriaController {
  CollectionReference categoriasRef =
      FirebaseFirestore.instance.collection('categorias');

  FormProdutoController? _produtoController;

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

  final _produtosRef = FirebaseFirestore.instance.collection('produtos');

    Future<List<ProdutoModel>> getProdutosCategoria(
      CategoriaModel categoria) async {
    final querySnapshot =
        await _produtosRef.where('categoria', isEqualTo: categoria.nome).get();
    final docs = querySnapshot.docs;
    return List.generate(
        docs.length, (i) => ProdutoModel.fromJson(docs[i].id, docs[i].data()));
  }

  Future<void> deleteCategoria(CategoriaModel categoria) async {
    try {
      await categoriasRef.doc(categoria.id).delete();
      final produtosCategoria =
          await getProdutosCategoria(categoria);

      logger.i('produtos: $produtosCategoria');
      for (ProdutoModel produto in produtosCategoria) {
        logger.i('deleting produto: $produto');
        await _produtosRef.doc(produto.id).delete();
      }
      
    } catch (e) {
      logger.e(e);
    }
  }

  Stream<QuerySnapshot> categoriasStream() {
    return _categoriasStream;
  }
}
