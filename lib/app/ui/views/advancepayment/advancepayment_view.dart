import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_data_right.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: const CustomAppBar(title: textAdvancepayment),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            spacing: 20.0,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colorTheme
                      .onInverseSurface, // const Color.fromRGBO(227, 30, 36, 0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  spacing: 10.0,
                  children: [
                    Row(
                      spacing: 15.0,
                      children: [
                        Expanded(child: valueOfQuota(context)),
                        Expanded(child: discuount(context)),
                      ],
                    ),
                    enabledUntilAdvancedPay(context),
                  ],
                ),
              ),
              Expanded(
                child: CustomDataRight(
                  SizedBox(
                    // height: 200,
                    child: ListView(
                      children: [
                        const SizedBox(height: 10.0,),
                        numberQuotas(context),
                        const SizedBox(height: 20.0,),
                        wouldBeEnabledUntil(context),
                        const SizedBox(height: 20.0,),
                        subTotal(context),
                        const SizedBox(height: 20.0,),
                        saveMoney(context),
                        const SizedBox(height: 10.0,),
                      ],
                    ),
                  ),
                ),
              ),
               payAdvance(context),
                    const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

Widget valueOfQuota(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Valor de la cuota',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlValueOfQuota,
  );
}

Widget discuount(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Descuento',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlPercentDiscount,
  );
}

Widget enabledUntilAdvancedPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Habilitado hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlEnabledUntil,
  );
}

Widget numberQuotas(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
      helperText: "Cantidad de cuotas",
      textInputType: TextInputType.number,
      textEditingController: advancepayment.ctrlQuantityCuotas,
      onChanged: (_) => advancepayment.calculateToPay());
}

Widget wouldBeEnabledUntil(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Tu habilitación cubre hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlEnabledUntil,
  );
}

Widget subTotal(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Sub total",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlSubTotal,
  );
}

Widget saveMoney(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Ahorras",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlDiscount,
  );
}

Widget payAdvance(BuildContext context) {
  return BtnPrimaryInk(
    text: 'Pagar S/. ${context.read<AdvancepaymentProvider>().totalToPay}',
  );
}

Widget _lastPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Ultimo pago',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlLastPay,
  );
}
