import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:cip_payment_app/app/domain/datasources/auth_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/user.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/user_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/user_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthdbDatasource extends AuthDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();

        // 1. Pasar a Response (modelo)
        final userResponse = UserResponse.fromJson(userData);

        // 2. Mapear a Entidad
        final user = UserMapper.userResponseToEntity(userResponse);

        return user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión: $e");
      return null;
    }
  }

    // ============================================================
  // REQUEST PASSWORD RESET (paso 1)
  // ============================================================
  @override
  Future<bool> requestPasswordReset(String email) async {
    try {
      final query = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return false;

      final docId = query.docs.first.id;
      final code = _generateResetCode();

      // Guardamos el código y la expiración (por ejemplo, 15 minutos)
      await firestoredb.collection('User').doc(docId).update({
        'resetCode': code,
        'resetExpiresAt': DateTime.now().add(const Duration(minutes: 15)).toIso8601String(),
      });

      // Aquí podrías integrar el envío de correo con ese código
      debugPrint("📧 Código de recuperación generado: $code");

      return true;
    } catch (e) {
      debugPrint("❌ Error en requestPasswordReset: $e");
      return false;
    }
  }

  // ============================================================
  // VERIFY RESET CODE (paso 2)
  // ============================================================
  @override
  Future<bool> verifyResetCode(String email, String code) async {
    try {
      final query = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .where('resetCode', isEqualTo: code)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return false;

      final userData = query.docs.first.data();
      final expiresAt = DateTime.parse(userData['resetExpiresAt']);

      if (DateTime.now().isAfter(expiresAt)) {
        debugPrint("⚠️ Código expirado");
        return false;
      }

      return true;
    } catch (e) {
      debugPrint("❌ Error en verifyResetCode: $e");
      return false;
    }
  }

  // ============================================================
  // RESET PASSWORD (paso 3)
  // ============================================================
  @override
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final query = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return false;

      final docId = query.docs.first.id;
      final hashedPassword = _hashPassword(newPassword);

      await firestoredb.collection('User').doc(docId).update({
        'password': hashedPassword,
        'resetCode': FieldValue.delete(),
        'resetExpiresAt': FieldValue.delete(),
      });

      debugPrint("🔐 Contraseña actualizada y encriptada correctamente");
      return true;
    } catch (e) {
      debugPrint("❌ Error en resetPassword: $e");
      return false;
    }
  }
    // ============================================================
  // LOGIN USER
  // ============================================================
  /* @override
  Future<User?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      final userData = querySnapshot.docs.first.data();
      final storedPassword = userData['password'] as String;

      // 🔐 Verificar si la contraseña está encriptada (hash SHA256)
      final hashedInput = _hashPassword(password);

      final isMatch = storedPassword == password || storedPassword == hashedInput;
      if (!isMatch) return null;

      final userResponse = UserResponse.fromJson(userData);
      final user = UserMapper.userResponseToEntity(userResponse);

      return user;
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión: $e");
      return null;
    }
  } */
  // ============================================================
  // HELPERS
  // ============================================================
  
  String _generateResetCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString(); // Código de 6 dígitos
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

}
