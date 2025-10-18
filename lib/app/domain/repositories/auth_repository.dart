import 'package:cip_payment_app/app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> loginUser({required String email, required String password});

  /// Paso 1: Solicita recuperación. Envía código al correo del usuario.
  Future<bool> requestPasswordReset(String email);

  /// Paso 2: Verifica el código recibido por correo.
  Future<bool> verifyResetCode(String email, String code);

  /// Paso 3: Cambia la contraseña del usuario.
  Future<bool> resetPassword(String email, String newPassword);
}
