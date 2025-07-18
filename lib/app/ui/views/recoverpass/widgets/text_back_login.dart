import 'package:cip_payment_app/app/ui/views/recoverpass/recoverpass_controller.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextBackLogin extends StatelessWidget {
  const TextBackLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverPassController =  Provider.of<RecoverPassController>(context);
    return InkWell(
      onTap: () => recoverPassController.goToLogin(context),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '¿Recordaste tu contraseña?',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.w500,
                color: AppColors.quaternaryConst,
              ),
            ),
            TextSpan(
              text: ' Acceder',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryConst,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
