import 'package:firebase_auth/firebase_auth.dart';

class SignUpcontroller {
  String? _nome = '';
  String? _email = '';
  String? _senha = '';
  bool _isLoading = false;

  final _firebaseAuth = FirebaseAuth.instance;

    String? validaSenhaRepetida(String? senha) {
    print('entrou ${senha}');
    if (senha == null || senha.isEmpty) {
      return 'Campo Obrigatorio';
    } else if (senha != _senha) {
      print(senha);
      print(_senha);
      return 'Senhas diferentes';
    }
    return null;
  }

  Future<void> cadastrarUsuario() async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: _email!,
      password: _senha!,
    );
  }

  void setNome(String? nome) => _nome = nome;
  void setEmail(String? email) => _email = email;
  void setSenha(String? senha) => _senha = senha;
  void setIsLoading(bool isLoading) => _isLoading = isLoading;
}
