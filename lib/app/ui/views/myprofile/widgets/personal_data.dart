import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/components/field_form.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_controller.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/text_tittle.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileController>(context);

    /* 📌 Input de colegiado */
    Widget inputCollege = CustomTextField(
      enabledfield: true,
      helperText: 'Colegiado',
      label: "Nueva contraseña",
      hintText: "contraseña",
      privateText: recoverpassController.isVisiblePass,
      textEditingController: recoverpassController.ctrlFullName,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input de dni */
    Widget inputDni = CustomTextField(
      enabledfield: true,
      helperText: 'DNI',
      label: "Nueva contraseña",
      hintText: "contraseña",
      privateText: recoverpassController.isVisiblePass,
      textEditingController: recoverpassController.ctrlDni,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input de dni */
    Widget inputAge = CustomTextField(
      enabledfield: true,
      helperText: 'Edad',
      textEditingController: recoverpassController.ctrlAge,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input de dni */
    Widget inputGender= CustomTextField(
      enabledfield: true,
      helperText: 'Género',
      textEditingController: recoverpassController.ctrlGender,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputCivilState = CustomTextField(
      enabledfield: true,
      helperText: 'Estado civil',
      textEditingController: recoverpassController.ctrlCivilState,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputBirthDate = CustomTextField(
      enabledfield: true,
      helperText: 'Fecha de nacimiento',
      textEditingController: recoverpassController.ctrlBirthdate,
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
          title: const CustomTittleAppbar(tittle: 'Datos personales'), 
        
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const SizedBox(height: 25.0,),
              inputCollege,
              const SizedBox(height: 25.0,),
              inputDni,
              const SizedBox(height: 25.0,),
              inputAge,
              const SizedBox(height: 25.0,),
              inputGender,
              const SizedBox(height: 25.0,),
              inputCivilState,
              const SizedBox(height: 25.0,),
              inputBirthDate,
              const SizedBox(height: 25.0,),
            ],
          ),
        ));
  }
}
