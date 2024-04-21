import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivina el numero'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          _header(),
          tablero(),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Slider.adaptive(
                  value: 0,
                  max: 3,
                  min: 0,
                  label: 'test',
                  onChanged: (value) {},
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class tablero extends StatelessWidget {
  const tablero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue,
            height: 150,
            child: Center(
              child: Text(
                'Ingrese un numero menor',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.yellow,
            height: 150,
            child: Center(
                child: Text(
              'Ingresa un numero menor',
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.purple,
          height: 150,
          child: Center(
            child: Text('Historial'),
          ),
        ))
      ],
    );
  }
}

class _header extends StatelessWidget {
  const _header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.red,
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
                  placeholder: 'Número',
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                'Intentos \n 5',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('Ingresar'),
              onPressed: () {}),
        ],
      ),
    );
  }
}
