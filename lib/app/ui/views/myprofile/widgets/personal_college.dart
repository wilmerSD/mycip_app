import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_controller.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/data_table_college.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalCollege extends StatelessWidget {
const PersonalCollege({ super.key });

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileController>(context);

    /* 📌 Input cip del colegiado */
    Widget inputCollege = CustomTextField(
      enabledfield: true,
      helperText: 'Numero Cip',
      textEditingController: recoverpassController.ctrlCipNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
    
    /* 📌 Input fecha de ingreso al colegio de ingenieros */
    Widget inputEntryDate = CustomTextField(
      enabledfield: true,
      helperText: 'Fecha de ingreso',
      privateText: recoverpassController.isVisiblePass,
      textEditingController: recoverpassController.ctrlEntryDate,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
   
    /* 📌 Input catidad de años del colegiado*/
    Widget inputQuantityAges = CustomTextField(
      enabledfield: true,
      helperText: 'Años de colegiado',
      textEditingController: recoverpassController.ctrlQuantityAge,
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
          title: const CustomTittleAppbar(tittle: 'Colegiatura'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 25.0,),
                 inputCollege,
                const SizedBox(height: 25.0,),
                inputEntryDate,
                const SizedBox(height: 25.0,),
                inputQuantityAges,
                const SizedBox(height: 25.0,),
                // Container(
                //   height: 200,
                //   child: DataTableCollege(),
                // ),
                 Container(
                  height: 160,
                  // color: Colors.amber,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: DataTableCollege(),
                  ),
                )

                // Spacer(),
              ],
            ),
          ),
        ));
  }
}
