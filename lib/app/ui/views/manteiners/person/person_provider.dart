import 'package:cip_payment_app/app/models/person_model.dart';
import 'package:cip_payment_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class PersonProvider with ChangeNotifier {
  TextEditingController dni = TextEditingController(text: '');
  TextEditingController address = TextEditingController(text: '');
  TextEditingController civilStatus = TextEditingController(text: '');
  TextEditingController dateBirth = TextEditingController(text: '');
  TextEditingController emailMain = TextEditingController(text: '');
  TextEditingController emailSecondary = TextEditingController(text: '');
  TextEditingController genderPerson = TextEditingController(text: '');
  TextEditingController imagePerson = TextEditingController(text: '');
  TextEditingController motherSurname = TextEditingController(text: '');
  TextEditingController nacionality = TextEditingController(text: '');
  TextEditingController namePerson = TextEditingController(text: '');
  TextEditingController numberCip = TextEditingController(text: '');
  TextEditingController numberPhone = TextEditingController(text: '');
  TextEditingController paternalSurname = TextEditingController(text: '');
  TextEditingController personId = TextEditingController(text: '');
  TextEditingController ruc = TextEditingController(text: '');
  TextEditingController specialityId = TextEditingController(text: '');

  Future<void> newPerson() async {
    try {
      final response = await createPerson(PersonModel(
          id: '',
          address: address.text,
          civilStatus: civilStatus.text,
          dataEntryPerson: Timestamp.fromDate(DateTime.now()) ,
          dateBirth: Timestamp.fromDate(DateTime.now()),
          dni: dni.text,
          emailMain: emailMain.text,
          emailSecondary: emailSecondary.text,
          genderPerson: genderPerson.text,
          imagePerson: imagePerson.text,
          motherSurname: motherSurname.text,
          nacionality: nacionality.text,
          namePerson: namePerson.text,
          numberCip:numberCip.text,
          numberPhone: numberPhone.text,
          paternalSurname: paternalSurname.text,
          personId: '',
          ruc: ruc.text));
    } catch (e) {
    } finally {}
  }

  String prueba = 'Hola';
}
