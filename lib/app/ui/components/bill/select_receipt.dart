import 'package:cip_payment_app/app/providers/bill_provider.dart';
import 'package:cip_payment_app/app/ui/components/bill/company_form.dart';
import 'package:cip_payment_app/app/ui/components/bill/fields_bill.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectReceipt extends StatelessWidget {
  const SelectReceipt(
      {super.key,
      required this.onTap,
      required this.mainText,
      required this.textBtn,
      required this.textPopUp,
      required this.content});
  final void Function() onTap;
  final String mainText;
  final String textBtn;
  final String textPopUp;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    Widget btnPay = BtnPrimaryInk(text: mainText, onTap: onTap);

    return ChangeNotifierProvider(
      create: (_) => BillProvider(),
      child: Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final billProvider =
              Provider.of<BillProvider>(context, listen: false);
          billProvider.onInit(context);
        });
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              spacing: 20.0,
              children: [
                Selector<BillProvider, bool>(
                  selector: (_, provider) => provider.isGettingRucs,
                  builder: (context, isGettingRucs, _) {
                    return isGettingRucs
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '¿Necesitas factura?',
                                style: AppTextStyle(context).bold15(),
                              ),
                              _customBtn(context, () {
                                // print(context.read<BillProvider>().listCompanies.length);
                                // ModalUtils.getShowModalBS(
                                //   context,
                                //   content: ChangeNotifierProvider.value(
                                //     value: context.read<BillProvider>(),
                                //     child: Consumer<BillProvider>(
                                //       builder: (context, provider, _) {
                                //         print(provider.listCompanies.length);
                                //         return provider.listCompanies.isEmpty
                                //             ? const CompanyForm(
                                //                 'Guardar', true, true)
                                //             : FieldsBill(
                                //                 textBtn: textBtn,
                                //                 textPopUp: textPopUp,
                                //                 content: content,
                                //                 onTap: onTap,
                                //               );
                                //       },
                                //     ),
                                //   ),
                                //   title: 'Detalle de factura',
                                // );
                                context
                                        .read<BillProvider>()
                                        .listCompanies
                                        .isNotEmpty
                                    ? ModalUtils.getShowModalBS(
                                        context,
                                        content: ChangeNotifierProvider.value(
                                            value: context.read<BillProvider>(),
                                            child: FieldsBill(
                                              textBtn: textBtn,
                                              textPopUp: textPopUp,
                                              content: content,
                                              onTap: onTap,
                                            )),
                                        title: 'Detalle de factura',
                                      )
                                    : ModalUtils.getShowModalBS(
                                        context,
                                        content: ChangeNotifierProvider.value(
                                            value: context.read<BillProvider>(),
                                            child: const CompanyForm(
                                                'Guardar', true, true)),
                                        title: 'Detalle de factura',
                                      );
                              })
                            ],
                          );
                  },
                ),
                btnPay,
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget _customBtn(BuildContext context, Function onTap) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppColors.primaryConst)),
      child: Text(
        'Solicitar',
        style: AppTextStyle(context).bold14(color: AppColors.primaryConst),
      ),
    ),
  );
}
