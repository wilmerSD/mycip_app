import 'package:cip_payment_app/app/domain/datasources/auth_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/user.dart';
import 'package:cip_payment_app/app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);
  
  @override
  Future<User?> loginUser({required String email,required String password}) {
    return datasource.loginUser(email, password);
  }
  
  @override
  Future<bool> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }
  
  @override
  Future<bool> resetPassword(String email, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
  
  @override
  Future<bool> verifyResetCode(String email, String code) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
  }

}