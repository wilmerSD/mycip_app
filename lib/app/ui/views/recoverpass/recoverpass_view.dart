import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field_form.dart';
import 'package:cip_payment_app/app/ui/views/login/login_controller.dart';
import 'package:cip_payment_app/core/helpers/navigator_view.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class RecoverpassView extends StatelessWidget {
  const RecoverpassView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya que se está utilizando Provider, no necesitas definirlo de nuevo aquí.
    final loginController = Provider.of<LoginController>(context);
    Widget imageLogo = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/LOGO_CIP.png'), // Reemplaza con tu imagen
          fit: BoxFit.cover,
        ),
      ),
    );
    Widget identificationNumber = FieldForm(
      label: "DNI",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlDni,
    );

    Widget nameUser = FieldForm(
      label: "Colegiado",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlName,
    );

    Widget emailUser = FieldForm(
      label: "Correo",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlEmail,
    );

    Widget button = BtnPrimaryInk(
      text: "Enviar contraseña",
      onTap: () {
        NavigatorView.goToHome(context);
      },
      /*onTap: () =>  controller.validateForm(context) */
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: 400.0,
              height: 630.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Lottie.network(
                      'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
                  const SizedBox(height: 20.0),
                  // Título
                  const Text('MiCIP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryConst,
                      )),
                  const SizedBox(height: 25.0),
                  // dni
                  identificationNumber,
                  const SizedBox(height: 25.0),
                  // nombre
                  nameUser,
                  const SizedBox(height: 25.0),
                  //correo
                  emailUser,
                  const SizedBox(height: 25.0),
                  //Boton
                  button,
                  const SizedBox(height: 25.0),
                  InkWell(
                    onTap: () => NavigatorView.goToLogin(context),
                    child: Text('Regresar a  inicio de sesión',
                        style: AppTextStyle(context)
                            .bold14(color: AppColors.primaryConst)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
