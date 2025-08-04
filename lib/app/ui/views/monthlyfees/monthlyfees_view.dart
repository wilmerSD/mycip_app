import 'dart:io';
import 'package:cip_payment_app/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_controller.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/monthlyfees_history.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/monthlyfees_pay.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MonthlyfeesView extends StatelessWidget {
  const MonthlyfeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final monthlyfeesController = Provider.of<MonthlyfeesController>(context);
    bool isIos = false;
    if (!kIsWeb) {
      isIos = Platform.isIOS;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(context),
        title: const Text('Cuotas mensuales'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 10.0,
        children: [
          InkWell(
            onTap: ()=> monthlyfeesController.goToAutomaticPay(context),
            child: Align(  
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  width: 260.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    color: AppColors.secondConst,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50.0))
                      ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Afiliate a pago automático',style: AppTextStyle(context).bold14(color: Colors.white), ),
                      const Icon(Bootstrap.box_arrow_up_right, color: Colors.white,)
                    ],
                  ),
                )
                ),
                ),
          ),
          const SizedBox(),
          CustomTabSwitch(
            tabs: const ['Pagar', 'Historial'],
            initialIndex: monthlyfeesController.selectedIndex,
            onChanged: monthlyfeesController.selectTab,
          ),
          Expanded(
            child: PageView(
              controller: monthlyfeesController.pageController,
              onPageChanged: monthlyfeesController.onPageChanged,
              children: const [
                MonthlyfeesPay(),
                MonthlyfeesHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
