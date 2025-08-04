import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/select_receipt.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class MonthlyfeesPay extends StatelessWidget {
  const MonthlyfeesPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 10.0,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (bool? value) {}),
                const Text('Seleccionar todo'),
              ],
            ),
          ),
          _customContainer(
              context,
              Checkbox(value: true, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Abril 2025',
              'S/ 30'),
          _customContainer(
              context,
              Checkbox(value: false, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Mayo 2025',
              'S/ 30'),
          _customContainer(
              context,
              Checkbox(value: false, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Junio 2025',
              'S/ 30'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BtnPrimaryInk(
                text: 'Pagar S/ 30.0',
                onTap: () {
                  ModalUtils.getShowModalBS(
                        context,
                        content: const SelectReceipt(),
                        title: 'Detalle de pago',
                      );

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                       
                      // return PopupGeneral(
                      //   onTapButton: () => {},
                      //   title: "Cuota mensual",
                      //   content: const CheckoutMonthlyfees(),
                      // );
                      // return isIos
                      //     ? CupertinoAlertDialogComp(
                      //         tittle: '¿Estás seguro(a) de cerrar sesión?',
                      //         onTapButton: () =>
                      //             Helpers.goToLoginRemoveUntil(context),
                      //       )
                      //     : AlertDialogComponent(
                      //         onTapButton: () => {},
                      //         title: "¿Estás seguro(a) de cerrar sesión?");
                  //   },
                  // );
                  // CheckoutMonthlyfees
                  // monthlyfeesController.createToken(

                  // );
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

Widget _customContainer(BuildContext context, Widget icon, String text,
    VoidCallback ontap, String textSecond, textThird) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      // height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(92, 249, 249, 250),
          border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTextStyle(context).bold16(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.textBasic(context)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 15.0,
                    width: 1.0,
                    color: AppColors.textBasic(context),
                  ),
                  Text(textSecond),
                ],
              ),
              Text(textThird)
            ],
          ),
          icon
        ],
      ),
    ),
  );
}
