import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/btn_secondary.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_controller.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/widgets/datatable_advance_cuotas.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/widgets/detail_advance_cuotas.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final advancepayment = Provider.of<AdvancepaymentController>(context);
    Widget numberCip = CustomTextField(
      enabledfield: true,
      helperText: 'Ultimo pago',
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlLastPay,
    );
    Widget numberColegiado = CustomTextField(
      enabledfield: true,
      helperText: "Cantidad de cuotas",
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlQuantityCuotas,
    );
    Widget numberState = CustomTextField(
      enabledfield: true,
      helperText: "Habilitado hasta",
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlEnabledUntil,
    );

    Widget btnCalculate = BtnSecondary(
      text: 'Calcular',
      onTap: () => ModalUtils.getShowModalBS(
        context,
        content: const DetailAdvanceCuotas(),
        title: 'Detalle de adelanto',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificado de habilidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          spacing: 12.0,
          children: [
            numberCip,
            numberColegiado,
            numberState,
            const SizedBox(),
            const Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: DatatableAdvanceCuotas(),
              ),
            ),
            btnCalculate,
            const SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }
}
