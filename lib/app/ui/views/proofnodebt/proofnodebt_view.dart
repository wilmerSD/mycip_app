import 'package:cip_payment_app/app/ui/components/btn/btn_primary.dart';
import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field/read_only_field.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: const CustomAppBar(title: textProofnodebt,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: customPyBefore(context, textProofnodebt),
        ),
      ),
    );
  }
}

Widget customPyBefore(BuildContext context, String text) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final proofnodebtProvider = Provider.of<ProofnodebtProvider>(
      context,
      listen: false,
    );
    proofnodebtProvider.onInit(context);
  });

  return SizedBox(
    // color: Colors.amber,
    child: Column(
      spacing: 20.0,
      children: [
        _textFieldCip(),
        _textFieldCollege(),
        _textFieldState(),
        _textFieldEnabledUntil(),
        const Spacer(),
        _btnPay(),
        const SizedBox()
      ],
    ),
  );
}

Widget _textFieldCip() {
  return const ReadOnlyField(label: 'Cip', value: '123342341413');
}

Widget _textFieldCollege() {
  return const ReadOnlyField(label: 'Colegiado', value: '123342341413');
}

Widget _textFieldState() {
  return const ReadOnlyField(label: 'Estado', value: '123342341413');
}

Widget _textFieldEnabledUntil() {
  return const ReadOnlyField(label: 'Habilitado hasta', value: '123342341413');
}

Widget _btnPay() {
  return const BtnPrimaryInk(text: 'Pagar');
}
