import 'package:cip_payment_app/app/domain/entities/payment.dart';
import 'package:cip_payment_app/app/domain/entities/quota.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/domain/entities/token.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_quota_model.dart';

abstract class PaymentRepository {
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  });
  Future<Payment?>  payCulqi(String token, int amount, String email);
  Future<List<Quota>?> payQuotas(List<PaymentQuotaModel> paymentQuotaModel);
  Future<List<Storepay>?> historyPaymentQuotas(String personId, int typePay);
}