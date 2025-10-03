import 'package:cip_payment_app/app/providers/bill_provider.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm(
    this.textRuc,
    this.isCreate,
    this.isNewModal,{
    super.key,
  });
  final bool isCreate;
  final String textRuc;
  final bool isNewModal;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 20.0,
        children: [
          _inputRuc(context),
          _inputCompanyName(context),
          _inputAddress(context),
          _inputEmail(context),
          _inputPhone(context),
          BtnPrimaryInk(
            text: textRuc,
            onTap: () {
              
              // isNewModal ?
              // Navigator.pop(context): null;
              isCreate
                  ? context.read<BillProvider>().registerRuc(context)
                  : context.read<BillProvider>().updateRuc(context);
            },
            loading: context.read<BillProvider>().isSaving,
          )
        ],
      ),
    ));
  }
}

/* 📌 Input ruc */
Widget _inputRuc(BuildContext context) {
  return CustomTextField(
    helperText: 'Ruc',
    textEditingController: context.read<BillProvider>().ctrlRuc,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}

Widget _inputCompanyName(BuildContext context) {
  return CustomTextField(
    helperText: 'Razón social',
    textEditingController: context.read<BillProvider>().ctrlCompanyName,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}

Widget _inputAddress(BuildContext context) {
  return CustomTextField(
    helperText: 'Dirección',
    textEditingController: context.read<BillProvider>().ctrlAddress,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}

Widget _inputEmail(BuildContext context) {
  return CustomTextField(
    helperText: 'Email',
    textEditingController: context.read<BillProvider>().ctrlEmail,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}

Widget _inputPhone(BuildContext context) {
  return CustomTextField(
    helperText: 'Telefono',
    textEditingController: context.read<BillProvider>().ctrlPhoneNumber,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}
