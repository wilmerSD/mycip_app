import "package:cip_payment_app/app/repositories/user_repository.dart";
import "package:cip_payment_app/app/ui/views/home/home_view.dart";
import "package:cip_payment_app/core/helpers/custom_snackbar.dart";
import "package:cip_payment_app/core/helpers/helpers.dart";
import "package:cip_payment_app/core/theme/app_colors.dart";
import "package:flutter/widgets.dart";
import "package:flutter/material.dart";

class LoginController with ChangeNotifier {
  UserRepository userRepository = UserRepository();
  int counter = 0;
  TextEditingController ctrlEmail = TextEditingController(text: '');
  TextEditingController ctrlPassword = TextEditingController(text: '');
  TextEditingController ctrlDni = TextEditingController(text: '12345678');
  TextEditingController ctrlName =
      TextEditingController(text: 'JOSE GUEVARA MARTINEZ');
  TextEditingController ctrlEmail2 =
      TextEditingController(text: 'software@ciplambayeque.com');
  bool _isVisibleIcon = false;
  bool _rememberPass = false;

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
  Future<void> getLogin(BuildContext context) async {
    try {
      final response =
          await userRepository.getLogin(ctrlEmail.text, ctrlPassword.text);
      print(response.code);
      if (response.data!.isEmpty) {
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Validar',
          message: 'Usuario o contraseña incorrecta',
          color: AppColors.warningColor,
        );
        return;
      }
      Helpers.goToLoginRemoveUntil(context);
    } catch (e) {
    } finally {}
  }
  void goToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
  }
}
