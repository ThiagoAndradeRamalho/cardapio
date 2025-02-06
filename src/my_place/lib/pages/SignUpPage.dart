import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_place/controller/signUpController.dart';
import 'package:my_place/core/exceptions/e_email.dart';
import 'package:my_place/core/exceptions/e_email_use.dart';
import 'package:my_place/core/exceptions/e_weak_password.dart';
import 'package:my_place/widgets/mp_logo.dart';
import 'package:my_place/pages/sigInPage.dart';
import 'package:my_place/widgets/mp_loading.dart';
import 'package:my_place/widgets/toasts/toasts_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _controller = SignUpcontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: _controller.isLoading
            ? Center(
                child: MpLoading(),
              )
            : Padding(
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
                          labelText: 'Nome',
                          prefixIcon: Icon(
                            Icons.person,
                            size: 24,
                          )),
                      validator: (nome) =>
                          nome == null ? 'Campo obrigatorio' : null,
                      onSaved: _controller.setNome,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            size: 24,
                          )),
                      validator: (email) =>
                          email == null ? 'Campo obrigatorio' : null,
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
                      onChanged: _controller.setSenha,
                      validator: (senha) =>
                          senha == null ? 'Campo obrigatorio' : null,
                      onSaved: _controller.setSenha,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Repita a Senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 24,
                          )),
                      obscureText: true,
                      validator: _controller.validaSenhaRepetida,
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
                              setState(() {
                                _controller.setIsLoading(true);
                              });
                              try {
                                await _controller.cadastrarUsuario();
                                showSucessToast('Usuario criado com sucesso');
                                Navigator.of(context).pop();
                              } on EmailUseException {
                                showWarningToast('Email ja esta em uso!');
                                print('Email ja esta em uso!');
                              } on WeakPasswordException {
                                showWarningToast(
                                    'Senha deve ter no mínimo 6 caracteres');
                                print('Senha deve ter no mínimo 6 caracteres');
                              } on InvalidEmailException {
                                showWarningToast('Email invalido!');
                                print('Email invalido!');
                              } on Exception {
                                showErrorToast('Ocorreu um erro inesperado');
                                print('Ocorreu um erro inesperado');
                              }
                              setState(() {
                                _controller.setIsLoading(false);
                              });
                            }
                          },
                          child: Text('Cadastrar'),
                        )),
                    SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Voltar'),
                        )),
                  ],
                ),
              ),
      ),
    )));
  }
}
