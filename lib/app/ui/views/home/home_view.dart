import 'package:cip_payment_app/app/ui/views/home/home_controller.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/appBar_home.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/drawer_menu_app.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    final size = MediaQuery.sizeOf(context);
    return ChangeNotifierProvider(
        create: (_) => HomeController(),
        child: Scaffold(
          // appBar: AppBar(),
          drawer: const DrawerMenuApp(),
          body: Builder(
              builder: (context) => Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 200,
                                width: 200,
                              )
                            ],
                          )),
                      Stack(
                        children: [],
                      ),
                      Column(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color.fromRGBO(253, 231, 232, 1),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            color: AppColors.backgroundColor(context),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Spacer(),
                                  Text('COLEGIO DE INGENIEROS DEL PERÚ', style: AppTextStyle(context).bold16()),
                                  Text('Consejo Departamental de Lambayeque'),
                                  SizedBox(height: 15.0,)
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                      Positioned(
                        top: 370.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          width: size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  containerOption(
                                      'Cuotas mensuales',
                                      Bootstrap.calendar2_check,
                                      context,
                                      const Color.fromRGBO(108, 14, 16, .5),
                                      const Color.fromRGBO(108, 14, 16, 1),(){homeController.goToMonthlyFees(context);}),
                                  containerOption(
                                      'Certificado de habilidad',
                                      Bootstrap.award,
                                      context,
                                      const Color.fromRGBO(215, 181, 109, .5),
                                      const Color.fromRGBO(215, 181, 109, 1),(){homeController.goToCertificateSkill(context);}),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  containerOption( 
                                      'Constancia de no adeudo',
                                      Bootstrap.file_earmark_text,
                                      context,
                                      const Color.fromRGBO(42, 42, 41, .5),
                                      const Color.fromRGBO(42, 42, 41, 1),(){homeController.goToProofnodebtView(context);}),
                                  containerOption(
                                      'Adelanto de cuotas',
                                      Bootstrap.cash_stack,
                                      context,
                                      const Color.fromRGBO(227, 30, 36, .5),
                                      const Color.fromRGBO(227, 30, 36, 1),(){homeController.goToMonthlyFees(context);}),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppBarHome(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Hola, José Guevara',
                                style: AppTextStyle(context).bold22(),
                              ),
                              Text(
                                'N° CIP:1010203',
                                style: AppTextStyle(context).bold17(fontWeight: FontWeight.w200),
                              ),
                            ],
                          )),
                    ],
                  )),
        ));
  }
}

Widget containerOption(String text, IconData icon, BuildContext context,
    Color colorBackIcon, Color colorIcon, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150.0,
          height: 155.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.07),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 65,
                decoration: BoxDecoration(
                    color: colorBackIcon,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Icon(
                  icon,
                  color: colorIcon,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: 140.0,
                  child: Text(
                    text,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.start,
                    style: AppTextStyle(context).bold17(),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}
