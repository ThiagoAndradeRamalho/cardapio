class ProdutoModel {
  late String id;
  late String nome;
  late String descricao;
  late String urlImagem;
  late String categoria;
  late String preco;
  late int quantidade;

  ProdutoModel({
    this.id = '',
    this.nome = '',
    this.descricao = '',
    this.urlImagem = '',
    this.categoria = '',
    this.preco = '',
    this.quantidade = 0,
  });

  ProdutoModel.fromJson(String userId, Map<String, dynamic> json) {
    id = userId;
    nome = json['nome'];
    descricao = json['descricao'];
    urlImagem = json['urlImagem'];
    categoria = json['categoria'];
    preco = json['preco'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['urlImagem'] = urlImagem;
    data['categoria'] = categoria;
    data['preco'] = preco;
    data['quantidade'] = quantidade;
    return data;
  }
}
