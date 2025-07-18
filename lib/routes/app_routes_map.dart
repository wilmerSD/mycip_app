import 'package:cip_payment_app/app/ui/views/home/home_view.dart';
import 'package:cip_payment_app/app/ui/views/iepi/iepi_view.dart';
import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:cip_payment_app/app/ui/views/splash/splash_view.dart';
import 'package:cip_payment_app/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutesName.SPLASH: (context) => const SplashView(),
      AppRoutesName.HOME: (context) => const HomeView(),
      AppRoutesName.RECOVERPASS: (context) => const RecoverPasswordEmail(),
      AppRoutesName.LOGIN: (context) => const LoginView(),
      AppRoutesName.IEPI: (context) => const IepiView(),
    };
  }
}
