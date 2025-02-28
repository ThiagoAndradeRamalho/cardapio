import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_place/controller/form_produto_controller.dart';
import 'package:my_place/core/model/produto_model.dart';
import 'package:my_place/core/preco_utilis.dart';
import 'package:my_place/pages/home_page.dart';
import 'package:my_place/widgets/mp_button_icon.dart';
import 'package:my_place/widgets/mp_loading.dart';
import 'package:my_place/widgets/toasts/toasts_utils.dart';
import 'package:select_form_field/select_form_field.dart';

class FormProdutoPage extends StatefulWidget {
  const FormProdutoPage({
    super.key,
    this.produto,
  });

  final ProdutoModel? produto;

  @override
  State<FormProdutoPage> createState() => _FormProdutoPageState();
}

class _FormProdutoPageState extends State<FormProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  MoneyMaskedTextController? _precoController;
  FormProdutoController? _controller;

  @override
  void initState() {
    _controller = FormProdutoController(widget.produto ?? ProdutoModel());
    _precoController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      leftSymbol: 'R\$',
    )..text = _controller!.produto.preco;
    super.initState();
  }

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
                  title: Text(_controller?.produto.nome == '' ||
                          _controller?.produto.nome == null
                      ? 'Criar Produto'
                      : 'Editar Produto'),
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
                            await _controller!.salvaProduto();
                            showSucessToast('Produto foi salvao');
                            Navigator.of(context).pop();
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
                                    color: const Color.fromARGB(
                                        255, 251, 245, 243),
                                    child: _controller?.produto.urlImagem == ''
                                        ? Center(
                                            child: Icon(
                                              Icons.image_outlined,
                                              size: 100,
                                              color: const Color.fromARGB(
                                                  255, 236, 152, 137),
                                            ),
                                          )
                                        : Hero(
                                            tag: _controller?.produto.id ?? '',
                                            child: Image.network(
                                              _controller!.produto.urlImagem,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Icon(Icons.error,
                                                        color: const Color
                                                            .fromARGB(255, 234,
                                                            234, 234)));
                                              },
                                            )))),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Material(
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                color: const Color.fromARGB(255, 209, 209, 209),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.deepOrange,
                                  ),
                                  onPressed: () async {
                                    String? urlImagem =
                                        await _controller!.openDialog(context);
                                    setState(
                                      () => _controller!
                                          .setUrlImagemProduto(urlImagem),
                                    );
                                  },
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
                child: FutureBuilder<QuerySnapshot>(
                    future: _controller?.categoriasFutures,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;

                        final categorias =
                            _controller?.getCategoriasFromData(data.docs) ?? [];
                        logger.i("Categorias carregadas: $categorias");
                        logger.i(
                            "Categoria inicial: ${_controller?.produto.categoria}");
                        String? categoriaInicial =
                            categorias.contains(_controller?.produto.categoria)
                                ? _controller?.produto.categoria
                                : null;
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                value: categoriaInicial,
                                decoration:
                                    InputDecoration(labelText: 'Categoria'),
                                items: categorias.map((categoria) {
                                  return DropdownMenuItem<String>(
                                    value: categoria,
                                    child: Text(categoria),
                                  );
                                }).toList(),
                                onChanged: (categoria) {
                                  logger.i('Categoria selecionada: $categoria');
                                  setState(() => _controller!
                                      .setCategoriaProduto(categoria));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: 300,
                                child: TextFormField(
                                  initialValue: _controller!.produto.nome,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Nome',
                                    hintText: 'Nome',
                                  ),
                                  validator: (nome) => nome!.isEmpty
                                      ? 'Campo Obrigatorio'
                                      : null,
                                  onSaved: _controller!.setNomeProduto,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: 400,
                                child: TextFormField(
                                  initialValue:
                                      _controller?.produto.descricao ?? '',
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Descricao',
                                    hintText: 'Descricao',
                                  ),
                                  validator: (descricao) => descricao!.isEmpty
                                      ? 'Campo Obrigatorio'
                                      : null,
                                  onSaved: _controller!.setDescricaoProduto,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: 150,
                                child: TextFormField(
                                  controller: _precoController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r"\d+"),
                                    )
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Preço',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (preco) {
                                    if (preco == null || preco == 'R\$') {
                                      return 'Campo Obrigatorio';
                                    } else if (PrecoUtilis.getNumeroStringPreco(
                                            preco) ==
                                        0) {
                                      return 'O preco do produto nao pode ser 0';
                                    }
                                    return null;
                                  },
                                  onSaved: _controller!.setPrecoProduto,
                                  onChanged: (preco) =>
                                      _precoController!.text = preco,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: MpLoading(),
                        );
                      }
                    }),
              ),
            )),
      ),
    );
  }
}
