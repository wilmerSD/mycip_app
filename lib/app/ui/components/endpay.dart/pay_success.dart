import 'package:cip_payment_app/app/ui/components/btn/btn_primary.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_rounded.dart';
import 'package:cip_payment_app/app/ui/views/login/logo.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaySuccess extends StatelessWidget {
  const PaySuccess({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Logo()),
            Stack(
              children: [
                const Icon(Bootstrap.receipt_cutoff, size: 100, color: Colors.grey),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, // o el color que prefieras
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Bootstrap.check_circle_fill, color: Colors.green, size: 30,),)),
              ],
            ),
            Text(title, style: AppTextStyle(context).bold17()),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blue, width: 1.0),
              ),
              child: const Column(
                spacing: 20.0,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monto'),
                      BtnPrimaryRounded(text: 'Compartir',icon: Bootstrap.share,)
                    ],
                  ),
                   Text('S./240.00'),
                    ],
                   ),
                   Divider(height: 1 ,),
                   Column(
                    spacing: 10.0,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text('Concepto'),
                        Text('Cuota mensual'),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pasarela de pago'),
                      Text('Culqi'),
                    ],
                  ),
                    ],
                   ),
                   Divider(height: 1 ,),
                  Column(children: [
                     Text('11 de diciembre de 2025 - 14:29 horas '),
                   Text('Operación 177796497'),
                  ],)
                  
                ],
              ),
        
            ),
            BtnPrimary(text: 'Finalizar',onTap: () => Navigator.pop(context),)
          ],
        ),
      ),
    );
  }
}