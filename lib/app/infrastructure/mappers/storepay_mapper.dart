import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/infrastructure/models/storepay_model.dart' hide LocationPay;

class StorepayMapper {
  static Storepay storepayResponseToEntity(StorepayModel storepay) =>
  Storepay(
    locationCityPay: storepay.locationCityPay ?? '',
    locationCountryPay: storepay.locationCountryPay ?? '',
    paymentDate: storepay.paymentDate,
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
  );
}