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
  int? randomNum;
  String? hintLower;
  String? hintHigher;
  double difficultyLevel = 0;

  @override
  void initState() {
    super.initState();
    randomNum = Random().nextInt(100) + 1;
  }

  void mostrarDialogo(String title, String content, VoidCallback callback) {
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

  void validarNumero(String value) {
    if (intentos > 0) {
      int numValue = int.parse(value);
      setState(() {
        historial.add(value);
        intentos--; // Resta un intento cada vez que se agrega un valor
        if (numValue > randomNum!) {
          hintLower = "Menor que $value";
          hintHigher = null;
        } else {
          hintHigher = "Mayor que $value";
          hintLower = null;
        }
      });

      if (numValue == randomNum) {
        mostrarDialogo(
          '¡Felicidades!',
          'Has adivinado el número correctamente.',
          reiniciar,
        );
      } else if (intentos == 0) {
        mostrarDialogo(
          '¡Juego terminado!',
          'Te has quedado sin intentos. El número era $randomNum.',
          reiniciar,
        );
      }
    }
  }

  void reiniciar() {
    setState(() {
      historial.clear();
      intentos = 5;
      randomNum = Random().nextInt(100) + 1;
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
              registroIngresado: validarNumero,
            ),
            tablero(
                hintHigher: hintHigher,
                hintLower: hintLower,
                historial: historial),
            Container(
              width: double.infinity,
              height: 100,
              child: dificultad(),
            )
          ],
        ),
      ),
    );
  }

  Row dificultad() {
    return Row(
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
              seleccionarDificultad(newRating);
            },
          ),
        ),
        Text(
          ['Fácil', 'Medio', 'Avanzado', 'Extremo'][difficultyLevel.toInt()],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void seleccionarDificultad(double newRating) {
    return setState(() {
      difficultyLevel = newRating;
      switch (difficultyLevel.toInt()) {
        case 0: // Fácil
          randomNum = Random().nextInt(10) + 1;
          intentos = 5;
          break;
        case 1: // Medio
          randomNum = Random().nextInt(20) + 1;
          intentos = 8;
          break;
        case 2: // Avanzado
          randomNum = Random().nextInt(100) + 1;
          intentos = 15;
          break;
        case 3: // Extremo
          randomNum = Random().nextInt(1000) + 1;
          intentos = 25;
          break;
        default:
          randomNum = Random().nextInt(100) + 1;
          intentos = 5;
      }
      historial.clear(); // Limpiar historial al cambiar de dificultad
      hintLower = null;
      hintHigher = null;
    });
  }
}
