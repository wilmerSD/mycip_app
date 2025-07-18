import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/components/field_form.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_controller.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateSkillView extends StatelessWidget {
  const CertificateSkillView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final certificateSkill = Provider.of<CertificateSkillController>(context);

    Widget numberCip = CustomTextField(
      helperText: 'CIP',
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlNumberCip,
    );
    Widget numberColegiado = CustomTextField(
      helperText: "Colegiado",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlColegiado,
    );
    Widget numberState = CustomTextField(
      helperText: "Estado",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlState,
    );
    Widget numberEnabledUntil = CustomTextField(
      helperText: "Habilitado hasta",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlEnabledUntil,
    );
    Widget numberSpecialty = CustomTextField(
      helperText: "Especialidad",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlSpecialty,
    );

    Widget btnPay = BtnPrimaryInk(
        text: 'Pagar S/ 30.0',
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupGeneral(
                onTapButton: () => {},
                title: "Cuota mensual",
                content: const CheckoutMonthlyfees(),
              );
              // return isIos
              //     ? CupertinoAlertDialogComp(
              //         tittle: '¿Estás seguro(a) de cerrar sesión?',
              //         onTapButton: () =>
              //             Helpers.goToLoginRemoveUntil(context),
              //       )
              //     : AlertDialogComponent(
              //         onTapButton: () => {},
              //         title: "¿Estás seguro(a) de cerrar sesión?");
            },
          );
          // CheckoutMonthlyfees
          // monthlyfeesController.createToken(

          // );
        });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Certificado de habilidad'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            spacing: 15.0,
            children: [
              const SizedBox(),
              numberCip,
              numberColegiado,
              numberState,
              numberEnabledUntil,
              numberSpecialty,
              const Spacer(),
              btnPay,
              const SizedBox(height: 10.0,),
            ],
          ),
        ));
  }
}
