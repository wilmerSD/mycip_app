import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestoredb = FirebaseFirestore.instance;
Future<bool> loginUser(String email, String password) async {
  try {
    final querySnapshot = await firestoredb
        .collection('User')
        .where('userName', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print("Login exitoso: ${querySnapshot.docs.first.data()}");
      return true;
    } else {
      print("Correo o contraseña incorrectos");
      return false;
    }
  } catch (e) {
    print("Error al iniciar sesión: $e");
    return false;
  }
}
