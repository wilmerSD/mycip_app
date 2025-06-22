import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class MonthlyfeesView extends StatelessWidget {
  const MonthlyfeesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuotas mensuales'),
      ),
      body: Column(
        spacing: 10.0,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (bool? value) {}),
                Text('Seleccionar todo'),
              ],
            ),
          ),
          _customContainer(
              context,
              Checkbox(value: true, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Abril 2025'),
          _customContainer(
              context,
              Checkbox(value: false, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Mayo 2025'),
          _customContainer(
              context,
              Checkbox(value: false, onChanged: (value) {}),
              'Cuota ordinaria',
              () {},
              'Junio 2025'),
          Spacer(),
          
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: BtnPrimaryInk(text: 'Pagar S/ 0.0')),
          Text('Ver historial de pagos'),
          SizedBox(
            height: 20.0,
          ),
          
        ],
      ),
    );
  }
}

Widget _customContainer(BuildContext context, Widget icon, String text,
    VoidCallback ontap, String textSecond) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0, /*  vertical: 20.0 */
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(92, 249, 249, 250),
          border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10.0,
            children: [
              icon,
              Text(
                text,
                style: AppTextStyle(context).bold16(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.textBasic(context)),
              ),
            ],
          ),
          Text(textSecond),
        ],
      ),
    ),
  );
}
