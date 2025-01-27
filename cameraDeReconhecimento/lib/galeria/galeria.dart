import 'dart:io';
import 'package:cameradereconhecimenro/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cameradereconhecimenro/provider/providerUp.dart';

class GaleriaPage extends StatelessWidget {
  const GaleriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerFoto = context.watch<FotosProvider>();

    return ScarfoldPadrao (
      
      child: providerFoto.galeria.isEmpty
          ? Center(child: Text("Nenhuma imagem salva."))
          : ListView.builder(
              itemCount: providerFoto.galeria.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalheImagem(
                          imagemPath: providerFoto.galeria[index]['imagem']!,
                          texto: providerFoto.galeria[index]['texto']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.file(
                          File(providerFoto.galeria[index]['imagem']!),
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            providerFoto.galeria[index]['texto']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
    return ScarfoldPadrao(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagemPath), height: 300, fit: BoxFit.cover),
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
