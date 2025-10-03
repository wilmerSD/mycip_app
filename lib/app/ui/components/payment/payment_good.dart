import 'package:cip_payment_app/app/ui/components/btn/btn_primary.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_rounded.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentGood extends StatelessWidget {
  const PaymentGood(
    this.operationId,
    this.dateTime,
    this.amount,
    this.concept, {
    super.key,
  });

  final double amount;
  final String concept;
  final int operationId;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    Color colorText = const Color.fromRGBO(90, 97, 111, 1);
    return SizedBox(
      height: 564.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 440.0,
        // height: 550,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: colorTheme.onInverseSurface,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 55.0,
              width: 55.0,
              child: Stack(
                children: [
                  Icon(Bootstrap.receipt_cutoff, size: 50, color: colorText),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: colorTheme.onInverseSurface,
                      radius: 10,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Listo, hicimos el pago correctamente',
              style: AppTextStyle(context).bold15(color: colorTheme.primary),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 0.5, color: colorText),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Monto',
                          style: AppTextStyle(
                            context,
                          ).textPayment(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        // flex: 2,
                        child: BtnRounded(Bootstrap.share, 'Compartir', () {}),
                      ),
                    ],
                  ),
                  Text(
                    'S/. $amount',
                    style: AppTextStyle(context).textPayment(),
                  ),
                  Divider(color: colorText, thickness: 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Concepto'), Text(concept)],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Igv'), Text('18%')],
                  ),
                  Divider(color: colorText, thickness: 0.5),
                  const Center(
                    child: Column(
                      children: [
                        Text('11 de diciembre de 2025 - 14:29 horas'),
                        Text('Operación 177796497'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             BtnPrimary(
                text: 'Finalizar',
                onTap: () => Navigator.of(context).pop(),
              ),
            
          ],
        ),
      ),
    );
  }
}
