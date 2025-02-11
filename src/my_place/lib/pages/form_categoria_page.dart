import 'package:flutter/material.dart';
import 'package:my_place/controller/form_categoria_controller.dart';
import 'package:my_place/widgets/mp_button_icon.dart';

class FormCategoriaPage extends StatefulWidget {
  const FormCategoriaPage({super.key});

  @override
  State<FormCategoriaPage> createState() => _FormCategoriaPageState();
}

class _FormCategoriaPageState extends State<FormCategoriaPage> {
  final _formKey = GlobalKey<FormState>();
  FormCategoriaController _controller = FormCategoriaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              expandedHeight: 240,
              collapsedHeight: 40,
              toolbarHeight: 38,
              elevation: 0.5,
              floating: false,
              pinned: true,
              title: Text('Criar Categoria'),
              leadingWidth: 40,
              leading: MPButtonIcon(
                iconData: Icons.chevron_left,
                onTap: () => Navigator.of(context).pop(),
              ),
              actions: [
                MPButtonIcon(
                    iconData: Icons.check,
                    onTap: () async {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        form.save();
                        await _controller.salvarCategoria();
                      }
                    }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                    padding: EdgeInsets.fromLTRB(16, 44, 16, 20),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.maxFinite,
                              color: Colors.deepOrange,
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 100,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            )),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Material(
                            borderRadius: BorderRadiusDirectional.circular(30),
                            color: Colors.deepOrange,
                            child: PopupMenuButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.deepOrange,
                              ),
                              itemBuilder: (_) => [
                                PopupMenuItem<String>(
                                    value: 'camera',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo_camera,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Camera'),
                                      ],
                                    )),
                                PopupMenuItem<String>(
                                    value: 'Galeria',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo_library,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Galeria'),
                                      ],
                                    )),
                              ],
                              onSelected: (valor) async {},
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Nome',
                        hintText: 'Nome',
                      ),
                      validator: (nome) =>
                          nome!.isEmpty ? 'Campo Obrigatorio' : null,
                      onSaved: _controller.setNomeCategoria,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 400,
                    child: TextFormField(
                      initialValue:  '',
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Descricao',
                        hintText: 'Descricao',
                      ),
                      validator: (descricao) =>
                          descricao!.isEmpty ? 'Campo Obrigatorio' : null,
                      onSaved: _controller.setDescricaoCategoria,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
