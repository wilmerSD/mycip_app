import 'package:cip_payment_app/app/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestoredb = FirebaseFirestore.instance;

// Future<bool> loginUser(String email, String password) async {
//   try {
//     final querySnapshot = await firestoredb
//         .collection('User')
//         .where('userName', isEqualTo: email)
//         .where('password', isEqualTo: password)
//         .limit(1)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       print("Login exitoso: ${querySnapshot.docs.first.data()}");
//       return true;
//     } else {
//       print("Correo o contraseña incorrectos");
//       return false;
//     }
//   } catch (e) {
//     print("Error al iniciar sesión: $e");
//     return false;
//   }
// }

Future<String?> loginUser(String email, String password) async {
  try {
    final querySnapshot = await firestoredb
        .collection('User')
        .where('userName', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();

      // Devuelves el ID del documento referenciado en personId
      final DocumentReference personRef = userData['personId'];
      return personRef.id;  // 🔹 Devuelve solo el ID
    } else {
      print("Correo o contraseña incorrectos");
      return null;
    }
  } catch (e) {
    print("Error al iniciar sesión: $e");
    return null;
  }
}

Future<PersonModel?> getPersonById(String personId) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('Person')
        .doc(personId)
        .get();

    if (doc.exists) {
      return PersonModel.fromFirestore(doc.id, doc.data()!);
    } else {
      return null;
    }
  } catch (e) {
    print('❌ Error al obtener persona: $e');
    return null;
  }
}

Future<void> createPerson(PersonModel person) async {
  try {
    await FirebaseFirestore.instance.collection('Person').add(person.toFirestore());
    print('✅ Persona creada exitosamente');
  } catch (e) {
    print('❌ Error al crear persona: $e');
  }
}
