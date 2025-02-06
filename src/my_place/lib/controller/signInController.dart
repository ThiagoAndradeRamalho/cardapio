import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_place/core/exceptions/e_admin_invalid.dart';
import 'package:my_place/core/exceptions/e_email.dart';
import 'package:my_place/core/exceptions/e_password_invalid.dart';
import 'package:my_place/core/exceptions/e_user_not_found.dart';
import 'package:my_place/core/model/usuario_model.dart';

class SignInController {
  String email = '';
  String senha = '';
  bool isLoading = false;

  final _firebaseAuth = FirebaseAuth.instance;
  final _usuariosRef = FirebaseFirestore.instance.collection('usuarios');

  void setEmail(String? value) {
    email = value!;
  }

  void setSenha(String? value) {
    senha = value!;
  }

  void setIsLoading(bool? value) {
    isLoading = value!;
  }

  Future<UsuarioModel?> fazLogin() async {
    try {
      final userFireAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      final userFirestore =
          await _usuariosRef.doc(userFireAuth.user!.uid).get();
      final user =
          UsuarioModel.fromJson(userFirestore.id, userFirestore.data()!);

      if (user.tipo != "ADMIN") {
        throw AdminInvalidException();
      }

      return user;
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw UserNotFound();
        } else if (e.code == 'wrong-password') {
          throw PasswrodInvalidException();
        } else if (e.code == 'invalid-email') {
          throw InvalidEmailException();
        } else {
          rethrow;
        }
      }
      
    }
    return null;
  }
}
