import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place/core/model/produto_model.dart';
import 'package:my_place/widgets/mp_alert_dialog.dart';

class FormProdutoController {
  FormProdutoController(
    this._produto,
  );

  ProdutoModel _produto;

  final _categoruaRef = FirebaseFirestore.instance.collection('produtos');

  ProdutoModel get produto => _produto;

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => MpAlertDialog(
            urlImagem: _produto.urlImagem,
          ));

  Future<void> salvaProduto() async {
    try {
      if (_produto.id != null || _produto.id != '') {
        await _categoruaRef.doc(_produto.id).update(_produto.toJson());
      } else {
        await _categoruaRef.add(_produto.toJson());
      }
    } catch (e) {
      print(e);
    }
  }

  void setPrecoProduto(String? preco) => _produto.preco = preco!;

  void setUrlImagemProduto(String? urlImagem) =>
      _produto.urlImagem = urlImagem!;

  void setNomeProduto(String? nome) => _produto.nome = nome!;

  void setDescricaoProduto(String? descricao) =>
      _produto.descricao = descricao!;
}
