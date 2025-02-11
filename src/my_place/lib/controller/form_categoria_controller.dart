import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place/core/model/categoria_model.dart';

class FormCategoriaController {
  CategoriaModel _categoria = CategoriaModel();

  final _categoriasRef = FirebaseFirestore.instance.collection('categorias');
  Future<void> salvarCategoria() async {
    await _categoriasRef.add(_categoria.toJson());
  }
  
  void setNomeCategoria(String? nome) => _categoria.nome = nome!;

  void setDescricaoCategoria(String? descricao) =>
      _categoria.descricao = descricao!;
}
