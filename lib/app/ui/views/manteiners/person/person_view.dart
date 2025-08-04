import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/views/manteiners/person/person_provider.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:cip_payment_app/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PersonProvider(),
        child: Consumer<PersonProvider>(builder: (context, personProvider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor(context),
              appBar: AppBar(
                backgroundColor: AppColors.backgroundColor(context),
                surfaceTintColor: Colors.transparent,
                leading: const Leading(),
                title: const CustomTittleAppbar(tittle: 'Colegiatura'),
              ),
              body: Column(
                // spacing: 20.0,
                children: [
                  // SizedBox(height: 20.0,),
                  Container(
                    width: 200.0,
                    padding: const EdgeInsets.all(20.0),
                    child: BtnPrimaryInk(
                        text: 'Nueva persona',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PopupGeneral(
                                  title: 'Ingresar persona',
                                  onTapButton: () {},
                                  scrollable: true,
                                  content:
                                      _formPerson(context, personProvider));
                            },
                          );
                        }),
                  )
                ],
              )
              // _formPerson(context),
              );
        }));
  }
}

Widget _formPerson(BuildContext context, personProvider) {
  // final personProvider = context.watch<PersonProvider>();
  return Container(
    width: 600,
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    child: Column(
      spacing: 15,
      children: [
        CustomTextField(
          helperText: 'Dirección',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Estado civil',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Fecha de nacimiento',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'DNI',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Email principal',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Email secundario',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Género',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Apellido paterno',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Apellido materno',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Nombre',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Ruc',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        CustomTextField(
          helperText: 'Especialidad',
          textEditingController:
              personProvider.dni, // context.read<PersonProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    ),
  );
}
