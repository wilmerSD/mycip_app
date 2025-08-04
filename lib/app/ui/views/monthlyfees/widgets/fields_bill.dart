import 'package:cip_payment_app/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldsBill extends StatelessWidget {
const FieldsBill({ super.key });

  @override
  Widget build(BuildContext context){
    final monthlyfeesController = Provider.of<MonthlyfeesController>(context);
    /* 📌 Input cip del colegiado */
    Widget inputRuc = CustomTextField(
      helperText: 'Ruc',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

     Widget inputCompanyName = CustomTextField(
      helperText: 'Razón social',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
    Widget inputIndustry = CustomTextField(
      helperText: 'Giro, Industria',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
    Widget inputAddress = CustomTextField(
      helperText: 'Dirección',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
    Widget inputDepartment = CustomTextField(
      helperText: 'Departamento',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );
    Widget inputDistrict = CustomTextField(
      helperText: 'Distrito',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 20.0,
        children: [
         inputRuc,
          inputCompanyName,
          inputIndustry,
          inputAddress,
          inputDepartment,
          inputDistrict
      ],),
    );
  }
}