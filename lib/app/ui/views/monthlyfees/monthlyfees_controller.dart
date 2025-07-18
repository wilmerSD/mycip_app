import 'dart:convert';
import 'dart:io';

import 'package:cip_payment_app/services/culqi_service.dart';
import 'package:flutter/material.dart';

class MonthlyfeesController with ChangeNotifier {
  int _selectedIndex = 0;
  final PageController pageController = PageController();
    int get selectedIndex => _selectedIndex;

  CulqiService culquiServise = CulqiService();

  TextEditingController ctrlCardNumber = TextEditingController(text: '4111111111111111');
  TextEditingController ctrlCvv = TextEditingController(text: '123');
  TextEditingController ctrlExpirationMonth = TextEditingController(text: '12');
  TextEditingController ctrlExpirationYear = TextEditingController(text: '2030');
  TextEditingController ctrlEmail = TextEditingController(text: 'review@culqi.com');
  double amount = 1000.0;

  Future<void> createToken() async {
    String? token = await culquiServise.crearTokenCulqi(
        cardNumber: ctrlCardNumber.text,
        cvv: ctrlCvv.text,
        expirationMonth: ctrlExpirationMonth.text,
        expirationYear: ctrlExpirationYear.text,
        email: ctrlEmail.text);
        print(token);
    if (token != null) {
      
      culquiServise.payCulqui(token,amount,ctrlEmail.text);// Enviar este token a tu backend para crear el cargo
      
    } else {
      // Mostrar error al usuario
    }
  }

  Future<void> pagar() async{
    final token = await crearTokenCulqi();
    final response = await culquiServise.payCulqui(token ?? '', amount,ctrlEmail.text);// Enviar este token a tu backend para crear el cargo
    print(response);
  }

  Future<String?> crearTokenCulqi() async {
    final uri = Uri.parse("https://api.culqi.com/v2/tokens");
    final client = HttpClient();

    final req = await client.postUrl(uri);
    req.headers.set('Content-Type', 'application/json');
    req.headers.set('Authorization', 'Bearer pk_test_sKWDD6bVub17VOqt');

    req.add(utf8.encode(json.encode({
      "card_number":  ctrlCardNumber.text,
      "cvv":  ctrlCvv.text,
      "expiration_month": ctrlExpirationMonth.text,
      "expiration_year": ctrlExpirationYear.text,
      "email": ctrlEmail.text,
    })));

    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    client.close();

    if (res.statusCode == 201) {
      final data = json.decode(body);
      print(data['id']);
      return data['id'];
    } else {
      print("Error creando token (HttpClient): $body");
      return null;
    }
  }


  void selectTab(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
