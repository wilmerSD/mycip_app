import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnPrimaryRounded extends StatelessWidget {
  const BtnPrimaryRounded(
      {super.key, this.onTap, required this.text, this.icon});
  final void Function()? onTap;
  final String text;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primaryConst.withOpacity(0.1),
      // focusColor: AppColors.primaryConst,
      onTap: () => onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: AppColors.primaryConst)),
        child: icon == null
            ? Text(
                text,
                style:
                    AppTextStyle(context).bold14(color: AppColors.primaryConst),
              )
            : Row(
                children: [
                  Icon(icon),
                  Text(
                    text,
                    style: AppTextStyle(context)
                        .bold14(color: AppColors.primaryConst),
                  ),
                ],
              ),
      ),
    );
  }
}
