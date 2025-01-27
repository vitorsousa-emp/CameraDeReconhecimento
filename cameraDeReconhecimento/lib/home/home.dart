import 'package:cameradereconhecimenro/provider/providerUp.dart';
import 'package:cameradereconhecimenro/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerFoto = context.watch<FotosProvider>();

    return ScarfoldPadrao(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (providerFoto.img != null)
            Image.file(providerFoto.img!, height: 200, fit: BoxFit.cover),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
               providerFoto.tirarFotoFunc();
            },
            child: Text("Tirar Foto e Reconhecer Texto"),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              providerFoto.textoEstraido,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
