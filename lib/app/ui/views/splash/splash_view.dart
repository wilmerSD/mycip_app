import 'package:cip_payment_app/app/ui/views/login/login_controller.dart';
import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simula una espera antes de redirigir a la vista de inicio de sesión
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => LoginController(),
            child: const LoginView(),
          ),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 0.0,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/LOGO_CIP.png'), // Reemplaza con tu imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('MiCIP',
                    style: AppTextStyle(context).bold45(
                        color: AppColors.primaryConst,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              width: 210.0,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'power by',
                      style: AppTextStyle(context).bold12(
                        fontWeight: FontWeight.w300,
                        color: AppColors.secondConst,
                      ),
                    ),
                    TextSpan(
                      text: ' Consejo Departamental de Lambayeque',
                      style: AppTextStyle(context).bold12(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondConst,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text(
            //   'power by',
            //   style: AppTextStyle(context).bold12(
            //     fontWeight: FontWeight.w300,
            //     color: AppColors.secondConst,
            //   ),
            // ),
            // Text(
            //   'Consejo Departamental de Lambayeque',
            //   style: AppTextStyle(context).bold12(color: AppColors.secondConst),
            // )
          ],
        ),
      ),
    );
  }
}
