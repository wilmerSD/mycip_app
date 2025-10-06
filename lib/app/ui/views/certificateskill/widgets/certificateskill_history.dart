import 'package:cip_payment_app/app/ui/components/nohistory_view.dart';
import 'package:cip_payment_app/app/ui/components/payment_tile.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateskillHistory extends StatelessWidget {
  const CertificateskillHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final certificateSkillProvider =
        Provider.of<CertificateSkillProvider>(context);
    return certificateSkillProvider.paymentHistory.isEmpty
        ? const NohistoryView()
        : Column(
            children: [
              Wrap(
                  spacing: 30.0,
                  runSpacing: 10.0,
                  children: List.generate(
                      certificateSkillProvider.paymentHistory.length, (index) {
                    final payment =
                        certificateSkillProvider.paymentHistory[index];
                    final paymentDate = payment.creationDatePay;
                    final amount = payment.paymentValue?.toDouble() ?? 0.0;
                    final paymentDateStr =
                        Helpers.timestampToString(paymentDate);
                    return PaymentTile(
                        '${Helpers.timestampToString(payment.creationDatePay)} ${payment.feeYear}',
                        Helpers.typePay(payment.receiptType), () {
                      // certificateSkillProvider.getReceipt(
                      //   paymentDate?.seconds.toString() ?? '',
                      //   paymentDateStr,
                      //   fullName,
                      //   dni,
                      //   amount,
                      // );
                    }, '$amount', 'Pagado el $paymentDateStr', true);
                  }))
              // PaymentTile(
              //     '',
              //     'text',
              //     (){},
              //     "textSecond",
              //     "textThird",
              //     true
              // ),
            ],
          );
  }
}
