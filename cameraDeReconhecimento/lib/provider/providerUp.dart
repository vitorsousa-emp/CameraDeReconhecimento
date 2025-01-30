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
    
    PermissionStatus status = await Permission.camera.status; //mostrar stutus da camera Ex: dizer se foi aceita ou não
    

    if (status.isDenied) { 
      status = await Permission.camera.request(); //ele entrar nas permisões da camera e via manda um request(solicitação) para o usurario 
    }

    if (status.isPermanentlyDenied) {
      openAppSettings(); // Abre as configurações para ativar manualmente

    }

    if (status.isGranted) {
      await tirarFotoFunc(); //função tirar foto
    }
  }

  /// Função para capturar imagem da câmera
  Future<void> tirarFotoFunc() async {
    
    PermissionStatus status = await Permission.camera.status;// pegar status da cemrar 

    if (status.isGranted) {
      try {
        final XFile? imagemCapturada = await picker.pickImage(source: ImageSource.camera); //XFile = formato de img -> picker.pickImage(source image.Source.camera)-> abrir a camera

        if (imagemCapturada != null) {
          img = File(imagemCapturada.path);

          
         
          final inputImage = InputImage.fromFilePath(imagemCapturada.path);//converte o arquivo para um formato compriensivel pro PC extrair o texto

          final recognizedText = await textDetector.processImage(inputImage); //

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

  //pegaras fotos da galeria
  Future<void> takeGallery()async{
    final XFile? imagemCapturada = await picker.pickImage(source: ImageSource.gallery);

    if(imagemCapturada!=null){
      img = File(imagemCapturada.path);
      final inputImage = InputImage.fromFilePath(imagemCapturada.path);
      final recognizedText = await textDetector.processImage(inputImage);
      textoEstraido = recognizedText.text;
      galeria.add({"imagem":imagemCapturada.path, 'texto': textoEstraido});

    }else{
      Text("deu erro ao pegar imagem da galeria");
    }
    notifyListeners();
  }




  // Lembre-se de liberar o TextRecognizer quando não for mais necessário
  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }


}
