import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/components/bill/select_receipt.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/nodebt_view.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesPay extends StatelessWidget {
  const MonthlyfeesPay({super.key});

  @override
  Widget build(BuildContext context) {
    // final monthlyfeesProvider = Provider.of<MonthlyfeesProvider>(context);
    return context.watch<MonthlyfeesProvider>().isGettingPendingPay
        ? const Center(child: CircularProgressIndicator())
        : context.read<MonthlyfeesProvider>().listQuotas.isEmpty
            ? const NodebtView()
            : Column(
                spacing: 10.0,
                children: [
                  Row(
                    children: [
                      Consumer<MonthlyfeesProvider>(
                        builder: (context, provider, _) {
                          return Checkbox(
                            value: provider.allSelected,
                            onChanged: (bool? value) {
                              provider.toggleSelectAll();
                            },
                          );
                        },
                      ),
                      Text(
                        'Seleccionar todo',
                        style: AppTextStyle(context).bold13(),
                      ),
                    ],
                  ),
                  Consumer<MonthlyfeesProvider>(
                    builder: (context, provider, _) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 30.0,
                            runSpacing: 10.0,
                            children:
                                List.generate(provider.listQuotas.length, (
                              index,
                            ) {
                              final fee = provider.listQuotas[index];
                              return _customContainer(
                                context,
                                Checkbox(
                                  value: fee.isSelected,
                                  onChanged: (value) {
                                    provider.togglePaid(
                                        index, value ?? false);
                                  },
                                ),
                                'Cuota ordinaria',
                                () {
                                  provider.togglePaid(
                                      index, !fee.isSelected);
                                },
                                '${Helpers.getNameMonth(fee.feeMonth ?? 0)} ${fee.feeYear}',
                                'S/ ${fee.amount}',
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Consumer<MonthlyfeesProvider>(
                      builder: (context, provider, _) {
                        return BtnPrimaryInk(
                          withIconProgress: false,
                          loading: provider.totalSelected == 0,
                          text: 'Pagar S/. ${provider.totalSelected}',
                          onTap: () {
                            ModalUtils.getShowModalBS(
                              context,
                              content: SelectReceipt(
                                mainText: 'Pagar S/. ${provider.totalSelected}',
                                textBtn: 'Pagar S/. ${provider.totalSelected}',
                                textPopUp: '',
                                content: const SizedBox(),
                                onTap: () {
                                  context
                                      .read<MonthlyfeesProvider>()
                                      .openCheckout(context);
                                },
                              ),
                              title: 'Detalle de pago',
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}

Widget _customContainer(BuildContext context, Widget icon, String text,
    VoidCallback ontap, String textSecond, textThird) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      // height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(92, 249, 249, 250),
          border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTextStyle(context).bold16(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.textBasic(context)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 15.0,
                    width: 1.0,
                    color: AppColors.textBasic(context),
                  ),
                  Text(textSecond),
                ],
              ),
              Text(textThird)
            ],
          ),
          icon
        ],
      ),
    ),
  );
}
