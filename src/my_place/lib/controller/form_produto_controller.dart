import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place/core/model/categoria_model.dart';
import 'package:my_place/core/model/produto_model.dart';
import 'package:my_place/pages/home_page.dart';
import 'package:my_place/widgets/mp_alert_dialog.dart';

class FormProdutoController {
  FormProdutoController(
    this._produto,
  );

  ProdutoModel _produto;

  final _produtosRef = FirebaseFirestore.instance.collection('produtos');
  final _categoriasRef = FirebaseFirestore.instance.collection('categorias');

  ProdutoModel get produto => _produto;

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => MpAlertDialog(
            urlImagem: _produto.urlImagem,
          ));

  Future<QuerySnapshot> get categoriasFutures => _categoriasRef.get();

  List<String> getCategoriasFromData(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final doc = docs[i];
      var dados = doc.data() as Map<String, dynamic>? ?? {};
      return dados['nome']?.toString() ?? '';
    });
  }

  Future<List<ProdutoModel>> getProdutosCategoria(
      CategoriaModel categoria) async {
    final querySnapshot =
        await _produtosRef.where('categoria', isEqualTo: categoria.nome).get();
    final docs = querySnapshot.docs;
    return List.generate(
        docs.length, (i) => ProdutoModel.fromJson(docs[i].id, docs[i].data()));
  }

  Future<void> salvaProduto() async {
    try {
      if (_produto.id.isNotEmpty) {
        await _produtosRef.doc(_produto.id).update(_produto.toJson());
        logger.i('passou DE NOVO');
      } else {
        await _produtosRef.add(_produto.toJson());
      }
    } catch (e) {
      logger.i(e);
    }
  }

  void setPrecoProduto(String? preco) => _produto.preco = preco!;

  void setUrlImagemProduto(String? urlImagem) =>
      _produto.urlImagem = urlImagem!;

  void setNomeProduto(String? nome) => _produto.nome = nome!;

  void setDescricaoProduto(String? descricao) =>
      _produto.descricao = descricao!;

  void setCategoriaProduto(String? categoria) {
    if (categoria != null && categoria is String) {
      _produto.categoria = categoria;
    } else {
      logger.e('Erro ao definir categoria: tipo inválido');
    }
  }
}
