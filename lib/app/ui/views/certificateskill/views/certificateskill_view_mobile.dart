import 'package:cip_payment_app/app/ui/components/bill/select_receipt.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateskillViewMobile extends StatelessWidget {
const CertificateskillViewMobile({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsetsGeometry.all(15),
      child: Column(
        spacing: 20.0,
        children: [
          Expanded(child: inputCipCertificate(context)),
          Expanded(child: inputEmailCertificate(context)),
          Expanded(child: inputStateCertificate(context)),
          Expanded(child: inputEnabledCertificate(context)),
          Expanded(child: inputSpecialtyCertificate(context)),
          const Expanded(child: SizedBox()),

          customBtnPay(context),
        ],
      ),
    );
  }
}

Widget inputCipCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: 'CIP',
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlNumberCip,
  );
}

Widget inputEmailCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Colegiado",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlColegiado,
  );
}

Widget inputStateCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Estado",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlState,
  );
}

Widget inputEnabledCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Habilitado hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlEnabledUntil,
  );
}

Widget inputSpecialtyCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Especialidad",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlSpecialty,
  );
}

Widget customBtnPay(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return BtnPrimaryInk(
    withIconProgress: false,
    loading: certificateSkill.haveQuotasPending,
    text: 'Pagar S/ 30.0',
    onTap: () {
      ModalUtils.getShowModalBS(
        context,
        content: SelectReceipt(
          mainText: 'Pagar S/. 30.0',
          textBtn: 'Continuar',
          textPopUp: 'Pagar certificado de habilidad',
          content: CheckoutMonthlyfees(), onTap: () {  },
        ),
        title: 'Detalle de pago',
      );
    },
  );
}
