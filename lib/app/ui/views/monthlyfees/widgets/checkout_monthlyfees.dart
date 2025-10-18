// import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
// import 'package:cip_payment_app/app/ui/components/field/custom_text_field.dart';
// import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CheckoutMonthlyfees extends StatelessWidget {
//   const CheckoutMonthlyfees({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final monthlyfeesProvider = Provider.of<MonthlyfeesProvider>(context);

//     /* 📌 Input cip del colegiado */
//     Widget inputCardNumber = CustomTextField(
//       helperText: 'Número de tarjeta',
//       textEditingController: monthlyfeesProvider.ctrlCardNumber,
//       onEditingComplete: () {
//         FocusScope.of(context).unfocus();
//         // Lógica para validar el formulario
//       },
//     );

//     /* 📌 Input cip del colegiado */
//     Widget inputCcv = CustomTextField(
//       helperText: 'CCV',
//       textEditingController: monthlyfeesProvider.ctrlCvv,
//       onEditingComplete: () {
//         FocusScope.of(context).unfocus();
//         // Lógica para validar el formulario
//       },
//     );

//     /* 📌 Input cip del colegiado */
//     Widget inputCollege = CustomTextField(
//       helperText: 'Mes de exp',
//       textEditingController: monthlyfeesProvider.ctrlExpirationMonth,
//       onEditingComplete: () {
//         FocusScope.of(context).unfocus();
//         // Lógica para validar el formulario
//       },
//     );

//     /* 📌 Input cip del colegiado */
//     Widget inputExpirationYear = CustomTextField(
//       helperText: 'Año de exp',
//       textEditingController: monthlyfeesProvider.ctrlExpirationYear,
//       onEditingComplete: () {
//         FocusScope.of(context).unfocus();
//         // Lógica para validar el formulario
//       },
//     );

//     /* 📌 Input cip del colegiado */
//     Widget inputEmail = CustomTextField(
//       helperText: 'Email',
//       textEditingController: monthlyfeesProvider.ctrlEmail,
//       onEditingComplete: () {
//         FocusScope.of(context).unfocus();
//         // Lógica para validar el formulario
//       },
//     );

//     Widget btnPay = BtnPrimaryInk(text: 'Pagar S/. 30.0', onTap: () {
//       // monthlyfeesProvider.pagar(context);
//       // monthlyfeesController.crearTokenCulqi();
      
//     });

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       width: 900,
//       child: Column(
//         spacing: 10.0,
//         children: [
//           inputCardNumber,
//           inputCcv,
//           inputCollege,
//           inputExpirationYear,
//           inputEmail,
//           const Spacer(),
//           btnPay,
//           const SizedBox(height: 10,),
//         ],
//       ),
//     );
//   }
// }
