import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/components/bill/select_receipt.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field/read_only_field.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtPay extends StatelessWidget {
  const ProofnodebtPay({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final fullName =
        '${person?.namePerson} ${person?.paternalSurname} ${person?.motherSurname}';
    return Column(
      spacing: 20.0,
      children: [
        _textFieldCip(person?.numberCip ?? ''),
        _textFieldCollege(fullName),
        _textFieldState(context),
        _textFieldEnabledUntil(context),
        const Spacer(),
        _btnPay(context),
        // const SizedBox()
      ],
    );
  }
}

Widget _textFieldCip(String value) {
  return ReadOnlyField(label: 'Cip', value: value);
}

Widget _textFieldCollege(String value) {
  return ReadOnlyField(label: 'Colegiado', value: value);
}

Widget _textFieldState(BuildContext context) {
  final proofnodebtProvider = Provider.of<ProofnodebtProvider>(context);
  String valueText = 'Deshabilitado';
  if (proofnodebtProvider.stateCollegiate) {
    valueText = 'Habilitado';
  }

  return ReadOnlyField(label: 'Estado', value: valueText);
}

Widget _textFieldEnabledUntil(BuildContext context) {
  final proofnodebtProvider = Provider.of<ProofnodebtProvider>(context);
  return ReadOnlyField(
      label: 'Habilitado hasta', value: proofnodebtProvider.enabledUntil);
}

Widget _btnPay(BuildContext context) {
   
  return Consumer<ProofnodebtProvider>(builder: (context, provider, _) {
    return BtnPrimaryInk(
      withIconProgress: false,
      loading: provider.haveQuotasPending || provider.stateCollegiate == false,
      text: 'Pagar S/. ${provider.amountToPay}',
      onTap: () {
        // provider.prueba();
        ModalUtils.getShowModalBS(
          context,
          content: SelectReceipt(
            mainText: 'Pagar S/. ${provider.amountToPay}',
            textBtn: 'Pagar S/. ${provider.amountToPay}',
            textPopUp: 'Pagar $textProofnodebt',
            content: const SizedBox(),
            onTap: () {
              provider.openCheckout(context);
            },
          ),
          title: 'Detalle de pago',
        );
      },
    );
  });
}
