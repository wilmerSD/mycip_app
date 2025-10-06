import 'package:cip_payment_app/app/domain/datasources/payment_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/payment.dart';
import 'package:cip_payment_app/app/domain/entities/quota.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/domain/entities/token.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/payment_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/quota_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/storepay_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/token_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/models/culqi/culqi_payment_response.dart';
import 'package:cip_payment_app/app/infrastructure/models/culqi/culqi_token_response.dart';
import 'package:cip_payment_app/app/infrastructure/models/quota_model.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_quota_model.dart';
import 'package:cip_payment_app/app/infrastructure/models/storepay_model.dart';
import 'package:cip_payment_app/core/config/environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentdbDatasource extends PaymentDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;
  
  @override
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  }) async {
    // try{
    //TODO envolver con try catch para ver el posible error
    final url = Uri.parse("https://api.culqi.com/v2/tokens");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json", // importante
      "Authorization":
          "Bearer ${Environment.publicKeyCulqi}", // Reemplaza con tu llave pública real
    };

    final body = {
      "card_number": cardNumber,
      "cvv": cvv,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "email": email,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final tokenResponse = CulqiTokenResponse.fromJson(data);
      final token = TokenMapper.tokenResponseToEntity(tokenResponse);
      return token;
    } else {
      debugPrint("Error creando token: ${response.body}");
      return null;
    }
    // }catch(e){
    //   Tro
    // }
  }

  @override
  Future<Payment?> payCulqi(String token, int amount, String email) async {
    //TODO envolver con try catch para ver el posible error
    final response = await http.post(
      Uri.parse("http://192.168.100.89:8080/pago"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": token,
        "amount": amount, // S/10.00
        "email": email, //"usuario@example.com",
      }),
    );
    final data = jsonDecode(response.body);
    final paymentResponse = CulqiPaymentResponse.fromJson(data);
    final payment = PaymentMapper.paymentResponseToEntity(paymentResponse);
    return payment;
  }

   @override
  Future<List<Quota>?> payQuotas(List<PaymentQuotaModel> quotasToPay) async {
    try {
      final List<Quota> paidQuotas = [];

      for (final quotaModel in quotasToPay) {
        final response = await FirebaseFirestore.instance
            .collection('Payment')
            .add(quotaModel.toJson());

        if (response.id.isNotEmpty) {
          final snapshot = await response.get();
          final data = snapshot.data() as Map<String, dynamic>;

          final quotaResponse = QuotaModel.fromFirestore(data);
          final quota = QuotaMapper.quotaResponseToEntity(quotaResponse);

          paidQuotas.add(quota);
        }
      }

      debugPrint('✅ ${paidQuotas.length} cuotas pagadas exitosamente');
      return paidQuotas;
    } catch (e) {
      debugPrint('❌ Error al crear pagos: $e');
      return null;
    }
  }

    @override
  Future<List<Storepay>?> historyPaymentQuotas(String personId, int typePay) async {
    try {
      final snapshot = await firestoredb
          .collection('Payment')
          .where('personId', isEqualTo: personId)
          .where('typePay', isEqualTo: typePay)
          .get();
      
      final paymentQuotaResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return PaymentQuotaModel.fromJson(data);
      }).toList();
      // print(paymentQuotaResponse);
      final paymentQuotas = paymentQuotaResponse
          .map((resp) => StorepayMapper.storepayResponseToEntity(resp))
          .toList();
      return paymentQuotas;
    } catch (e) {
      debugPrint("Error al obtener las cuotas pendientes de la persona : $e");
      return [];
    } 
  }
}
