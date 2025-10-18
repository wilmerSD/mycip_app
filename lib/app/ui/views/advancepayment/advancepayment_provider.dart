import 'dart:ffi';

import 'package:cip_payment_app/app/domain/entities/deviceinfo.dart';
import 'package:cip_payment_app/app/domain/entities/enums.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_model.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/providers/infodevice_provider.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_checkout.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/payment/payment_good.dart';
import 'package:cip_payment_app/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/culqi_checkout.dart';
import 'package:cip_payment_app/core/config/environment.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl =
      QuotaRepositoryImpl(QuotadbDatasource());
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  final String symbolMoney = 'S/. ';

  String ctrlValueOfQuota = 'S/. 30.0';
  String ctrlPercentDiscount = '5%';
  String ctrlEnabledUntil = 'Noviembre del 2024';
  String ctrlSubTotal = 'S/. 270';
  String ctrlDiscount = 'S/. 30';

  TextEditingController ctrlLastPay =
      TextEditingController(text: 'Agosto de 2024');
  TextEditingController ctrlQuantityCuotas = TextEditingController(text: '12');
  final PageController pageController = PageController();
  TextEditingController ctrlTotal = TextEditingController(text: 'S/. 240');

  double totalToPay = 0;
  double valueOfQuota = 30.0;
  Future<void> onInit(BuildContext context) async {
    getInfoDevice(context);
    await getDataPerson();
    hasQuotasPending(context);
    getHistoryQuotasPayment(context);
    getHistoryPayment(context);
    print('antes de calcular el pago');
    calculateToPay();
    // totalToPay = double.parse(ctrlQuantityCuotas.text) * ;
  }

  String personId = '';
  String mainEmail = '';
  Future<void> getDataPerson() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
  }
/*     Future<void> openCheckout(BuildContext context) async {
    try {
      final int amountRound = Helpers.toCents(totalToPay);
      final token = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return PopupCheckout(
              onTapButton: () {},
              content: CulqiCheckout(
                publicKey: Environment.publicKeyCulqi,
                amount: amountRound,
                currency: 'PEN',
                email: 'culqitest@gmail.com',
              ),
            );
          });
      if (token != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        debugPrint(token);
        final payCompleted = await paymentRepositoryImpl.payCulqi(
          token,
          amountRound,
          mainEmail,
        );
        Navigator.of(context).pop(); // cierra el loader
        if (payCompleted != null) {
          if (payCompleted.succces) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return PopupCheckout(
                  title: '',
                  onTapButton: () {},
                  scrollable: false,
                  content: PaymentGood(
                    payCompleted.creationDate ?? 0,
                    totalToPay,
                    textCertificateskill,
                    PaymentType.certificateskill.code,
                  ),
                );
              },
            );
            //TODO: GUARDAR EN LA TABLA DE PAYMENT EL PAGO REALIZADO
            //TODO: GENERAR LOS PAGOS ADELANTADOS EN LA TABLA MEMBER FEE
            final cuantityCert = int.parse(quantityCertificate.text);
            List<PaymentModel> paymentQuotaModels =
                List.generate(cuantityCert, (index) {
              return PaymentModel(
                creationDatePay: Timestamp.fromDate(DateTime.now()),
                deviceInfoPay: deviceInfo?.nameDevice ?? '',
                ipAddressPay: deviceInfo?.ip ?? '',
                locationCityPay: deviceInfo?.nameCity ?? '',
                locationCountryPay: deviceInfo?.nameCountry ?? '',
                locationPay: GeoPoint(
                    deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0.0),
                paymentState: true,
                paymentValue: valueCertificate, // el monto del certificado
                personId: personId,
                platformPayment: PlatformPayment.app.name,
                quantityPayment: 1, // cada uno representa un certificado
                receiptType: receiptType, //ReceiptType.bill.code,
                typePay: PaymentType.certificateskill.code,
                paymentChannel: PaymentChannel.online.code,
                rucId: rucId,
                feeMonth: 0,
                feeYear: 0,
                specialtyId: currectSpecialty.id,
              );
            });
            await paymentRepositoryImpl.payQuotas(paymentQuotaModels);
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return PopupCheckout(
                  title: '',
                  onTapButton: () {},
                  scrollable: false,
                  content: PaymentBad(
                    Helpers.generateRandomOperationNumber(),
                    Helpers.formatCustomDate(payCompleted.creationDate),
                    payCompleted.userMessage ?? '',
                  ),
                );
              },
            );
          }
        }
      }
    } catch (e) {
    } finally {
      cleanVariables();
    }
  } */

  bool stateCollegiate = false;
  Future<void> hasQuotasPending(BuildContext context) async {
    stateCollegiate = true;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
      haveQuotasPending = response;
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: WarningPay(
                  'Para poder generar tu certificado de habilidad debe pagar su deuda pendiente.'),
            );
          },
        );
        stateCollegiate = false; // Deshabilitado
      }
      //TODO: si es false entonces hacer la petición hasta cuando esta habilitado
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
    } finally {
      notifyListeners();
      // haveQuotasPending = false;
    }
  }

  bool isGettinHistory = false;
  List<Storepay> paymentHistory = [];

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistory.clear();
    isGettinHistory = true;

    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.certificateskill.code);
      if (response == null) {
        return;
      }
      paymentHistory.addAll(response);
      paymentHistory.sort((a, b) => (b.feeMonth ?? 0)
          .compareTo(a.feeMonth ?? 0)); //Ordena de mayor a menor
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }

  List<Storepay> paymentHistoryQuotas = [];
  String enabledUntil = '-';
  Future<void> getHistoryQuotasPayment(BuildContext context) async {
    paymentHistoryQuotas.clear();
    enabledUntil = '-';
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.monthlyFees.code);
      if (response == null || response.isEmpty) {
        return;
      }
      paymentHistoryQuotas.addAll(response);
      paymentHistoryQuotas
          .sort((a, b) => (b.feeMonth ?? 0).compareTo(a.feeMonth ?? 0));

      final mayor = paymentHistoryQuotas.first;

      enabledUntil =
          '${Helpers.getNameMonth(mayor.feeMonth ?? 0)} del ${mayor.feeYear}';
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  int quantityCuotas = 0;
  double discount = 0.0;
  double subTotal = 0.0;

  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false)
        .deviceInfo();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  String wouldEnableUntil = '';
  int currentMonth = DateTime.now().month;
  void calculateToPay() {
    print('asdasdajsdlksadjljjlk');
    quantityCuotas = int.tryParse(ctrlQuantityCuotas.text) ?? 0;
    subTotal = (valueOfQuota * quantityCuotas);
    discount = subTotal * 0.05;
    totalToPay = subTotal - discount;

    ctrlDiscount = symbolMoney + discount.toString();
    ctrlSubTotal = symbolMoney + subTotal.toString();
    calculateEnabledUntil();
    notifyListeners();
  }

  void calculateEnabledUntil() {
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;

    int totalMonths = currentMonth + quantityCuotas;

    // Calculamos el nuevo mes y año
    int newYear = currentYear + ((totalMonths - 1) ~/ 12);
    int newMonth = ((totalMonths - 1) % 12) + 1;

    String mesNombre = Helpers.getNameMonth(newMonth);

    wouldEnableUntil = '$mesNombre del $newYear';
  }

  String rucId = '';
  int receiptType = 0; //0 boleta, 1: facura
  void cleanVariables() {
    rucId = '';
    receiptType = 0;
  }
}
