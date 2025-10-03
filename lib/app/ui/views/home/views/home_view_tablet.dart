import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/views/home/home_provider.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/drawer_menu_app.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/option_type_pay.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeViewTablet extends StatelessWidget {
  const HomeViewTablet({super.key, required this.homeProvider});

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      drawer: const DrawerMenuApp(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Column(
              spacing: 30.0,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 40.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    OptionTypePay(
                      text: 'Cuotas mensuales',
                      icon: Bootstrap.calendar2_check,
                      context: context,
                      colorBackIcon: const Color.fromRGBO(108, 14, 16, .5),
                      colorIcon: const Color.fromRGBO(108, 14, 16, 1),
                      ontap: () {
                        context.push(AppRoutesName.MONTHLYFEES);
                      }, whatPlatformIs: 1,
                    ),
                    OptionTypePay(
                      text: 'Certificado de habilidad',
                      icon: Bootstrap.award,
                      context: context,
                      colorBackIcon: const Color.fromRGBO(215, 181, 109, .5),
                      colorIcon: const Color.fromRGBO(215, 181, 109, 1),
                      ontap: () {
                        context.push(AppRoutesName.CERTIFICATESKILL);
                      }, whatPlatformIs: 1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 40.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    OptionTypePay(
                      text: 'Constancia de no adeudo',
                      icon: Bootstrap.file_earmark_text,
                      context: context,
                      colorBackIcon: const Color.fromRGBO(42, 42, 41, .5),
                      colorIcon: const Color.fromRGBO(42, 42, 41, 1),
                      ontap: () {
                        context.push(AppRoutesName.PROOFNODEBT);
                      }, whatPlatformIs: 1,
                    ),
                    OptionTypePay(
                      text: 'Adelanto de cuotas',
                      icon: Bootstrap.cash_stack,
                      context: context,
                      colorBackIcon: const Color.fromRGBO(227, 30, 36, .5),
                      colorIcon: const Color.fromRGBO(227, 30, 36, 1),
                      ontap: () {
                        context.push(AppRoutesName.ADVANCEPAYMENT);
                      }, whatPlatformIs: 1,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
