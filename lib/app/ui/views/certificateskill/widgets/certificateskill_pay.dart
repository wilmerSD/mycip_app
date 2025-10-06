import 'package:cip_payment_app/app/domain/entities/speciality.dart';
import 'package:cip_payment_app/app/infrastructure/models/select_model.dart';
import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/components/bill/select_receipt.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_app/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_app/app/ui/components/field/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/components/field/read_only_field.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateskillPay extends StatelessWidget {
  const CertificateskillPay({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final fullName =
        '${person?.namePerson} ${person?.paternalSurname} ${person?.motherSurname}';
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              inputCipCertificate(context, person?.numberCip ?? ''),
              const SizedBox(
                height: 15.0,
              ),
              inputEmailCertificate(context, fullName),
              const SizedBox(
                height: 15.0,
              ),
              inputStateCertificate(context, person?.stateCollegiate ?? false),
              const SizedBox(
                height: 15.0,
              ),
              inputEnabledCertificate(context, '12/12/2025'),
              const SizedBox(
                height: 15.0,
              ),
              quantityCertificates(context),
              const SizedBox(
                height: 15.0,
              ),
              inputSpecialtyCertificate(context, ''),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
        customBtnPay(context),
      ],
    );
  }
}

Widget inputCipCertificate(BuildContext context, String value) {
  return ReadOnlyField(
    label: 'CIP',
    value: value,
  );
}

Widget inputEmailCertificate(BuildContext context, String value) {
  return ReadOnlyField(
    label: "Colegiado",
    value: value,
  );
}

Widget inputStateCertificate(BuildContext context, bool value) {
  String valueText = 'Deshabilitado';
  if (value) {
    valueText = 'Habilitado';
  }
  return ReadOnlyField(
    label: "Estado",
    value: valueText,
  );
}

Widget inputEnabledCertificate(BuildContext context, String value) {
  return ReadOnlyField(
    label: "Habilitado hasta",
    value: value,
  );
}

Widget inputSpecialtyCertificate(BuildContext context, String value) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return Select(
    isActive: false,
    label: "Especialidad",
    value: certificateSkill.listSpecialities.isEmpty
        ? null
        : certificateSkill.listSpecialities.firstWhere(
            (element) => element.id == certificateSkill.currectSpecialty.id,
            orElse: () => certificateSkill.listSpecialities.first,
          ),
    items: certificateSkill.listSpecialities.map((element) {
      return DropdownMenuItem(
        value: element,
        child: OptionSelect(
            nameOption: element.nameSpeciality ?? ''), // 👈 mostrar el nombre
      );
    }).toList(),
    onChanged: (newValue) {
      if (newValue != null) {
        certificateSkill.currectSpecialty = SelectModel(
          id: (newValue as Speciality).id ?? '',
          value: newValue.nameSpeciality ?? '',
        );
      }
    },
  );
}

Widget quantityCertificates(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    textInputType: TextInputType.number,
    helperText: 'Cantidad',
    textEditingController: certificateSkill.quantityCertificate,
    onChanged: (p0) {
      certificateSkill.updateAmount();
    },
  );
}

Widget customBtnPay(BuildContext context) {
  
  return Consumer<CertificateSkillProvider>(builder: (context, provider, _) {
    return BtnPrimaryInk(
      withIconProgress: false,
      loading: provider.haveQuotasPending || provider.amountToPay == 0,
      text: 'Pagar ${provider.amountToPay}',
      onTap: () {
        // provider.prueba();
        ModalUtils.getShowModalBS(
          context,
          content: SelectReceipt(
            mainText: 'Pagar S/. ${provider.amountToPay}',
            textBtn: 'Continuar',
            textPopUp: 'Pagar certificado de habilidad',
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
