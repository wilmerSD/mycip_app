
import 'package:cip_payment_app/app/domain/entities/user.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/user_response.dart';

class UserMapper {
  static User userResponseToEntity(UserResponse userdb) => User(
      userName: userdb.userName ?? '',
      password: userdb.password ?? '',
      stateUser: userdb.stateUser ?? false,
      personId: userdb.personId,
     
    );
}
