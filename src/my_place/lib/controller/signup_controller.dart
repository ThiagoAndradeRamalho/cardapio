import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_place/core/exceptions/e_email.dart';
import 'package:my_place/core/exceptions/e_email_use.dart';
import 'package:my_place/core/exceptions/e_weak_password.dart';

class SignUpcontroller {
  String? _nome = '';
  String? _email = '';
  String? _senha = '';
  bool _isLoading = false;

  final _firebaseAuth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('usuarios');

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
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email!,
        password: _senha!,
      );

      print("Id do usuario ${_userRef.doc(userCredential.user!.uid)}");

      await _userRef.doc(userCredential.user!.uid).set({
        'email': _email,
        'nome': _nome,
        'tipo': 'ADMIN',
      });
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          throw InvalidEmailException();
        } else if (e.code == 'weak-password') {
          throw WeakPasswordException();
        } else if (e.code == 'email-already-in-use') {
          throw EmailUseException();
        } else {
          rethrow;
        }
      }
    }
  }

  void setNome(String? nome) => _nome = nome;
  void setEmail(String? email) => _email = email;
  void setSenha(String? senha) => _senha = senha;
  void setIsLoading(bool isLoading) => _isLoading = isLoading;

  bool get isLoading => _isLoading;
}
