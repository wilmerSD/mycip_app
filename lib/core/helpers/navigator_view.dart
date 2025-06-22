import 'package:cip_payment_app/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

class NavigatorView {

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.HOME);
  }
  static void goToRecoverPass(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.RECOVERPASS);
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.LOGIN);
  }
  static void goToHomeRemoveUntil(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutesName.HOME,
      (Route<dynamic> route) =>
          false, // Esta función elimina todas las rutas previas
    );
  }

  static void goToLoginRemoveUntil(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutesName.LOGIN,
      (Route<dynamic> route) => false,
    );
  }

}
