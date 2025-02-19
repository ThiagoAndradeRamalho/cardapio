import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place/core/model/categoria_model.dart';
import 'package:my_place/pages/lista_categoria_page.dart';
import 'package:my_place/widgets/mp_alert_dialog.dart';

class FormCategoriaController {
  FormCategoriaController(this._categoria);

  final CategoriaModel _categoria;

  final _categoruaRef = FirebaseFirestore.instance.collection('categorias');

  CategoriaModel get categoria => _categoria;

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => MpAlertDialog(
            urlImagem: _categoria.urlImagem,
          ));

  Future<void> salvaCategoria() async {
    try {
      if (_categoria.id != null || _categoria.id != '') {
        await _categoruaRef.doc(_categoria.id).update(_categoria.toJson());
      } else {
        await _categoruaRef.add(_categoria.toJson());
      }

      logger.i('salvou');
    } catch (e) {
      logger.e(e);
    }
  }

  void setUrlImagemCategoria(String? urlImagem) =>
      _categoria.urlImagem = urlImagem!;

  void setNomeCategoria(String? nome) => _categoria.nome = nome!;

  void setDescricaoCategoria(String? descricao) =>
      _categoria.descricao = descricao!;
}
