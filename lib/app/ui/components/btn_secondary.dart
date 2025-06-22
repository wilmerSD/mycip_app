import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnSecondary extends StatelessWidget {
  const BtnSecondary(
      {super.key,
      required this.text,
      this.onTap,
      this.borderColor,
      this.textColor});
  final String text;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(kRadiusSmall.r),
          border: Border.all(color: borderColor ?? AppColors.primaryConst, width: 2)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: const Color.fromRGBO(0, 0, 0, 0.08),
          borderRadius: BorderRadius.circular(10.5),
          onTap: onTap,
          child: Center(
            child: Text(text,
                style: AppTextStyle(context).bold18(color: AppColors.primaryConst)),
          ),
        ),
      ),
    );
  }
}
