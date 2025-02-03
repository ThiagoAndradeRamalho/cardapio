import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_place/controller/signUpController.dart';
import 'package:my_place/widgets/mpLogo.dart';
import 'package:my_place/pages/sigInPage.dart';

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
                    labelText: 'Nome',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 24,
                    )),
                validator: (nome) => nome == null ? 'Campo obrigatorio' : null,
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
                        await _controller.cadastrarUsuario();
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
