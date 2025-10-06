import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnPrimaryInk extends StatelessWidget {
  
  const BtnPrimaryInk({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.withIconProgress = true,
    this.margin,
  });
  final String text;
  final bool loading;
  final bool withIconProgress;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).disabledColor;
    return Container(
      height: 50.0,
      margin: margin,
      decoration: BoxDecoration(
        // color: loading ? AppColors.grayDesactivate : AppColors.primaryConst,
        color: loading ? colorTheme : AppColors.primaryConst,
        // gradient: loading ? AppColors.grayDesactivate: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(kRadiusMedium),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : onTap,
          borderRadius: BorderRadius.circular(kRadiusMedium),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaler: TextScaler.linear(1),
                  text,
                  style: AppTextStyle(context).bold18(color: Colors.white),
                ),
                loading
                    ? Row(
                        children: [
                          SizedBox(width: 30.0),
                          withIconProgress ? 
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ): SizedBox()
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
