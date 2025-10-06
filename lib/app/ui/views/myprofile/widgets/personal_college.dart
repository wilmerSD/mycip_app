import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field/display_text.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/data_table_college.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalCollege extends StatelessWidget {
  const PersonalCollege({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;

    /* 📌 Input cip del colegiado */
    Widget inputCollege = DisplayText(
      helperText: 'Numero Cip',
      text: person?.numberCip ?? '',
    );

    /* 📌 Input fecha de ingreso al colegio de ingenieros */
    Widget inputEntryDate = DisplayText(
      helperText: 'Fecha de ingreso',
      text: Helpers.timestampToString(person?.dataEntryPerson),
    );

    /* 📌 Input catidad de años del colegiado*/
    Widget inputQuantityAges = DisplayText(
      helperText: 'Años de colegiado',
      text: authProvider.yearsOfMembership.toString(),
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
          title: 'Colegiatura',
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                inputCollege,
                const SizedBox(
                  height: 25.0,
                ),
                inputEntryDate,
                const SizedBox(
                  height: 25.0,
                ),
                inputQuantityAges,
                const SizedBox(
                  height: 25.0,
                ),
                // Container(
                //   height: 200,
                //   child: DataTableCollege(),
                // ),
                const SizedBox(
                  height: 160,
                  // color: Colors.amber,
                  child: ClipRRect(
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
