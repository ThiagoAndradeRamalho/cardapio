import 'package:flutter/material.dart';
import 'package:my_place/core/model/usuario_model.dart';
import 'package:logger/logger.dart';
import 'package:my_place/widgets/mp_appBar.dart';
import 'package:my_place/widgets/mp_logo.dart';

final Logger logger = Logger();

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final UsuarioModel user;

  @override
  Widget build(BuildContext context) {
    //logger.i(user.email);
    return Scaffold(
      appBar: MPAppBar(
        tittle: Mplogo(
          fontSize: 28,
        ),
        withLeading: false,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
           _Button(text: 'Categorias', page: Scaffold(), iconData: Icons.category),
           _Button(text: 'Produtos', page: Scaffold(), iconData: Icons.fastfood),
           _Button(text: 'Promoções', page: Scaffold(), iconData: Icons.campaign),
           _Button(text: 'Pedidos Pendentes', page: Scaffold(), iconData: Icons.pending),
           _Button(text: 'Pedidos Finalizados', page: Scaffold(), iconData: Icons.flag),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.text,
    required this.page,
    required this.iconData,

  });

  final String text;
  final Widget page;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        child: Container(
          width: 100,
          height: 90,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(
                iconData, 
                size: 32, 
                color: Colors.deepOrangeAccent,
              ),
              SizedBox(height: 6,),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}
