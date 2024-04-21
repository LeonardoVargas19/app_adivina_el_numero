import 'package:flutter/material.dart';

class tablero extends StatelessWidget {
  const tablero({
    super.key,
    required this.hintHigher,
    required this.hintLower,
    required this.historial,
  });

  final String? hintHigher;
  final String? hintLower;
  final List<String> historial;
  final double border = 3.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: border)),
            child: Center(
              child: Text(
                hintHigher ?? "Ingrese un número menor",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: border)),
            child: Center(
              child: Text(
                hintLower ?? "Ingrese un número mayor",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: border)),
                child: ListView.builder(
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        historial[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
