import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MonthlyfeesHistory extends StatelessWidget {
  const MonthlyfeesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: context.read<MonthlyfeesProvider>().paymentHistoryQuotas.isEmpty
          ? const NohistoryView()
          : Column(
              children: [
                Consumer<MonthlyfeesProvider>(
                  builder: (context, provider, _) {
                    return SingleChildScrollView(
                      child: Wrap(
                        spacing: 30.0,
                        runSpacing: 10.0,
                        children: List.generate(
                            provider.paymentHistoryQuotas.length, (
                          index,
                        ) {
                          final payment = provider.paymentHistoryQuotas[index];

                          final paymentDate = payment.paymentDate;
                          final paymentDateStr =
                              Helpers.timestampToString(paymentDate);
                          final amount =
                              payment.paymentValue?.toDouble() ?? 0.0;

                          return _customContainer(
                              context,
                              '${Helpers.getNameMonth(payment.feeMonth ?? 0)} ${payment.feeYear}',
                              Helpers.typePay(payment.receiptType), () {

                            provider.getReceipt(
                              paymentDate.toString(),
                              paymentDateStr,
                              fullName,
                              dni,
                              amount,
                            );

                          }, 'S/.$amount', 'Pagado el $paymentDateStr');
                        }),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

Widget _customContainer(BuildContext context, String tittle, String text,
    VoidCallback ontap, String textSecond, String textThird) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        ' ' + tittle,
        style: AppTextStyle(context).bold16(
            fontWeight: FontWeight.w500, color: AppColors.textBasic(context)),
      ),
      Container(
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
                      style: AppTextStyle(context).bold15(
                          fontWeight: FontWeight.w300,
                          color: AppColors.grayBlue),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: 15.0,
                      width: 1.0,
                      color: AppColors.grayBlue,
                    ),
                    Text(textSecond,
                        style: AppTextStyle(context).bold15(
                            fontWeight: FontWeight.w300,
                            color: AppColors.grayBlue)),
                  ],
                ),
                Text(textThird,
                    style: AppTextStyle(context).bold15(
                        fontWeight: FontWeight.w300, color: AppColors.grayBlue))
              ],
            ),
            IconButton(
              onPressed: ontap,
              icon: const Icon(
                Bootstrap.download,
                color: AppColors.secondConst,
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10.0,
      )
    ],
  );
}
