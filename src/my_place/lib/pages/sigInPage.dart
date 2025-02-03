import 'package:flutter/material.dart';
import 'package:my_place/widgets/mpLogo.dart';
import 'package:my_place/pages/SignUpPage.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({super.key});

  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _senha;
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
              Mplogo(isAdmin: true,),
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
                obscureText: true,
                validator: (email) =>
                    email == null ? 'Campo obrigatorio' : null,
                onSaved: (email) => _email = email,
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
                onSaved: (senha) => _senha = senha,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form?.validate() ?? false) {
                        form?.save();
                      }
                    },
                    child: Text('Entrar'),
                  )),
              SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SignUpPage(),
                        )
                      );
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
