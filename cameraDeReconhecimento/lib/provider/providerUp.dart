import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class FotosProvider extends ChangeNotifier {
  final TextRecognizer textDetector = TextRecognizer(); // Inicializa o detector de texto
  File? img; //armazena img caputrada 
  String textoEstraido = ""; //texto estraido da img 
  final ImagePicker picker = ImagePicker();//permite acessar a camera do dispositivo ou a galeria servindo para capturar e prcessar imagens 

  // Lista para armazenar as imagens e os textos extraídos
  List<Map<String, String>> galeria = [];

  /// Função para solicitar permissão da câmera
  Future<void> solicitarPermissaoCamera() async {
    
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings(); // Abre as configurações para ativar manualmente
    }

    if (status.isGranted) {
      await tirarFotoFunc();
    }
  }

  /// Função para capturar imagem da câmera
  Future<void> tirarFotoFunc() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isGranted) {
      try {
        final XFile? imagemCapturada = await picker.pickImage(source: ImageSource.camera);

        if (imagemCapturada != null) {
          img = File(imagemCapturada.path);

          // Usar o ML Kit para reconhecer o texto da imagem
          final inputImage = InputImage.fromFilePath(imagemCapturada.path);
          final recognizedText = await textDetector.processImage(inputImage); // Chama o método corretamente

          textoEstraido = recognizedText.text;  // Armazena o texto reconhecido

          // Adiciona a imagem e o texto à galeria
          galeria.add({
            'imagem': imagemCapturada.path,
            'texto': textoEstraido,
          });

          notifyListeners();  // Notifica os ouvintes para atualizar a UI
        }
      } catch (e) {
        debugPrint("Erro ao capturar a foto: $e");
      }
    } else {
      await solicitarPermissaoCamera(); // Pede permissão e tenta de novo
    }
  }

  // Lembre-se de liberar o TextRecognizer quando não for mais necessário
  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }
}
