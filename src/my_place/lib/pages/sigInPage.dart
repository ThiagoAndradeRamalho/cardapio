import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_place/controller/signInController.dart';
import 'package:my_place/core/exceptions/e_email.dart';
import 'package:my_place/core/exceptions/e_password_invalid.dart';
import 'package:my_place/core/exceptions/e_user_not_found.dart';
import 'package:my_place/pages/homePage.dart';
import 'package:my_place/widgets/mp_logo.dart';
import 'package:my_place/pages/SignUpPage.dart';
import 'package:my_place/widgets/toasts/toasts_utils.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({super.key});

  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Mplogo(),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    size: 24,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                onSaved: _controller.setEmail,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 24,
                    )),
                obscureText: true,
                validator: (senha) =>
                    senha == null ? 'Campo obrigatorio' : null,
                onSaved: _controller.setSenha,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () async {
                      final form = _formKey.currentState;
                      if (form?.validate() ?? false) {
                        form?.save();
                        try {
                          print(
                              "Senhal ${_controller.senha}  login ${_controller.email}");
                          final user = await _controller.fazLogin();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => HomePage(user: user!)));
                        } on FirebaseAuthException {
                          showWarningToast('Usuario não é administrator');
                        } on UserNotFound {
                          showWarningToast('Usuario nao encontrado');
                        } on PasswrodInvalidException {
                          showWarningToast('Senha invalida');
                        } on InvalidEmailException {
                          showWarningToast('Email invalido');
                        } on Exception {
                          showErrorToast('Ocorreu um erro inesperado');
                        }
                      }
                    },
                    child: Text('Entrar'),
                  )),
              SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SignUpPage(),
                      ));
                    },
                    child: Text('Cadastrar'),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
