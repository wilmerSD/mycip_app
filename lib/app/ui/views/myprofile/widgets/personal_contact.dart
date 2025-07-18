import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_controller.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalContact extends StatelessWidget {
  const PersonalContact({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileController>(context);

    /* 📌 Input de colegiado */
    Widget inputAddress = CustomTextField(
      enabledfield: true,
      helperText: 'Dirección',
      textEditingController: recoverpassController.ctrlAddress,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input de dni */
    Widget inputPhoneNumber = CustomTextField(
      enabledfield: true,
      helperText: 'Celular',
      privateText: recoverpassController.isVisiblePass,
      textEditingController: recoverpassController.ctrlPhoneNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
   
    /* 📌 Input de dni */
    Widget inputEmail = CustomTextField(
      enabledfield: true,
      helperText: 'Correo electrónico',
      textEditingController: recoverpassController.ctrlEmail,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

 
    /* 📌 btn para cambiar la contraseña */
    Widget btnChangePass = BtnPrimaryInk(
      text: recoverpassController.isLoading
          ? "Cambiando..."
          : "Cambiar contraseña",
      loading: recoverpassController.isLoading,
      onTap: () => {},
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor(context),
          surfaceTintColor:Colors.transparent, 
          leading: const Leading(),
          title: const CustomTittleAppbar(tittle: 'Contacto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 25.0,),
                       inputAddress,
                      const SizedBox(height: 25.0,),
                      inputPhoneNumber,
                      const SizedBox(height: 25.0,),
                      inputEmail,
                      const SizedBox(height: 25.0,),                     
                    ],
                  ),
                ),
                btnChangePass
                // SizedBox(
                //   height: 20.0, child: btnChangePass),
              ],
            ),
          ),
        ));
  }
}
