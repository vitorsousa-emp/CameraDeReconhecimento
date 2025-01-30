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

    return ScarfoldPadrao(
      child: providerFoto.galeria.isEmpty // verificação pra ver se a galaria estar vazia ou não 
          ? Center(child: Text("Nenhuma imagem salva."))
          : ListView.builder(

              itemCount: providerFoto.galeria.length, // tamanho da listview
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
                  child: Card( //criação do card
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),// areendonda bordas da image 
                              child: Image.file(
                                File(providerFoto.galeria[index]['imagem']!),//pega index da foto atual e sua chave no map 
                                fit: BoxFit.contain,//deixa a foto do tamanho do container
                              ),
                            ),
                          ),
                        ],
                      ),
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

  const DetalheImagem({super.key, required this.imagemPath, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto para destacar a imagem
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer( // Permite dar zoom e mover a imagem
              child: Image.file(
                File(imagemPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black54, // Fundo escuro para melhor leitura
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                texto,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

