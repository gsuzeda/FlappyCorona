import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constantes.dart';
import 'main.dart';

class Instrucoes extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Instrucoes> {


  bool  _instructionOpacity = false;

  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _instructionOpacity = !_instructionOpacity;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.centerLeft,
      color: new Color(0xff00081e),
      child: AnimatedOpacity(
      curve: Curves.linear,
      opacity: _instructionOpacity ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black,
        color: Colors.white.withOpacity(0.95),
        margin: EdgeInsets.only(
          right: MediaQuery
              .of(context)
              .size
              .width / 16,
          left: MediaQuery
              .of(context)
              .size
              .width / 16,
          top: MediaQuery
              .of(context)
              .size
              .height / 8,
          bottom: MediaQuery
              .of(context)
              .size
              .height / 8,
        ),
        child: ListView(children: <Widget>[
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: '\n\n\n\nSeu objeito é ',
                  style: padraodeTexto.headline1,
                ),
                TextSpan(
                  text: 'eliminar',
                  style: padraodeTexto.headline1
                      .copyWith(color: Colors.red),
                ),
                TextSpan(
                  text: ' todos os ',
                  style: padraodeTexto.headline1,
                ),
                TextSpan(
                  text: 'coronas',
                  style: padraodeTexto.headline1
                      .copyWith(color: Colors.green),
                ),
                TextSpan(
                  text: ' que consegue ver, e pasmem, você é um ',
                  style: padraodeTexto.headline1,
                ),
                TextSpan(
                  text: 'sabão!\n\n\n\n',
                  style: padraodeTexto.headline1
                      .copyWith(color: Colors.pinkAccent),
                ),
                TextSpan(
                  text: 'Para controlar seu aliado contra o vírus, basta clicar na tela para mudar a direção da queda. Você diminui o número de casos sempre que consegue acertar um corona.\n\n\nBoa SORTE!\n\n',
                  style: padraodeTexto.headline1,
                ),

              ])),
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                "Voltar",
                textAlign: TextAlign.center,
                style: padraodeTexto.headline1.copyWith(color:Colors.red),
              )),
        ]),
      ),
    ),);
  }
}
