import 'package:cip_payment_app/app/ui/components/btn/btn_primary.dart';
import 'package:flutter/material.dart';

class PendingPayment extends StatelessWidget {
const PendingPayment({ super.key, required this.text });
  final String text;
  @override
  Widget build(BuildContext context){
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.0,
        children: [
          const Icon(Icons.pending_actions, size: 60, color: Colors.orange,),
          Text(text),
          BtnPrimary(text: 'Ir a pagar', onTap: () => {}),
          const SizedBox(),
        ],
      ),
    );
  }
}