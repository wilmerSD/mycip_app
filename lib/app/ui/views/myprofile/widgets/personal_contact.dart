import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field/display_text.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalContact extends StatelessWidget {
  const PersonalContact({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    
    /* 📌 Input de colegiado */
    Widget inputAddress = DisplayText(
      helperText: 'Dirección',
      text: person?.address ?? '',
    );

    /* 📌 Input de dni */
    Widget inputPhoneNumber = DisplayText(
      helperText: 'Celular',
      text: person?.numberPhone ?? '',
    );
   
    /* 📌 Input de dni */
    Widget inputEmail = DisplayText(
      helperText: 'Correo electrónico',
      text: person?.emailMain ?? '',
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
      appBar: const CustomAppBar(
          title: 'Contacto',
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
                // btnChangePass
                // SizedBox(
                //   height: 20.0, child: btnChangePass),
              ],
            ),
          ),
        ));
  }
}
