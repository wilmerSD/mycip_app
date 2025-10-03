import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/monthlyfees_history.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/monthlyfees_pay.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesView extends StatelessWidget {
  const MonthlyfeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      
      // Se ejecuta solo una vez cuando se construye el widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final monthlyfeesProvider =
          Provider.of<MonthlyfeesProvider>(context, listen: false);
        monthlyfeesProvider.onInit(context);
      });
    
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor(context),
        appBar: const CustomAppBar(title: textMonthlyfees,),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 10.0,
          children: [
            // InkWell(
            //   onTap: () => context.go(AppRoutesName.AUTOMATICPAY),
            //   child: Align(
            //     alignment: Alignment.centerRight,
            //     child: Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //         width: 260.0,
            //         height: 40.0,
            //         decoration: const BoxDecoration(
            //             color: AppColors.secondConst,
            //             borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(50),
            //                 bottomLeft: Radius.circular(50.0))),
            //         child: Center(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             // mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 'Afiliate a pago automático',
            //                 style: AppTextStyle(context)
            //                     .bold14(color: Colors.white),
            //               ),
            //               const Icon(
            //                 Bootstrap.box_arrow_up_right,
            //                 color: Colors.white,
            //               )
            //             ],
            //           ),
            //         )),
            //   ),
            // ),
            const SizedBox(),
            Container(
              // height: 20.0,
              child: _options()),
            Expanded(
              child: PageView(
                controller: context.read<MonthlyfeesProvider>().pageController,
                onPageChanged: (index) => context
                  .read<MonthlyfeesProvider>()
                  .onPageChanged(index),
                children: const [
                  MonthlyfeesPay(),
                  MonthlyfeesHistory(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}


Widget _options() {
  return Consumer<MonthlyfeesProvider>(
    builder: (context, provider, _) {
      return CustomTabSwitch(
        tabs: const ['Pagar', 'Historial'],
        selectedIndex: provider.selectedIndex,
        onChanged: (index) => provider.selectTab(index),
      );
    },
  );
}

