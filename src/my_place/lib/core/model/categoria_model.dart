class CategoriaModel {
  late String id;
  late String nome;
  late String descricao;
  late String urlImagem;

  CategoriaModel({
    this.id = '',
    this.nome = '',
    this.descricao = '',
    this.urlImagem = '',
  });

  CategoriaModel.fromJson(String userId, Map<String, dynamic> json) {
    id = userId;
    nome = json['nome'];
    descricao = json['descricao'];
    urlImagem = json['urlImagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['urlImagem'] = urlImagem;
    return data;
  }
}
