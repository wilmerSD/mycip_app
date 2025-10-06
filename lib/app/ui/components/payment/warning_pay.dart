import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class WarningPay extends StatelessWidget {
  const WarningPay(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) { 
    return Column(
      spacing: 20.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 140.0,
          width: 140.0,
          child: Lottie.asset('assets/warning_animation.json'),
        ),
        Text(
          text,
          style: AppTextStyle(context).bold20(fontWeight: FontWeight.w300, ),
        ),
        const SizedBox(height: 35.0),
        BtnPrimary(
          text: 'Ir a pagar',
          onTap: () => context.push(AppRoutesName.MONTHLYFEES),
        ),
        // const SizedBox(),
      ],
    );
  }
}
