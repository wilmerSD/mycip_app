
import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/views/home/home_provider.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/appBar_home.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/drawer_menu_app.dart';
import 'package:cip_payment_app/app/ui/views/home/widgets/option_type_pay.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key, required this.homeProvider});
  
  final HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final size = MediaQuery.sizeOf(context);
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        drawer: const DrawerMenuApp(),
        body: Builder(
          builder: (context) => SafeArea(
            child: Stack(
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // Container(
                        //   color: Colors.amber,
                        //   height: 200,
                        //   width: 200,
                        // )
                      ],
                    )),
                const Stack(
                  children: [],
                ),
                Column(
                  children: [
                    
                    Expanded(
                        child: FadeInDown(
                          child: Container(
                                                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: colorTheme.onInverseSurface,// const Color.fromRGBO(253, 231, 232, 1),
                                                ),
                                              ),
                        )),
                    Expanded(
                        child: Container(
                      color: AppColors.backgroundColor(context),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            const Spacer(),
                            Text('COLEGIO DE INGENIEROS DEL PERÚ',
                                style: AppTextStyle(context).bold16()),
                            const Text('Consejo Departamental de Lambayeque'),
                            const SizedBox(
                              height: 15.0,
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                Positioned(
                    top: 300.0,
                    child: Container(
                      // color: Colors.amber,
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OptionTypePay(
                                  text: 'Cuotas mensuales',
                                  icon: Bootstrap.calendar2_check,
                                  context: context,
                                  colorBackIcon:
                                      const Color.fromRGBO(108, 14, 16, .5),
                                  colorIcon: const Color.fromRGBO(108, 14, 16, 1),
                                  ontap: () {
                                    context.push(AppRoutesName.MONTHLYFEES);
                                  }, whatPlatformIs: 0,  
                                  ),
                              OptionTypePay(
                                  text: 'Certificado de habilidad',
                                  icon: Bootstrap.award,
                                  context: context,
                                  colorBackIcon:
                                      const Color.fromRGBO(215, 181, 109, .5),
                                  colorIcon:
                                      const Color.fromRGBO(215, 181, 109, 1),
                                  ontap: () {
                                    context.push(AppRoutesName.CERTIFICATESKILL);
                                  }, whatPlatformIs: 0,),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OptionTypePay(
                                  text: 'Constancia de no adeudo',
                                  icon: Bootstrap.file_earmark_text,
                                  context: context,
                                  colorBackIcon:
                                      const Color.fromRGBO(42, 42, 41, .5),
                                  colorIcon: const Color.fromRGBO(42, 42, 41, 1),
                                  ontap: () {
                                    context.push(AppRoutesName.PROOFNODEBT);
                                  }, whatPlatformIs: 0,),
                              OptionTypePay(
                                  text: 'Adelanto de cuotas',
                                  icon: Bootstrap.cash_stack,
                                  context: context,
                                  colorBackIcon:
                                      const Color.fromRGBO(227, 30, 36, .5),
                                  colorIcon: const Color.fromRGBO(227, 30, 36, 1),
                                  ontap: () {
                                    context.push(AppRoutesName.ADVANCEPAYMENT);
                                  }, whatPlatformIs: 0,),
                            ],
                          )
                        ],
                      ),
                    )),
                    Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const AppBarHome(),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Hola, ${person?.namePerson}',
                                        style: AppTextStyle(context).bold22(),
                                      ),
                                      Text(
                                        'N° ${person?.numberCip}',
                                        style: AppTextStyle(context)
                                            .bold17(fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  )),
              ],
            ),
          ),
        ));
  }
}
