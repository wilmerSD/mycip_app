import "package:cip_payment_app/app/repositories/user_repository.dart";
import "package:cip_payment_app/app/ui/views/home/home_view.dart";
import "package:cip_payment_app/core/helpers/custom_snackbar.dart";
import "package:cip_payment_app/core/theme/app_colors.dart";
import "package:cip_payment_app/services/firebase_service.dart";
import "package:flutter/material.dart";

class LoginController with ChangeNotifier {
  UserRepository userRepository = UserRepository();
  int counter = 0;
  TextEditingController ctrlEmail = TextEditingController(text: 'wilmer123');
  TextEditingController ctrlPassword = TextEditingController(text: 'wilmer123');
  TextEditingController ctrlDni = TextEditingController(text: '12345678');
  TextEditingController ctrlName =
      TextEditingController(text: 'JOSE GUEVARA MARTINEZ');
  TextEditingController ctrlEmail2 =
      TextEditingController(text: 'software@ciplambayeque.com');

  bool _isVisibleIcon = false;
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
    // bool resultado = await loginUser(ctrlEmail.text, ctrlPassword.text);
    bool resultado = await loginUser('wilmer123', 'wilmer123');
    isAuthenticating = false;
    if (!resultado) {
      CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Validar',
          message: 'Usuario o contraseña incorrecta',
          color: AppColors.warningColor,
        );
        return;
    }
    goToHome(context);
  }

  void goToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeView()));
  }
}
