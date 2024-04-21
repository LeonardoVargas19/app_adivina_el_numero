import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> historial = [];
  final TextEditingController numberController = TextEditingController();
  int intentos = 5;
  int? randomNumber;
  String? hintLower;
  String? hintHigher;
  double difficultyLevel = 0;

  @override
  void initState() {
    super.initState();
    randomNumber = Random().nextInt(100) + 1;
  }

  void showIosDialog(String title, String content, VoidCallback callback) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(ctx).pop(); // Cierra el diálogo
              callback();
            },
            child: Text('Jugar de nuevo'),
          ),
        ],
      ),
    );
  }

  void checkNumber(String value) {
    if (intentos > 0) {
      int numValue = int.parse(value);
      setState(() {
        historial.add(value);
        intentos--; // Resta un intento cada vez que se agrega un valor
        if (numValue > randomNumber!) {
          hintLower = "Menor que $value";
          hintHigher = null;
        } else {
          hintHigher = "Mayor que $value";
          hintLower = null;
        }
      });

      if (numValue == randomNumber) {
        showIosDialog(
          '¡Felicidades!',
          'Has adivinado el número correctamente.',
          restartGame,
        );
      } else if (intentos == 0) {
        showIosDialog(
          '¡Juego terminado!',
          'Te has quedado sin intentos. El número era $randomNumber.',
          restartGame,
        );
      }
    }
  }

  void restartGame() {
    setState(() {
      historial.clear();
      intentos = 5;
      randomNumber = Random().nextInt(100) + 1;
      hintLower = null;
      hintHigher = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivina el Número'),
        shadowColor: Colors.purple.shade100,
        backgroundColor: Colors.purple.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Header(
              numberController: numberController,
              historial: historial,
              intentos: intentos,
              registroIngresado: checkNumber,
            ),
            tablero(
                hintHigher: hintHigher,
                hintLower: hintLower,
                historial: historial),
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Slider.adaptive(
                      value: difficultyLevel,
                      min: 0,
                      max: 3,
                      divisions: 3,
                      label: [
                        'Fácil',
                        'Medio',
                        'Avanzado',
                        'Extremo'
                      ][difficultyLevel.toInt()],
                      onChanged: (newRating) {
                        setState(() {
                          difficultyLevel = newRating;
                          switch (difficultyLevel.toInt()) {
                            case 0: // Fácil
                              randomNumber = Random().nextInt(10) + 1;
                              intentos = 5;
                              break;
                            case 1: // Medio
                              randomNumber = Random().nextInt(20) + 1;
                              intentos = 8;
                              break;
                            case 2: // Avanzado
                              randomNumber = Random().nextInt(100) + 1;
                              intentos = 15;
                              break;
                            case 3: // Extremo
                              randomNumber = Random().nextInt(1000) + 1;
                              intentos = 25;
                              break;
                            default:
                              randomNumber = Random().nextInt(100) + 1;
                              intentos = 5;
                          }
                          historial
                              .clear(); // Limpiar historial al cambiar de dificultad
                          hintLower = null;
                          hintHigher = null;
                        });
                      },
                    ),

                  ),
                  Text(
                    [
                      'Fácil',
                      'Medio',
                      'Avanzado',
                      'Extremo'
                    ][difficultyLevel.toInt()],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
