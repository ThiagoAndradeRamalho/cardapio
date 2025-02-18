import 'package:flutter/material.dart';
import 'package:my_place/core/model/categoria_model.dart';

class MpAlertDialog extends StatefulWidget {
  MpAlertDialog({
    super.key,
    this.urlImagem,
  });

  String? urlImagem;

  @override
  _MpAlertDialogState createState() => _MpAlertDialogState();
}

class _MpAlertDialogState extends State<MpAlertDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.urlImagem ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Link da Imagem'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Escreva o link da imagem",
        ),
        controller: controller,
        onChanged: (value) {
          setState(() {
            widget.urlImagem = controller.text;
          });
        },
      ),
      actions: [
        TextButton(
          child: Text('SUBMIT'),
          onPressed: submit,
        ),
      ],
    );
  }

  void submit() {
    Navigator.of(context).pop(controller.text);
  }
}
