class UsuarioModel {
  late String id;
  late String nome;
  late String email;
  late String tipo;

  UsuarioModel({
    required this.id, 
    required this.nome, 
    required this.email, 
    required this.tipo,
    });

  UsuarioModel.fromJson(String userId, Map<String, dynamic> json) {
    id = userId;
    nome = json['nome'];
    email = json['email'];
    tipo = json['tipo'];
  }
}
