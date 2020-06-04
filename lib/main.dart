import 'dart:async';
import 'package:coronaflappy/instrucoes.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'buttons.widget.dart';
import 'constantes.dart';
import 'game.widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageStage createState() => _HomePageStage();
}

class _HomePageStage extends State<HomePage> {
  double animatedsizeCorona = 0;
  bool _currentOpacity = false;

  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      changeOpacity();
      animatedCorona();
      Flame.audio.clearAll();
      Flame.audio.loopLongAudio('coronamusicmain.mp3');
    });

    super.initState();
  }

  void animatedCorona() {
    Timer.periodic(Duration(milliseconds: 2), (timer) {
      if (!mounted) return;
      setState(() {
        if (animatedsizeCorona <= maxY / 3) animatedsizeCorona++;
        if (animatedsizeCorona >= maxY / 3) timer.cancel();
      });
    });
  }

  void changeOpacity() {
    if (!mounted) return;
    setState(() {
      _currentOpacity = !_currentOpacity;
    });
  }

  void _goodbye() {
    if (!mounted) return;
    setState(() {
      changeOpacity();
      Future.delayed(const Duration(milliseconds: 1000), () {
        exit(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    maxY = MediaQuery.of(context).size.height;
    maxX = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: new Color(0xff00081e),
      body: Stack(alignment: Alignment.centerLeft, children: <Widget>[

        AnimatedOpacity(
          curve: Curves.linear,
          opacity: _currentOpacity ? 1.0 : 0.0,
          duration: const Duration(seconds: 3),
          child: ListView(children: <Widget>[
            SizedBox(height: maxY / 80),
            Text('Flappy\n Corona',
                textAlign: TextAlign.center,
                style: padraodeTexto.headline1
                    .copyWith(fontSize: maxY / 10, color: Colors.white)),
            SizedBox(
              height: maxY / 80,
            ),
            Image.asset(
              "assets/virus.gif",
              alignment: AlignmentDirectional.bottomCenter,
              height: animatedsizeCorona,
            ),
            SizedBox(
              height: maxY / 20,
            ),
            Buttons(
              label: "Play Game",
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
            ),
            Buttons(
              label: "Instruções",
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Instrucoes()),
                );
              },
            ),
            Buttons(
              label: "Sair",
              func: () => _goodbye(),
            ),

          ]),
        ),
      ]),
    );
  }
}
