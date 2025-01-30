import 'dart:io';

import 'package:flutter/material.dart';

AppBar barraDeNavegacao = AppBar(
  title: Text("Bem Vindo ao TextImage"),
  centerTitle: true,
  backgroundColor: Colors.green,
);


class ScarfoldPadrao extends StatelessWidget {
  final Widget child;
   const ScarfoldPadrao({super.key, 
  required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      appBar: barraDeNavegacao,
      drawer: DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? rotaAtual = ModalRoute.of(context)?.settings.name;
    return Drawer(
      backgroundColor: Colors.black,
      shape: OutlineInputBorder(), //Border.all(style: BorderStyle.none),
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(child: Text("MENU",style: TextStyle(color: Colors.white),),),
          ),
          ListTile(
            title: Text("Home",style: TextStyle(color: Colors.white),),
            tileColor: rotaAtual=="/"?Colors.green:null,
            leading: Icon(Icons.home),
            iconColor: Colors.white,
            onTap: () => Navigator.pushNamed(context,"/"),
          ),
          ListTile(
            title: Text("Galeria",style: TextStyle(color: Colors.white),),
            tileColor: rotaAtual == "/galeria"?Colors.green:null,
            leading: Icon(Icons.image),
            iconColor: Colors.white,
            onTap: ()=> Navigator.pushNamed(context,"/galeria"),
            
          )
        ],
      ),
    );
  }
}

class DetalheImagem extends StatelessWidget {
  final String imagemPath;
  final String texto;

  DetalheImagem({required this.imagemPath, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Imagem")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagemPath), height: 1500, fit: BoxFit.cover),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}