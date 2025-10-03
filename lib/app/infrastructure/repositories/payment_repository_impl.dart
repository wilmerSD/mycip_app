import 'package:cip_payment_app/app/domain/datasources/payment_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/payment.dart';
import 'package:cip_payment_app/app/domain/entities/quota.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/domain/entities/token.dart';
import 'package:cip_payment_app/app/domain/repositories/payment_repository.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_quota_model.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDatasource datasource;

  PaymentRepositoryImpl(this.datasource);

  @override
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  }) {
    return datasource.createTokenCulqi(
      cardNumber: cardNumber,
      cvv: cvv,
      expirationMonth: expirationMonth,
      expirationYear: expirationYear,
      email: email,
    );
  }

  @override
  Future<Payment?> payCulqi(String token, int amount, String email) {
    return datasource.payCulqi(token, amount, email);
  }

  @override
  Future<List<Quota>?> payQuotas(List<PaymentQuotaModel> paymentQuotaModel) {
    return datasource.payQuotas(paymentQuotaModel);
  }
  
  @override
  Future<List<Storepay>?> historyPaymentQuotas(String personId) {
     return datasource.historyPaymentQuotas(personId);
  }

  // @override
  // Future<List<Storepay>?> historyPaymentQuotas(String personId) {
  //   return datasource.historyPaymentQuotas(personId);
  // }

  
  
}
