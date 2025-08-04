import 'package:cip_payment_app/app/ui/views/iepi/prueba.dart';
import 'package:flutter/material.dart';

class IepiController with ChangeNotifier{
 Future goToPrueba(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Prueba()));
  }
}