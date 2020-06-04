import 'dart:math';
import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coronaflappy/main.dart';
import 'package:flutter/services.dart';
import 'constantes.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var _onPressed = () {};
  bool inverter = false,
      _currentTxTOpacity = false,
      gamestop = false,
      _finalTextOpacity = false,
      _opacitySnow = false;
  String vitoria = "Robou";
  int _vidaCorona = 4008824 , flag = 0, _populacaoMundial = 8000000000;

  double playerY = 50,
      enemieX1 = 0,
      enemieX2 = 0,
      enemieX3 = 0,
      enemieY2 = 30000,
      enemieY1 = 30000,
      enemieY3 = 30000,
      bonusX = 0,
      bonusY = 100000,
      onusX = 0,
      onusY = 10000,
      gamespeed = 1,
      _pontuacaoOpacity = 0.9;
  var rng = new Random();

  bool checkcolision(double enemiepositionX, enemiepositionY) {
    if (this.mounted) {
      double coronaMargin = playerY + maxY * 0.175;
      double enemie1margin = enemiepositionY + maxY * 0.140;
      double localizacaoY = maxX / 20 + maxX / 10;
      double compensacaoBolha = maxY * 0.04;
      enemie1margin -= compensacaoBolha;
      if (enemiepositionX <= localizacaoY &&
          enemiepositionY <= coronaMargin &&
          enemie1margin >= playerY) {
        resetPositionx(enemiepositionX);
        return true;
      }
    }
    return false;
  }

  void resetPositionx(double enemiepositionX) {
    if (enemieX1 == enemiepositionX)
      enemieX1 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
    if (enemieX2 == enemiepositionX)
      enemieX2 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
    if (enemieX3 == enemiepositionX)
      enemieX3 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
    if (bonusX == enemiepositionX) {
      bonusX = (maxX * rng.nextInt(10)) + (maxX * rng.nextInt(10));
      acelerarogame();
    }
    if (onusX == enemiepositionX) {
      onusX = (maxX * rng.nextInt(10)) + (maxX * rng.nextInt(10));
      desacelerarogame();
    }
  }

  void onusMove() {
    if (!mounted) return;
    setState(() {
      if (onusX > 0) onusX -= maxX * gamespeed / 70;
      if (onusX < 0) onusX = 0;
      if (onusX == 0) {
        onusY = (rng.nextInt(maxY.toInt() - (maxY * 0.2).toInt()).toDouble());
        onusX = (maxX * 5);
      }
    });
  }

  void bonusMove() {
    if (!mounted) return;
    setState(() {
      if (bonusX > 0) bonusX -= maxX * gamespeed / 70;
      if (bonusX < 0) bonusX = 0;
      if (bonusX == 0) {
        bonusY = (rng.nextInt(maxY.toInt() - (maxY * 0.2).toInt()).toDouble());
        bonusX = (maxX * 5);
      }
    });
  }

  void enemieMove() {
    if (this.mounted) {
      setState(() {
        if (enemieX1 > 0) enemieX1 -= maxX / 100 * gamespeed;
        if (enemieX1 < 0) enemieX1 = 0;
        if (enemieX1 == 0) {
          enemieY1 =
              (rng.nextInt(maxY.toInt() - ((maxY * 0.2).toInt())).toDouble());
          enemieX1 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
        }

        if (enemieX2 > 0) enemieX2 -= maxX / 100 * gamespeed;
        if (enemieX2 < 0) enemieX2 = 0;
        if (enemieX2 == 0) {
          enemieY2 =
              (rng.nextInt(maxY.toInt() - ((maxY * 0.2).toInt())).toDouble());
          enemieX2 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
        }

        if (enemieX3 > 0) enemieX3 -= maxX / 100 * gamespeed;
        if (enemieX3 < 0) enemieX3 = 0;
        if (enemieX3 == 0) {
          enemieY3 =
              (rng.nextInt(maxY.toInt() - ((maxY * 0.2).toInt())).toDouble());
          enemieX3 = maxX - maxY * 0.1 + rng.nextInt((maxX.toInt()));
        }
      });
    }
  }

  void playerMove() {
    if (this.mounted) {
      setState(() {
        if (playerY > 1 && inverter == false) playerY -= maxY / 100;
        if (playerY < (maxY - maxY * 0.2) && inverter) playerY += maxY / 100;
      });
    }
  }

  void darVida() {
    if (!mounted) return;
    setState(() {
      _vidaCorona += 10;
      _populacaoMundial -= _vidaCorona ~/ 14;
      if (_populacaoMundial < 0) _populacaoMundial = 0;
    });
  }

  void animationText() {
    _currentTxTOpacity = !_currentTxTOpacity;

    Future.delayed(const Duration(milliseconds: 500), () {
      _currentTxTOpacity = !_currentTxTOpacity;
    });
  }

  void animationFinal() {
    _finalTextOpacity = !_finalTextOpacity;
  }

  void tirarVida() {
    if (!mounted) return;
    setState(() {
      _vidaCorona -= 10000;
      if (_vidaCorona < 0) _vidaCorona = 0;
      animationText();
      //animationText();
    });
  }

  void checarmorte() {
    if (!mounted) return;
    if (checkcolision(enemieX1, enemieY1)) tirarVida();
    if (checkcolision(enemieX2, enemieY2)) tirarVida();
    if (checkcolision(enemieX3, enemieY3)) tirarVida();
    if (_vidaCorona <= 0) {
      if (!mounted) return;
      setState(() {
        Flame.audio.clear;
        Flame.audio.clearAll();
        Flame.audio.play('sucess.mp3', volume: .75);
        _vidaCorona = 0;
        _onPressed = () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        };
        gamestop = true;
        _pontuacaoOpacity = 0;
        vitoria = "GANHOU!";
        animationFinal();
      });
    }
    if (_populacaoMundial <= 0) {
      if (!mounted) return;
      setState(() {
        _populacaoMundial = 0;
        _onPressed = () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        };
        gamestop = true;
        _pontuacaoOpacity = 0;
        vitoria = "PERDEU";
        animationFinal();
      });
    }
  }

  void desacelerarogame() {
    if (!mounted) return;
    setState(() {
      gamespeed -= 0.5;
      _opacitySnow = true;
      Future.delayed(const Duration(seconds: 5), () {
        gamespeed += 0.5;
        _opacitySnow = false;
      });
    });
  }

  void acelerarogame() {
    if (!mounted) return;
    setState(() {
      gamespeed += 1;
      Future.delayed(const Duration(seconds: 5), () {
        gamespeed -= 1.0;
      });
    });
  }

  @override
  void initState() {
    if (!mounted) return;
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      if (!mounted) return;

      checarmorte();

      if (gamestop) {
        timer.cancel();
      }

      playerMove();
      enemieMove();
      bonusMove();
      onusMove();
      checkcolision(onusX, onusY);
      checkcolision(bonusX, bonusY);
      darVida();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    maxY = MediaQuery.of(context).size.height;
    maxX = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: new Color(0xff00081e),
      body: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            //Corona
            height: maxY * 0.25,
            bottom: playerY,
            left: maxX / 20,
            child: Image.asset("assets/soap.gif"),
          ),
          Positioned(
            height: maxY * 0.15,
            bottom: enemieY1,
            left: enemieX1,
            child: Image.asset("assets/corona.gif"),
          ),
          Positioned(
            height: maxY * 0.15,
            bottom: enemieY2,
            left: enemieX2,
            child: Image.asset("assets/corona.gif"),
          ),
          Positioned(
            height: maxY * 0.15,
            bottom: enemieY3,
            left: enemieX3,
            child: Image.asset("assets/corona.gif"),
          ),
          Positioned(
            height: maxY * 0.2,
            bottom: bonusY,
            left: bonusX - maxY * 0.20,
            child: Image.asset("assets/faster.gif"),
          ),
          Positioned(
            height: maxY * 0.125,
            bottom: onusY,
            left: onusX - maxY * 0.20,
            child: Image.asset("assets/slower.gif"),
          ),
          Positioned(
            top: maxY * 0.01,
            right: maxY / 20,
            child: Text(
              "População Viva: $_populacaoMundial",
              style: padraodeTexto.headline1.copyWith(
                fontSize: maxY / 20,
                color: Colors.white.withOpacity(_pontuacaoOpacity),
              ),
            ),
          ),
          Positioned(
            top: maxY * 0.01,
            left: maxX * 0.02,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Numero de Casos: $_vidaCorona",
                    style: padraodeTexto.headline1.copyWith(
                      fontSize: maxY / 20,
                      color: Colors.white.withOpacity(_pontuacaoOpacity),
                    ),
                  ),
                  TextSpan(
                    text: "-10000",
                    style: TextStyle(
                      fontSize: maxY / 20,
                      fontFamily: "Angry Birds",
                      color: Colors.greenAccent.withOpacity(
                          _currentTxTOpacity ? _pontuacaoOpacity : 0.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: AnimatedOpacity(
                curve: Curves.linear,
                opacity: _opacitySnow ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  height: maxY,
                  width: maxX,
                  child: Image.asset(
                    "assets/ice.gif",
                    fit: BoxFit.fitWidth,
                    color: Colors.white.withOpacity(0.5),
                  ),
                )),
          ),
          Center(
            child: AnimatedOpacity(
              curve: Curves.linear,
              opacity: _finalTextOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: maxY / 2,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 5,
                  left: MediaQuery.of(context).size.width / 5,
                  top: MediaQuery.of(context).size.height / 9,
                  bottom: MediaQuery.of(context).size.height / 9,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      maxX / 50,
                    ),
                    color: Colors.white),
                child: ListView(children: <Widget>[
                  SizedBox(
                    height: maxY / 50,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Fim de Jogo\n\n Você ',
                          style: padraodeTexto.headline1
                              .copyWith(fontSize: maxY / 12),
                        ),
                        TextSpan(
                          text: '$vitoria',
                          style: padraodeTexto.headline1.copyWith(
                              color: Colors.green, fontSize: maxY / 10),
                        ),
                      ])),
                  SizedBox(
                    height: maxY / 30,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Sua pontuação:  ',
                          style: padraodeTexto.headline1
                              .copyWith(fontSize: maxY / 15),
                        ),
                        TextSpan(
                          text: '$_populacaoMundial',
                          style: padraodeTexto.headline1.copyWith(
                              color: Colors.blueAccent, fontSize: maxY / 14),
                        ),
                      ])),
                ]),
              ),
            ),
          ),
          Positioned(
            height: maxY,
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                inverter = !inverter;
              },
              child: Container(
                  width: maxX, height: maxY, decoration: BoxDecoration()),
            ),
          ),
          Positioned(
            left: maxX/2 - maxX /18,
            bottom: maxY /18,
            child: AnimatedOpacity(
              curve: Curves.linear,
            opacity: _finalTextOpacity ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: FlatButton(
              color: Colors.white,
              onPressed: _onPressed,
              child: Text(
                "Exit",
                style: padraodeTexto.headline1
                    .copyWith(fontSize: maxY /18 , color: Colors.red),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
