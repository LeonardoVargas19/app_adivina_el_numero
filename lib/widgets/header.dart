import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final TextEditingController numberController;
  final List<String> historial;
  final int intentos;
  final Function(String) registroIngresado;

  const Header({
    super.key,
    required this.numberController,
    required this.historial,
    required this.intentos,
    required this.registroIngresado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.only(top: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  placeholder: 'Número',
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                'Intentos \n $intentos',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          CupertinoButton(
            color: CupertinoColors.activeBlue,
            onPressed: () {
              if (numberController.text.isNotEmpty && intentos > 0) {
                registroIngresado(numberController.text);
                numberController
                    .clear(); // Limpia el campo después de agregar el número
              } else {
                print('No hay número ingresado o no quedan intentos');
              }
            },
            child: Text('Ingresar'),
          ),
        ],
      ),
    );
  }
}
