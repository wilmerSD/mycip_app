import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';

class MyprofileController with ChangeNotifier {
  static final MyprofileController _instance = MyprofileController._internal();
  factory MyprofileController() => _instance;
  MyprofileController._internal();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  
  //VARIABLES
  // final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  File? get profileImage => _profileImage;

  //INSTANCIAS

  //FUNCIONES
  // Método para seleccionar imagen desde la galería
  Future<void> pickImageFromGallery() async {
    // final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   _profileImage = File(pickedFile.path);
    //   notifyListeners();  // Notifica a los widgets que usan este controlador
    // }
  }
}
