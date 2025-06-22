import 'dart:io';
import 'package:cip_payment_app/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_app/app/ui/views/home/home_controller.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DrawerMenuApp extends StatelessWidget {
  const DrawerMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kPaddingAppLargeApp.w,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryConst,
                radius: kRadiusLarge,
                child: Icon(Icons.person,
                    color: AppColors.backgroundColor(context), size: 30.0),
              ),
              SizedBox(height: kSize.h),
              Text(
                "Hola,",
                style: AppTextStyle(context).medium14(
                  color: AppColors.blueDark,
                ),
              ),
              Text(
                "José Wilmer Sanchez Díaz",
                style: AppTextStyle(context).bold18(
                  color: AppColors.blueDark,
                ),
              ),
              SizedBox(height: kSize.h),
              const Divider(color: AppColors.grayLight),
              ListTile(
                onTap: () => {
                  homeController.goToProfile(context)
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.calendar_month_outlined,
                  size: kIconSizeSmall.h,
                  color: AppColors.blueDark,
                ),
                title: Text(
                  "Perfil",
                  style: AppTextStyle(context).medium14(
                    color: AppColors.blueDark,
                  ),
                ),
              ),
              const Divider(color: AppColors.grayLight),
              ListTile(
                onTap: () => {},
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.security,
                  size: kIconSizeSmall.h,
                  color: AppColors.blueDark,
                ),
                title: Text(
                  "IEPI",
                  style: AppTextStyle(context).medium14(
                    color: AppColors.blueDark,
                  ),
                ),
              ),
              const Divider(color: AppColors.grayLight),
              ListTile(
                onTap: () => (),
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.receipt,
                  size: kIconSizeSmall.h,
                  color: AppColors.blueDark,
                ),
                title: Text(
                  "Capítulo",
                  style: AppTextStyle(context).medium14(
                    color: AppColors.blueDark,
                  ),
                ),
              ),
              const Divider(color: AppColors.grayLight),
              ListTile(
                onTap: () => {},
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.security,
                  size: kIconSizeSmall.h,
                  color: AppColors.blueDark,
                ),
                title: Text(
                  "Gestión",
                  style: AppTextStyle(context).medium14(
                    color: AppColors.blueDark,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  if (Platform.isIOS) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            "¿Estás seguro(a) de cerrar sesión?",
                            style: TextStyle(
                                color: AppColors.blueDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp),
                          ),
                          content: Text(""),
                          actions: [
                            TextButton(
                              child: Text("No",
                                  style: TextStyle(
                                      color: AppColors.blueDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp)),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el diálogo
                              },
                            ),
                            TextButton(
                              child: Text("Sí",
                                  style: TextStyle(
                                      color: AppColors.blueDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp)),
                              onPressed: () {
                                // homecontroller.goToLogin(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialogComponent(
                            onTapButton: () => {},
                            title: "¿Estás seguro(a) de cerrar sesión?");
                      },
                    );
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.logout,
                  size: kIconSizeSmall.h,
                  color: AppColors.blueDark,
                ),
                title: Text(
                  "Cerrar sesión",
                  style: TextStyle(
                      color: AppColors.blueDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
