import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentQuotaModel {
    final Timestamp? creationDatePay;
    final String? deviceInfoPay;
    final String? ipAddressPay;
    final String? locationCityPay;
    final String? locationCountryPay;
    final LocationPay? locationPay;
    final Timestamp? paymentDate;
    final bool? paymentState;
    final double? paymentValue;
    final String? personId;
    final String? platformPayment;
    final int? quantityPayment;
    final int? receiptType;
    final int? typePay;
    final int? paymentChannel;
    final String? rucId;
    final int? feeMonth;
    final int? feeYear;

    PaymentQuotaModel({
        this.creationDatePay,
        this.deviceInfoPay,
        this.ipAddressPay,
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

    factory PaymentQuotaModel.fromJson(Map<String, dynamic> json) => PaymentQuotaModel(
        creationDatePay: json["creationDatePay"],
        deviceInfoPay: json["deviceInfoPay"],
        ipAddressPay: json["ipAddressPay"],
        locationCityPay: json["locationCityPay"],
        locationCountryPay: json["locationCountryPay"],
        locationPay: json["locationPay"] == null ? null : LocationPay.fromJson(json["locationPay"]),
        paymentDate: json["paymentDate"],
        paymentState: json["paymentState"],
        paymentValue: json["paymentValue"]?.toDouble(),
        personId: json["personId"],
        platformPayment: json["platformPayment"],
        quantityPayment: json["quantityPayment"],
        receiptType: json["receiptType"],
        typePay: json["typePay"],
        paymentChannel: json["paymentChannel"],
        rucId: json["rucId"],
        feeMonth: json["feeMonth"],
        feeYear: json["feeYear"],
       
    );

    Map<String, dynamic> toJson() => {
        "creationDatePay": creationDatePay,
        "deviceInfoPay": deviceInfoPay,
        "ipAddressPay": ipAddressPay,
        "locationCityPay": locationCityPay,
        "locationCountryPay": locationCountryPay,
        "locationPay": locationPay?.toJson(),
        "paymentDate": paymentDate,
        "paymentState": paymentState,
        "paymentValue": paymentValue,
        "personId": personId,
        "platformPayment": platformPayment,
        "quantityPayment": quantityPayment,
        "receiptType": receiptType,
        "typePay": typePay,
        "paymentChannel": paymentChannel,
        "rucId": rucId,
        "feeMonth": feeMonth,
        "feeYear": feeYear,
    };
}

class LocationPay {
    final int? latitude;
    final int? longitude;

    LocationPay({
        this.latitude,
        this.longitude,
    });

    factory LocationPay.fromJson(Map<String, dynamic> json) => LocationPay(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}