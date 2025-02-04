import 'package:cameradereconhecimenro/galeria/galeria.dart';
import 'package:cameradereconhecimenro/home/home.dart';
import 'package:cameradereconhecimenro/provider/providerUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(const MyApp());
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override 
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FotosProvider(),
      child: MaterialApp( //rotas para fazer a navegação entre as paginas 
        routes: {
          "/": (context) => HomePage(),
          "/galeria": (context) => GaleriaPage(),
        },
      ),
    );
  }
}
