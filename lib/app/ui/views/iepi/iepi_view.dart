import 'package:cip_payment_app/app/ui/components/btn_primary.dart';
import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/btn_secondary.dart';
import 'package:cip_payment_app/app/ui/components/btn_third.dart';
import 'package:cip_payment_app/app/ui/views/iepi/iepi_controller.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IepiView extends StatelessWidget {
  const IepiView({super.key});

  @override
  Widget build(BuildContext context) {
    final iepiController = Provider.of<IepiController>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor(context),
          surfaceTintColor: Colors.transparent,
          leading: const Leading(),
          title: const CustomTittleAppbar(
              tittle: 'Instituto de Estudios Profesionales de Ingeniería IEPI'),
          actions: [
            Container(
              child: Icon(Icons.abc),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              SizedBox(height: 50,),
              containerCourse(
                  context,
                  'Metrados y cálculo de materiales de construcción',
                  'Curso de especialidad',
                  'Virtual',
                  'https://picsum.photos/id/237/400/200',
                  () {
                    print('hola');
                    iepiController.goToPrueba(context);},
                  () {}),
              SizedBox(height: 25.0,),
              containerCourse(
                  context,
                  'Solidworks desde cero',
                  'Curso de especialidad',
                  'Virtual',
                  'https://picsum.photos/id/237/400/200',
                  () {},
                  () {}),
            ],
          ),
        ));
  }
}

Widget containerCourse(BuildContext context, String tittle, String subtittle,
    String modality,String routeImage, Function() onMoreinf, Function() OnEnroll) {
  return Container(
    height: 380.0,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        spacing: 10.0,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                height: 180.0,
                color: Colors.amber,
                child: Image.network(routeImage))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.0,
              children: [
                Text(
                  tittle,
                  style: AppTextStyle(context).bold17(),
                ),
                Text(subtittle,
                    style: AppTextStyle(context)
                        .bold14(fontWeight: FontWeight.w500)),
                Text(modality,
                    style: AppTextStyle(context)
                        .bold14(fontWeight: FontWeight.w300)),
                Row(
                  spacing: 15.0,
                  children: [
                    Expanded(
                        child: BtnSecondary(
                      text: 'Mas información',
                      onTap: onMoreinf,
                    )),
                    Expanded(
                        child: BtnThird(
                      text: 'Matricularme',
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          )
        ],
      ));
}
