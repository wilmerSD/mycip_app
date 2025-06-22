import 'package:cip_payment_app/app/ui/components/btn_primary.dart';
import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/btn_secondary.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          title: const Text('Constancia de no adeudo'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.07),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 15.0,
                  children: [
                    RichText(
                      text: TextSpan(
                        // text: 'Hello ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Para poder emitir su ',
                              style: AppTextStyle(context).bold18(fontWeight: FontWeight.w300)),
                          TextSpan(
                              text: 'constancia de no adeudo ',
                              style: AppTextStyle(context).bold18()),
                          TextSpan(
                              text: 'debe pagar su cuota pendiente de S/. 20',
                              style: AppTextStyle(context).bold18(fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 15.0,
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(child: BtnSecondary(text: 'Volver',)),
                        Expanded(
                          child: SizedBox(
                            height: 47.0,
                            child:  BtnPrimary(text: 'Ir a pagar')),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ));
  }
}
