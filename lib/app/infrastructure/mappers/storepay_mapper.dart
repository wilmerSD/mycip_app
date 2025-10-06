import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_quota_model.dart';

class StorepayMapper {
  static Storepay storepayResponseToEntity(PaymentQuotaModel storepay) =>
  Storepay(
    creationDatePay: storepay.creationDatePay,
    locationCityPay: storepay.locationCityPay ?? '',
    locationCountryPay: storepay.locationCountryPay ?? '',
    paymentState: storepay.paymentState ?? false,
    paymentValue: storepay.paymentValue?.toInt() ?? 0,
    personId: storepay.personId ?? '',
    platformPayment: storepay.platformPayment ?? '',
    quantityPayment: storepay.quantityPayment?.toInt() ?? 0,
    receiptType: storepay.receiptType ?? 0,
    typePay: storepay.typePay ?? 0,
    paymentChannel: storepay.paymentChannel ?? 0,
    rucId: storepay.rucId ?? '',
    feeMonth: storepay.feeMonth ?? 0,
    feeYear: storepay.feeYear ?? 0,
    specialtyId: storepay.specialtyId ?? '',
  );
}