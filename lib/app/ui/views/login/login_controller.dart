import "package:cip_payment_app/app/providers/auth_provider.dart";
import "package:cip_payment_app/app/repositories/user_repository.dart";
import "package:cip_payment_app/app/ui/views/home/home_view.dart";
import "package:cip_payment_app/core/helpers/custom_snackbar.dart";
import "package:cip_payment_app/routes/app_routes_name.dart";
import "package:cip_payment_app/services/firebase_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class LoginController with ChangeNotifier {
  UserRepository userRepository = UserRepository();
  int counter = 0;
  TextEditingController ctrlUserName = TextEditingController(text: 'wilmer123');
  TextEditingController ctrlPassword = TextEditingController(text: 'wilmer123');
  TextEditingController ctrlDni = TextEditingController(text: '12345678');
  TextEditingController ctrlName =
      TextEditingController(text: 'JOSE GUEVARA MARTINEZ');
  TextEditingController ctrlEmail2 =
      TextEditingController(text: 'software@ciplambayeque.com');

  bool _isVisibleIcon = true;
  bool _rememberPass = false;
  bool _isAuthenticating = false;

  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }


  set isVisibleIcon(bool value) {
    _isVisibleIcon = value;
    notifyListeners();
  }

  set rememberPass(bool value) {
    _rememberPass = value;
    notifyListeners();
  }

  bool get rememberPass => _rememberPass;
  bool get isVisibleIcon => _isVisibleIcon;
  bool get isAuthenticating => _isAuthenticating;

  Future<void> authentication(BuildContext context) async {
    isAuthenticating = true;
    String? personId = await loginUser(ctrlUserName.text, ctrlPassword.text);
    isAuthenticating = false;
    if (personId == null) {
      CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Validar',
          message: 'Usuario o contraseña incorrecta',
          type: 2,
          time: 2,
        );
        return;
    }
    final person = await getPersonById(personId);

    if (person != null) {
      Provider.of<AuthProvider>(context, listen: false).setPerson(person);
      Provider.of<AuthProvider>(context, listen: false).setBirthDate(person.dateBirth);
      Provider.of<AuthProvider>(context, listen: false).setEntryDate(person.dataEntryPerson);
    }
    context.go(AppRoutesName.HOME);
  }

}
