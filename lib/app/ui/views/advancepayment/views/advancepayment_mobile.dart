import 'package:cip_payment_app/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/widgets/advancepayment_history.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/widgets/advancepayment_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentMobile extends StatelessWidget {
  const AdvancepaymentMobile({super.key});
    @override
  Widget build(BuildContext context) {
    
    return Column(
      spacing: 10.0,
      children: [
        Container(
            // height: 20.0,
            child: optionsCertificateSkill()),
        Expanded(
          child: Padding(
                  padding:const EdgeInsetsGeometry.all(15),
            child: PageView(
              controller: context.read<AdvancepaymentProvider>().pageController,
              onPageChanged: (index) =>
                  context.read<AdvancepaymentProvider>().onPageChanged(index),
              children: const [
                AdvancepaymentPay(),
                AdvancepaymentHistory(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget optionsCertificateSkill() {
  return Consumer<AdvancepaymentProvider>(
    builder: (context, provider, _) {
      return CustomTabSwitch(
        tabs: const ['Pagar', 'Historial'],
        selectedIndex: provider.selectedIndex,
        onChanged: (index) => provider.selectTab(index),
      );
    },
  );
}
 