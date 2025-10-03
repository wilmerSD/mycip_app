import 'package:cloud_firestore/cloud_firestore.dart';

class Storepay {
    final String? locationCityPay;
    final String? locationCountryPay;
    final LocationPay? locationPay;
    final Timestamp? paymentDate;
    final bool? paymentState;
    final int? paymentValue;
    final String? personId;
    final String? platformPayment;
    final int? quantityPayment;
    final int? receiptType;
    final int? typePay;
    final int? paymentChannel;
    final String? rucId;
    final int? feeMonth;
    final int? feeYear;

    Storepay({
        this.locationCityPay,
        this.locationCountryPay,
        this.locationPay,
        this.paymentDate,
        this.paymentState,
        this.paymentValue,
        this.personId,
        this.platformPayment,
        this.quantityPayment,
        this.receiptType,
        this.typePay,
        this.paymentChannel,
        this.rucId,
        this.feeMonth,
        this.feeYear,
    });
}

class LocationPay {
    final int? latitude;
    final int? longitude;

    LocationPay({
        this.latitude,
        this.longitude,
    });
}
