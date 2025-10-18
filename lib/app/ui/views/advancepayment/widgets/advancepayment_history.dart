import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/components/nohistory_view.dart';
import 'package:cip_payment_app/app/ui/components/payment_tile.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentHistory extends StatelessWidget {
const AdvancepaymentHistory({ super.key });

  @override
  Widget build(BuildContext context) {
    final advancepaymentHistory =
        Provider.of<AdvancepaymentProvider>(context);
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";
    return advancepaymentHistory.paymentHistory.isEmpty
        ? const NohistoryView()
        : SingleChildScrollView(
            child: Wrap(
                spacing: 30.0,
                runSpacing: 10.0,
                children: List.generate(
                    advancepaymentHistory.paymentHistory.length, (index) {
                  final payment =
                      advancepaymentHistory.paymentHistory[index];
                  final paymentDate = payment.creationDatePay;
                  final amount = payment.paymentValue?.toDouble() ?? 0.0;
                  final paymentDateStr = Helpers.timestampToString(paymentDate);

                  return PaymentTile(
                      paymentDateStr, Helpers.typePay(payment.receiptType), () {
                    // advancepaymentHistory.getReceipt(
                    //   paymentDate?.seconds.toString() ?? '',
                    //   paymentDateStr,
                    //   fullName,
                    //   dni,
                    //   amount,
                    // );
                  }, '$amount', 'Pagado el $paymentDateStr', true,
                      receiptNumber: paymentDate?.seconds.toString() ?? '',
                      date: paymentDateStr,
                      name: fullName,
                      dni: dni,
                      subtotal: amount,
                      typePay: textAdvancepayment,
                      );
                }))
            // PaymentTile(
            //     '',
            //     'text',
            //     (){},
            //     "textSecond",
            //     "textThird",
            //     true
            // ),

            );
  }
}
