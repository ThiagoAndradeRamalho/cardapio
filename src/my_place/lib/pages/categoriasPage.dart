import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place/controller/listaCategoriaController.dart';
import 'package:logger/logger.dart';
import 'package:my_place/pages/form_categoria_page.dart';
import 'package:my_place/widgets/mp_appBar.dart';
import 'package:my_place/widgets/mp_button_icon.dart';
import 'package:my_place/widgets/mp_empty.dart';
import 'package:my_place/widgets/mp_list_tile.dart';
import 'package:my_place/widgets/mp_list_view.dart';
import 'package:my_place/widgets/mp_loading.dart';

final Logger logger = Logger();

class ListaCategoriaPage extends StatelessWidget {
  ListaCategoriaPage({
    super.key,
  });

  final _controller = ListaCategoriaController();

  @override
  Widget build(BuildContext context) {
    //logger.i(user.email);
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Categorias'),
        actions: [
          MPButtonIcon(
              iconData: Icons.add,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FormCategoriaPage(),
                  ),
                );
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.categoriasStream(),
        builder: (context, snapshot) {
          logger.i("Snapshot estado: ${snapshot.connectionState}");
          logger.i("Tem dados? ${snapshot.hasData}");
          logger.i(
              "Quantidade de categorias: ${snapshot.data?.docs.length ?? 0}");

          if (snapshot.hasData) {
            logger.i("ENTROU");
            final categorias =
                _controller.getCategoriasFromDocs(snapshot.data!.docs);
            if (categorias.isEmpty) {
              return MPEmpty();
            } else {
              return MpListView(
                  itemCount: categorias.length,
                  itemBuilder: (context, i) => MpListTile(
                        leading: Hero(
                          tag: categorias[i].id,
                          child: categorias[i].urlImagem != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(categorias[i].urlImagem),
                                )
                              : Icon(Icons.category),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                        title: Text(categorias[i].nome),
                        onTap: () {
                          print("Categoria válida, navegando...");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  FormCategoriaPage(categoria: categorias[i]),
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
