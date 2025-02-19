import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_place/controller/lista_produto_controller.dart';
import 'package:my_place/pages/form_produto_page.dart';
import 'package:my_place/widgets/mp_appBar.dart';
import 'package:my_place/widgets/mp_button_icon.dart';
import 'package:my_place/widgets/mp_empty.dart';
import 'package:my_place/widgets/mp_list_tile.dart';
import 'package:my_place/widgets/mp_list_view.dart';
import 'package:my_place/widgets/mp_loading.dart';

final Logger logger = Logger();

class ListaProdutoPage extends StatelessWidget {
  ListaProdutoPage({
    super.key,
  });

  final _controller = ListaProdutoController();

  @override
  Widget build(BuildContext context) {
    //logger.i(user.email);
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Produtos'),
        actions: [
          MPButtonIcon(
              iconData: Icons.add,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FormProdutoPage(),
                  ),
                );
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.produtosStream,
        builder: (context, snapshot) {
          logger.i("Snapshot estado: ${snapshot.connectionState}");
          logger.i("Tem dados? ${snapshot.hasData}");
          logger.i(
              "Quantidade de produtos: ${snapshot.data?.docs.length ?? 0}");

          if (snapshot.hasData) {
            logger.i("ENTROU");
            final produtos =
                _controller.getProdutosFromData(snapshot.data!.docs);
            if (produtos.isEmpty) {
              return MPEmpty();
            } else {
              return MpListView(
                  itemCount: produtos.length,
                  itemBuilder: (context, i) => MpListTile(
                        leading: Hero(
                          tag: produtos[i].id,
                          child: produtos[i].urlImagem != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(produtos[i].urlImagem),
                                )
                              : Icon(Icons.fastfood),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                           await _controller.deleteProduto(produtos[i]);
                          },
                        ),
                        title: Text(produtos[i].nome),
                        onTap: () {
                          print("Produto válida, navegando...");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  FormProdutoPage(produto: produtos[i]),
                            ),
                          );
                        },
                      ));
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: MpLoading(),
            );
          }
          return MPEmpty();
        },
      ),
    );
  }
}
