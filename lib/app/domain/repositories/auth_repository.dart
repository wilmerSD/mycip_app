import 'package:cip_payment_app/app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> loginUser({required String email, required String password});
}
