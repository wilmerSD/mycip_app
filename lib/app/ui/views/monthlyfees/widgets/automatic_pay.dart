import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AutomaticPay extends StatelessWidget {
const AutomaticPay({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          const Text('Configura el pago automático y despreocúpate de pagar cada mes.'),
          _customContainer(Bootstrap.rainbow, 'El débito se realizará a los 15 días despues de generado el recibo'),
          _customContainer(Bootstrap.rainbow, 'Te mantendremos informado de medio de un SMS cada vez que se realice el pago de tu recibo.'),
          _customContainer(Bootstrap.rainbow, 'En caso tu tarjeta sea rechazada por tu banco o financiera, te alergtaremos por medio de un sms.'),
          _customContainer(Bootstrap.rainbow, 'En caso quieras modificar tu afiliación, puedes cancelarlos desde aqui.'),
        ],
      ),
    );
  }
}

Widget _customContainer(IconData icon, String text) {

  return Row(
    children: [
      Icon(icon),
      Text(text)
    ],
  );
}