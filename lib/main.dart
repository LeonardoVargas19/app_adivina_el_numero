import 'package:app_adivina_el_numero/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {'home': (_) => Home()},
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Color.fromARGB(222, 163, 45, 184),
        
      )),
      
    );
  }
}
